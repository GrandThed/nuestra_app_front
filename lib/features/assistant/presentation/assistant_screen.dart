import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/theme/text_styles.dart';
import 'package:nuestra_app/features/assistant/data/assistant_engine.dart';
import 'package:nuestra_app/features/assistant/data/assistant_history_repository.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_controller.dart';
import 'package:nuestra_app/core/utils/money_format.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

final _currency = const MoneyFormat();

const _starterPrompts = [
  '¿Cuánto gastamos este mes?',
  '¿Qué gastos fijos faltan cargar?',
  'Gastos del súper de este mes',
  'Anotá 15000 de nafta',
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

/// The on-device assistant (Gemma 4 + A2UI cards), with conversations
/// shared by the household.
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
              onPressed: state.isBusy || state.items.isEmpty
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
                        state.items.isEmpty
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
              'que le preguntás se procesa acá y no se envía a ningún servicio '
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
              const SizedBox(height: AppSizes.sm),
              TextButton(
                onPressed: controller.cancelDownload,
                child: const Text('Cancelar'),
              ),
            ] else
              FilledButton.icon(
                onPressed: controller.downloadModel,
                icon: const Icon(Icons.download),
                label: Text('Descargar (${AssistantEngine.downloadSizeLabel})'),
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

    final Widget body;
    if (state.items.isEmpty && state.loadingHistory) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state.items.isEmpty && !state.isBusy) {
      body = _EmptyChat(onPick: controller.send);
    } else {
      body = ListView(
        controller: _scroll,
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          for (final item in state.items) _buildItem(item),
          if (state.isBusy)
            _AssistantBubble(
              text: (streaming == null || streaming.isEmpty) ? null : streaming,
              status: state.busyLabel,
            ),
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
        ),
      ],
    );
  }

  Widget _buildItem(AssistantItem item) {
    return switch (item) {
      UserItem() => _UserBubble(item: item),
      AssistantTextItem(:final text) => _AssistantBubble(text: text),
      SurfaceItem(:final surface) => Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.sm, right: 32),
          child: A2uiSurface(key: ObjectKey(surface), surface: surface),
        ),
      ProposalItem() => _ProposalCard(item: item),
      NoticeItem(:final text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
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
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, size: 40, color: colorScheme.tertiary),
            const SizedBox(height: AppSizes.md),
            Text(
              'Preguntame por los gastos del hogar',
              style: Theme.of(context).textTheme.headlineSmall,
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

/// A household member's message. Yours in yerba; other members' in a quiet
/// green-grey with their name on top.
class _UserBubble extends StatelessWidget {
  final UserItem item;

  const _UserBubble({required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final background = item.isMine
        ? colorScheme.primaryContainer
        : colorScheme.secondaryContainer;
    final foreground = item.isMine
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSecondaryContainer;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.sm, left: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!item.isMine)
              Padding(
                padding: const EdgeInsets.only(right: 6, bottom: 2),
                child: Text(
                  item.authorName!,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radiusLg),
                  topRight: Radius.circular(AppSizes.radiusLg),
                  bottomLeft: Radius.circular(AppSizes.radiusLg),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.fromAction) ...[
                    Icon(Icons.touch_app, size: 16, color: foreground),
                    const SizedBox(width: AppSizes.xs),
                  ],
                  Flexible(
                    child: Text(item.text, style: TextStyle(color: foreground)),
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

class _AssistantBubble extends StatelessWidget {
  final String? text;
  final String? status;

  const _AssistantBubble({this.text, this.status});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.sm, right: 48),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSizes.radiusLg),
            topRight: Radius.circular(AppSizes.radiusLg),
            bottomRight: Radius.circular(AppSizes.radiusLg),
            bottomLeft: Radius.circular(6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text != null) SelectableText(text!),
            if (status != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Text(
                    status!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Confirmation card for an expense the model proposed (honey: the app is
/// proposing; turns green once saved).
class _ProposalCard extends ConsumerWidget {
  final ProposalItem item;

  const _ProposalCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(assistantProvider.notifier);
    final p = item.proposal;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final pending = item.status == ProposalStatus.pending ||
        item.status == ProposalStatus.saving;
    final accent = pending ? colorScheme.tertiary : colorScheme.outlineVariant;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.sm, right: 32),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: accent, width: pending ? 1.5 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pending ? 'POR CONFIRMAR' : 'NUEVO GASTO',
            style: textTheme.labelSmall?.copyWith(
              color: pending ? colorScheme.tertiary : colorScheme.onSurfaceVariant,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            _currency.format(p.amount),
            style: AppTextStyles.bigAmount(size: 26, color: colorScheme.onSurface),
          ),
          Text(p.description, style: textTheme.bodyLarge),
          Text(
            '${p.categoryName ?? 'Sin categoría'} · '
            '${DateFormat('d MMM', 'es').format(p.date)}',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSizes.sm),
          switch (item.status) {
            ProposalStatus.pending => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => controller.cancelProposal(item.id),
                    child: const Text('Descartar'),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  FilledButton(
                    onPressed: () => controller.confirmProposal(item.id),
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ProposalStatus.saving => const LinearProgressIndicator(),
            ProposalStatus.saved =>
              _Status(Icons.check_circle, 'Guardado', colorScheme.success),
            ProposalStatus.cancelled =>
              _Status(Icons.block, 'Descartado', colorScheme.onSurfaceVariant),
            ProposalStatus.failed =>
              _Status(Icons.error_outline, 'No se pudo guardar', colorScheme.error),
          },
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Status(this.icon, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: AppSizes.xs),
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _InputBar extends StatefulWidget {
  final bool busy;
  final void Function(String) onSend;
  final VoidCallback onStop;

  const _InputBar({required this.busy, required this.onSend, required this.onStop});

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
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: _listening ? 'Escuchando…' : 'Escribí tu pregunta',
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
