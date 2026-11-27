import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/features/assistant/data/assistant_engine.dart';
import 'package:nuestra_app/features/assistant/data/assistant_history_repository.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_controller.dart';
import 'package:nuestra_app/features/assistant/presentation/chat_cards.dart';
import 'package:nuestra_app/features/assistant/domain/reply_suggestion.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

const _starterPrompts = [
  'Gasté 15.000 de nafta',
  '¿Cuánto gastamos este mes?',
  '¿Qué gastos fijos faltan?',
  'Una receta con pollo',
  'Arma el menú de la semana',
];

/// "ahora", "hace 5 min", "hace 2 h", "ayer", "3 nov".
String _relativeTime(DateTime? when, DateTime now) {
  if (when == null) return '';
  final diff = now.difference(when);
  if (diff.inMinutes < 1) return 'ahora';
  if (diff.inMinutes < 60) return 'hace ${diff.inMinutes} min';
  if (diff.inHours < 24 && now.day == when.day) return 'hace ${diff.inHours} h';
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  if (when.year == yesterday.year &&
      when.month == yesterday.month &&
      when.day == yesterday.day) {
    return 'ayer';
  }
  return DateFormat('d MMM', 'es').format(when);
}

/// The on-device assistant (Gemma 4): the model reads what you ask, the app
/// answers with cards built from your data. Conversations are shared by the
/// household.
class AssistantScreen extends ConsumerWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(assistantProvider);
    final controller = ref.read(assistantProvider.notifier);
    final isReady = state.modelStatus == ModelStatus.ready;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.assistant),
        actions: [
          if (isReady) ...[
            IconButton(
              icon: const Icon(Icons.forum_outlined),
              tooltip: 'Conversaciones del hogar',
              onPressed: () => _showConversations(context, ref),
            ),
            IconButton(
              icon: const Icon(Icons.edit_square),
              tooltip: 'Nueva conversación',
              onPressed: state.isBusy || state.entries.isEmpty
                  ? null
                  : controller.newConversation,
            ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'delete') {
                  final ok = await _confirmDelete(context);
                  if (ok) await controller.deleteModel();
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Borrar el modelo del teléfono'),
                ),
              ],
            ),
          ],
        ],
      ),
      body: switch (state.modelStatus) {
        ModelStatus.unsupported => const _Message(
            icon: Icons.phone_android,
            title: 'El asistente corre en tu teléfono',
            body: 'Usalo desde la app de Android o iOS.',
          ),
        ModelStatus.checking => const Center(child: CircularProgressIndicator()),
        ModelStatus.notInstalled || ModelStatus.downloading => _SetupView(state),
        ModelStatus.failed => _Message(
            icon: Icons.error_outline,
            title: 'No se pudo iniciar el asistente',
            body: state.error ?? '',
          ),
        ModelStatus.ready => _ChatView(state),
      },
    );
  }

  void _showConversations(BuildContext context, WidgetRef ref) {
    ref.read(assistantProvider.notifier).refreshConversations();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _ConversationsSheet(),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Borrar el modelo'),
        content: const Text(
          'Libera ${AssistantEngine.downloadSizeLabel}. Las conversaciones '
          'quedan guardadas. Para volver a usar el asistente vas a tener que '
          'descargarlo de nuevo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

/// The household's conversations. Picking one opens it on this phone only.
class _ConversationsSheet extends ConsumerWidget {
  const _ConversationsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(assistantProvider);
    final controller = ref.read(assistantProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    final currentId = state.conversationId;
    final currentIsSaved =
        state.conversations.any((c) => c.id == currentId);

    Widget openTag() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          ),
          child: Text(
            'Abierta',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        );

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.lg,
                0,
                AppSizes.md,
                AppSizes.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Conversaciones', style: textTheme.headlineSmall),
                        Text(
                          'Compartidas con tu hogar',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: state.isBusy
                        ? null
                        : () {
                            Navigator.pop(context);
                            controller.newConversation();
                          },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Nueva'),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: AppSizes.md),
                children: [
                  // The open conversation before its first message is saved
                  if (!currentIsSaved)
                    ListTile(
                      leading: const Icon(Icons.chat_bubble_outline),
                      title: Text(
                        state.entries.isEmpty
                            ? 'Conversación nueva'
                            : 'Conversación actual',
                      ),
                      subtitle: const Text('Todavía sin guardar'),
                      trailing: openTag(),
                      onTap: () => Navigator.pop(context),
                    ),
                  for (final c in state.conversations)
                    _ConversationTile(
                      conversation: c,
                      isOpen: c.id == currentId,
                      subtitle: [
                        if (c.startedBy != null) c.startedBy!.name,
                        _relativeTime(c.lastMessageAt, now),
                        '${c.messageCount} mensajes',
                      ].where((s) => s.isNotEmpty).join(' · '),
                      openTag: openTag(),
                      onTap: () {
                        Navigator.pop(context);
                        if (c.id != currentId) {
                          controller.switchConversation(c.id);
                        }
                      },
                    ),
                  if (state.conversations.isEmpty && currentIsSaved)
                    const Padding(
                      padding: EdgeInsets.all(AppSizes.lg),
                      child: Text('Todavía no hay conversaciones.'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final ConversationSummary conversation;
  final bool isOpen;
  final String subtitle;
  final Widget openTag;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.conversation,
    required this.isOpen,
    required this.subtitle,
    required this.openTag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final startedBy = conversation.startedBy;
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: startedBy != null
            ? AppColors.memberColor(startedBy.id)
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Text(
          startedBy != null && startedBy.name.isNotEmpty
              ? startedBy.name[0].toUpperCase()
              : '?',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(
        conversation.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: isOpen ? FontWeight.w700 : FontWeight.w500),
      ),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: isOpen ? openTag : null,
      onTap: onTap,
    );
  }
}

class _Message extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _Message({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: colorScheme.primary),
            const SizedBox(height: AppSizes.md),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

/// First run: explain the on-device model and download it.
class _SetupView extends ConsumerWidget {
  final AssistantState state;

  const _SetupView(this.state);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(assistantProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final downloading = state.modelStatus == ModelStatus.downloading;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.auto_awesome, size: 40, color: colorScheme.tertiary),
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              'Un asistente privado en tu teléfono',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              'Usa Gemma 4, un modelo de Google que corre en el teléfono: lo '
              'que le preguntas se procesa aquí y no se envía a ningún servicio '
              'de inteligencia artificial. Las conversaciones se comparten con '
              'tu hogar.\n\nSe descarga una sola vez '
              '(${AssistantEngine.downloadSizeLabel}); te recomendamos usar Wi-Fi.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSizes.xl),
            if (downloading) ...[
              LinearProgressIndicator(
                value: state.downloadPercent / 100,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                minHeight: 8,
              ),
              const SizedBox(height: AppSizes.sm),
              Text('Descargando… ${state.downloadPercent}%'),
              Text(
                'Si se corta, sigue desde donde quedó.',
                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
              ),
              const SizedBox(height: AppSizes.sm),
              TextButton(
                onPressed: controller.cancelDownload,
                child: const Text('Cancelar'),
              ),
            ] else
              FilledButton.icon(
                onPressed: controller.downloadModel,
                icon: const Icon(Icons.download),
                label: Text(state.downloadPercent > 0
                    ? 'Continuar descarga (${state.downloadPercent}%)'
                    : 'Descargar (${AssistantEngine.downloadSizeLabel})'),
              ),
            if (state.error != null) ...[
              const SizedBox(height: AppSizes.md),
              Text(
                state.error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChatView extends ConsumerStatefulWidget {
  final AssistantState state;

  const _ChatView(this.state);

  @override
  ConsumerState<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<_ChatView> {
  final _scroll = ScrollController();

  @override
  void didUpdateWidget(covariant _ChatView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Follow the conversation as it grows
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final controller = ref.read(assistantProvider.notifier);
    final streaming = state.streamingText;
    final suggestion = state.isBusy || state.modelStatus != ModelStatus.ready
        ? null
        : replySuggestion([for (final e in state.entries) e.item], DateTime.now());

    final Widget body;
    if (state.entries.isEmpty && state.loadingHistory) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state.entries.isEmpty && !state.isBusy) {
      body = _EmptyChat(onPick: controller.send);
    } else {
      body = ListView(
        controller: _scroll,
        padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.md, AppSizes.md, AppSizes.sm),
        children: [
          for (final entry in state.entries) _buildEntry(entry),
          if (streaming != null && streaming.isNotEmpty)
            AssistantTextView(text: streaming)
          else if (state.status != null)
            StatusView(state.status!)
          else if (suggestion != null)
            _Suggestion(text: suggestion, onTap: () => controller.send(suggestion)),
        ],
      );
    }

    return Column(
      children: [
        Expanded(child: body),
        _InputBar(
          busy: state.isBusy,
          onSend: controller.send,
          onStop: controller.stop,
          onPhoto: () => _pickRecipePhoto(context),
        ),
      ],
    );
  }

  /// A photo or screenshot of a recipe to add it to the household's recipes.
  Future<void> _pickRecipePhoto(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const ListTile(title: Text('Agregar una receta desde una imagen')),
          ListTile(leading: const Icon(Icons.photo_library_outlined), title: const Text('Galería o captura'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery)),
          ListTile(leading: const Icon(Icons.photo_camera_outlined), title: const Text('Sacar una foto'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera)),
        ]),
      ),
    );
    if (source == null) return;
    final file = await ImagePicker().pickImage(source: source, maxWidth: 1280, maxHeight: 1280, imageQuality: 85);
    if (file == null) return;
    await ref.read(assistantProvider.notifier).addRecipePhoto(await file.readAsBytes());
  }

  Widget _buildEntry(ChatEntry entry) {
    final item = entry.item;
    return switch (item) {
      UserMessage() => _UserBubble(item: item),
      AssistantText(:final text) => AssistantTextView(text: text),
      DataCard() => DataCardView(key: ValueKey(entry.key), entryKey: entry.key, card: item),
      FormCard(:final surface) => Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.md, right: 24),
          child: A2uiSurface(key: ObjectKey(surface), surface: surface),
        ),
      Notice(:final text) => Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.md),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
    };
  }
}

class _EmptyChat extends StatelessWidget {
  final void Function(String) onPick;

  const _EmptyChat({required this.onPick});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, size: 40, color: colorScheme.tertiary),
            const SizedBox(height: AppSizes.md),
            Text('¿En qué te ayudo?', style: text.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: AppSizes.xs),
            Text(
              'Escribe un gasto, pregunta cuánto gastaron o pide una receta.',
              style: text.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.lg),
            Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.sm,
              alignment: WrapAlignment.center,
              children: [
                for (final prompt in _starterPrompts)
                  ActionChip(label: Text(prompt), onPressed: () => onPick(prompt)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The one reply the assistant suggests after its last card, on the user's
/// side of the chat so it reads as "you could say this".
class _Suggestion extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _Suggestion({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.md, left: 48),
        child: ActionChip(
          avatar: Icon(Icons.auto_awesome, size: 16, color: colorScheme.tertiary),
          label: Text(text),
          tooltip: 'Enviar',
          onPressed: onTap,
        ),
      ),
    );
  }
}

/// A household member's message. Yours in yerba; other members' in a quiet
/// green-grey with their name on top.
class _UserBubble extends StatelessWidget {
  final UserMessage item;

  const _UserBubble({required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final mine = item.authorName == null;
    final background = mine ? colorScheme.primaryContainer : colorScheme.secondaryContainer;
    final foreground = mine ? colorScheme.onPrimaryContainer : colorScheme.onSecondaryContainer;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.md, left: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!mine)
              Padding(
                padding: const EdgeInsets.only(right: 6, bottom: 2),
                child: Text(
                  item.authorName!,
                  style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.fromAction) ...[
                    Icon(Icons.check, size: 16, color: foreground),
                    const SizedBox(width: AppSizes.xs),
                  ],
                  Flexible(child: Text(item.text, style: textTheme.bodyLarge?.copyWith(color: foreground))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputBar extends StatefulWidget {
  final bool busy;
  final void Function(String) onSend;
  final VoidCallback onStop;
  final VoidCallback onPhoto;

  const _InputBar({required this.busy, required this.onSend, required this.onStop, required this.onPhoto});

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final _controller = TextEditingController();
  final _speech = stt.SpeechToText();
  bool _speechAvailable = false;
  bool _listening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      _speechAvailable = await _speech.initialize(
        onError: (_) => mounted ? setState(() => _listening = false) : null,
        onStatus: (status) {
          if ((status == 'done' || status == 'notListening') && mounted) {
            setState(() => _listening = false);
          }
        },
      );
    } catch (_) {
      _speechAvailable = false;
    }
    if (mounted) setState(() {});
  }

  Future<void> _toggleListening() async {
    if (_listening) {
      await _speech.stop();
      setState(() => _listening = false);
      return;
    }
    setState(() => _listening = true);
    await _speech.listen(
      localeId: 'es_AR',
      onResult: (result) => setState(() {
        _controller.text = result.recognizedWords;
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      }),
    );
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.busy) return;
    widget.onSend(text);
    _controller.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _speech.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pill = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );
    final canSend = _controller.text.trim().isNotEmpty;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.md,
          AppSizes.xs,
          AppSizes.md,
          AppSizes.sm,
        ),
        child: Row(
          children: [
            if (!widget.busy)
              IconButton(
                icon: const Icon(Icons.add_photo_alternate_outlined),
                tooltip: 'Receta desde una foto',
                onPressed: widget.onPhoto,
              ),
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: _listening ? 'Escuchando…' : 'Escribe al asistente',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.md,
                    vertical: 12,
                  ),
                  border: pill,
                  enabledBorder: pill,
                  focusedBorder: pill.copyWith(
                    borderSide: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  suffixIcon: _speechAvailable && !widget.busy
                      ? IconButton(
                          icon: Icon(_listening ? Icons.mic : Icons.mic_none),
                          color: _listening
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          tooltip: 'Dictar',
                          onPressed: _toggleListening,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            if (widget.busy)
              IconButton.filledTonal(
                icon: const Icon(Icons.stop_rounded),
                tooltip: 'Detener',
                onPressed: widget.onStop,
              )
            else
              IconButton.filled(
                icon: const Icon(Icons.arrow_upward_rounded),
                tooltip: 'Enviar',
                onPressed: canSend ? _send : null,
              ),
          ],
        ),
      ),
    );
  }
}
