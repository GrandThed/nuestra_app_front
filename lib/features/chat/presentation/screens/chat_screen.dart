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

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future<void>.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _handleSend(String text, List<String> imageUrls) {
    if (text.isEmpty && imageUrls.isEmpty) return;
    ref.read(chatProvider.notifier).sendMessage(
          text,
          imageUrls: imageUrls,
        );
    _scrollToBottom();
    Future<void>.delayed(const Duration(milliseconds: 1800), _scrollToBottom);
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

    ref.listen(chatProvider, (prev, next) {
      if (prev != null && prev.messages.length != next.messages.length) {
        _scrollToBottom();
      }
    });

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
                Text(
                  state.isGatheringData
                      ? 'recopilando info...'
                      : state.isSending
                          ? 'escribiendo...'
                          : 'online',
                  style: TextStyle(
                    fontSize: 12,
                    color: (state.isSending || state.isGatheringData)
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    fontWeight: FontWeight.normal,
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
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      itemCount:
                          state.messages.length + (state.isSending ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.messages.length) {
                          return _buildTypingIndicator(colorScheme);
                        }
                        return ChatBubble(
                          message: state.messages[index],
                          toolStatuses: state.toolExecutionStatuses,
                          toolResults: state.toolExecutionResults,
                          onExecuteToolCall: (messageId, toolIndex) {
                            ref
                                .read(chatProvider.notifier)
                                .executeToolCall(messageId, toolIndex);
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

  Widget _buildTypingIndicator(ColorScheme colorScheme) {
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
              _buildAnimatedDot(colorScheme, 0),
              const SizedBox(width: 4),
              _buildAnimatedDot(colorScheme, 1),
              const SizedBox(width: 4),
              _buildAnimatedDot(colorScheme, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedDot(ColorScheme colorScheme, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color:
                colorScheme.onSurfaceVariant.withValues(alpha: value * 0.5),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
