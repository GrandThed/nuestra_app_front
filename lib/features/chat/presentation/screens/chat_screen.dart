import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/features/chat/presentation/providers/chat_notifier.dart';
import 'package:nuestra_app/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:nuestra_app/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:nuestra_app/features/chat/presentation/widgets/quick_action_chips.dart';

/// Default suggestions shown when starting a fresh chat
const _defaultSuggestions = [
  'Sugerime recetas para esta semana',
  '¿Qué tenemos pendiente en la lista de compras?',
  'Planificá el menú de la semana',
  '¿Cuánto gastamos este mes?',
  '¿Qué eventos tenemos esta semana?',
  'Agregame una receta nueva',
  '¿Qué verduras son de temporada?',
  'Quiero agregar un gasto',
];

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(chatProvider.notifier).loadHistoryIfNeeded();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend(String text, List<String> imageUrls) {
    if (text.isEmpty && imageUrls.isEmpty) return;
    ref.read(chatProvider.notifier).sendMessage(
          text,
          imageUrls: imageUrls,
        );
  }

  void _clearHistory() {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Borrar conversación'),
        content: const Text(
          '¿Estás seguro de que querés borrar toda la conversación?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Borrar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        ref.read(chatProvider.notifier).clearHistory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final isEmpty = state.messages.isEmpty;

    // Determine which suggestions to show
    final suggestions = isEmpty
        ? _defaultSuggestions
        : state.suggestions;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
              child: Icon(
                Icons.auto_awesome,
                size: 16,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Asistente',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    state.isSending ? 'activo' : 'online',
                    key: ValueKey(state.isSending),
                    style: TextStyle(
                      fontSize: 12,
                      color: state.isSending
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.6),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          if (!isEmpty)
            IconButton(
              onPressed: _clearHistory,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Borrar conversación',
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
        ),
        child: Column(
          children: [
            // Messages list
            Expanded(
              child: isEmpty
                  ? _buildEmptyState(colorScheme)
                  : ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      itemCount:
                          state.messages.length + (state.isSending ? 1 : 0),
                      itemBuilder: (context, index) {
                        // reverse: true flips the list, so index 0 = bottom
                        if (index == 0 && state.isSending) {
                          return _buildTypingIndicator(
                            colorScheme,
                            state.statusMessage,
                          );
                        }
                        final msgIndex = state.messages.length -
                            1 -
                            (state.isSending ? index - 1 : index);
                        return ChatBubble(
                          message: state.messages[msgIndex],
                          toolStatuses: state.toolExecutionStatuses,
                          toolResults: state.toolExecutionResults,
                          onExecuteToolCall: (messageId, toolIndex) {
                            ref
                                .read(chatProvider.notifier)
                                .executeToolCall(messageId, toolIndex);
                          },
                          onBacktrack: (messageId) {
                            ref
                                .read(chatProvider.notifier)
                                .backtrackFrom(messageId);
                          },
                        );
                      },
                    ),
            ),

            // Quick action / suggestion chips
            if (!state.isSending && suggestions.isNotEmpty)
              QuickActionChips(
                suggestions: suggestions,
                onTap: (text) => _handleSend(text, []),
              ),

            // Input bar
            ChatInputBar(
              onSend: _handleSend,
              isSending: state.isSending,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 44,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '¡Hola! Soy tu asistente',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Puedo ayudarte a agregar recetas, crear eventos, '
              'registrar gastos, manejar tu lista de compras y más.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(
    ColorScheme colorScheme,
    String? statusMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 2, bottom: 2, right: 64),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulsingIcon(color: colorScheme.primary),
              const SizedBox(width: 10),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  statusMessage ?? 'Pensando...',
                  key: ValueKey(statusMessage),
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Smoothly pulsing sparkle icon used in the typing indicator.
class _PulsingIcon extends StatefulWidget {
  final Color color;
  const _PulsingIcon({required this.color});

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Icon(
            Icons.auto_awesome,
            size: 16,
            color: widget.color,
          ),
        );
      },
    );
  }
}
