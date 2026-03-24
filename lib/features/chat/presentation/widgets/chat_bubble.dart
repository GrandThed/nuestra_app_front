import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';
import 'package:nuestra_app/features/chat/presentation/providers/chat_state.dart';
import 'package:nuestra_app/features/chat/presentation/widgets/tool_call_card.dart';
import 'package:nuestra_app/features/chat/presentation/widgets/tool_call_detail_sheet.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;
  final Map<String, ToolExecutionStatus> toolStatuses;
  final Map<String, String> toolResults;
  final void Function(String messageId, int toolIndex)? onExecuteToolCall;
  final void Function(String messageId)? onBacktrack;

  const ChatBubble({
    super.key,
    required this.message,
    this.toolStatuses = const {},
    this.toolResults = const {},
    this.onExecuteToolCall,
    this.onBacktrack,
  });

  bool get _isUser => message.role == 'user';

  void _showContextMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasContent =
        message.content != null && message.content!.trim().isNotEmpty;

    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasContent)
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copiar mensaje'),
                onTap: () {
                  final cleanContent = message.content!
                      .replaceAll(RegExp(r'\{\{tool:\d+\}\}'), '')
                      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
                      .trim();
                  Clipboard.setData(ClipboardData(text: cleanContent));
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mensaje copiado'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            if (_isUser && onBacktrack != null)
              ListTile(
                leading: Icon(Icons.replay, color: colorScheme.error),
                title: Text(
                  'Volver a este punto',
                  style: TextStyle(color: colorScheme.error),
                ),
                subtitle: const Text(
                  'Elimina este mensaje y los siguientes',
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _confirmBacktrack(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _confirmBacktrack(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Volver a este punto'),
        content: const Text(
          '¿Querés eliminar este mensaje y todos los que vinieron después? '
          'Vas a poder escribir un mensaje nuevo desde acá.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        onBacktrack?.call(message.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final time = DateFormat.Hm().format(message.createdAt);

    return Padding(
      padding: EdgeInsets.only(
        left: _isUser ? 64 : 12,
        right: _isUser ? 12 : 64,
        top: 2,
        bottom: 2,
      ),
      child: Align(
        alignment: _isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onLongPress: () => _showContextMenu(context),
          child: Container(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.78),
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
            decoration: BoxDecoration(
              color: _isUser
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(_isUser ? 12 : 2),
                bottomRight: Radius.circular(_isUser ? 2 : 12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image thumbnails
                if (message.imageUrls.isNotEmpty) ...[
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: message.imageUrls.map((url) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                          placeholder: (_, _) => Container(
                            width: 160,
                            height: 160,
                            color: colorScheme.surfaceContainerHighest,
                            child: const Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (_, _, _) => Container(
                            width: 160,
                            height: 160,
                            color: colorScheme.surfaceContainerHighest,
                            child:
                                const Icon(Icons.broken_image, size: 32),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (message.content != null &&
                      message.content!.isNotEmpty)
                    const SizedBox(height: 6),
                ],

                // Content: text with inline tool cards, or just text, or just tools
                if (_isUser && message.content != null && message.content!.isNotEmpty)
                  _buildUserTextWithTime(context, time),

                if (!_isUser)
                  ..._buildAssistantContentWithInlineTools(context, time),

                // If no text, no tools, show timestamp alone
                if (_isUser &&
                    (message.content == null || message.content!.isEmpty))
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _buildTimeLabel(context, time),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetailSheet(
      BuildContext context, ChatToolCallModel toolCall, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(ctx).size.height * 0.85,
        ),
        child: ToolCallDetailSheet(
          toolCall: toolCall,
          onConfirm: () => onExecuteToolCall?.call(message.id, index),
        ),
      ),
    );
  }

  /// Build a tool card widget for a given index
  Widget _buildToolCard(BuildContext context, int index) {
    if (index < 0 || index >= message.toolCalls.length) {
      return const SizedBox.shrink();
    }
    final tc = message.toolCalls[index];
    final key = '${message.id}_$index';
    final status = toolStatuses[key] ?? ToolExecutionStatus.pending;
    final result = toolResults[key];

    return ToolCallCard(
      toolCall: tc,
      status: status,
      resultMessage: result,
      onTap: () => _showDetailSheet(context, tc, index),
    );
  }

  /// Build a markdown segment widget
  Widget _buildMarkdownSegment(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = colorScheme.onSurface;

    return MarkdownBody(
      data: text,
      selectable: false,
      shrinkWrap: true,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(fontSize: 15, color: textColor, height: 1.35),
        h1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        h2: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        h3: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        listBullet: TextStyle(fontSize: 15, color: textColor, height: 1.35),
        code: TextStyle(
          fontSize: 13,
          color: textColor,
          backgroundColor:
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        ),
        codeblockDecoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: colorScheme.primary, width: 3),
          ),
        ),
        blockquotePadding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
        strong: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        em: TextStyle(fontStyle: FontStyle.italic, color: textColor),
      ),
    );
  }

  /// Assistant messages: interleave text segments with inline tool cards
  List<Widget> _buildAssistantContentWithInlineTools(
      BuildContext context, String time) {
    final colorScheme = Theme.of(context).colorScheme;
    final timeColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.6);
    final content = message.content ?? '';
    final hasToolCalls = message.toolCalls.isNotEmpty;

    // Check if the reply contains {{tool:N}} markers
    final markerPattern = RegExp(r'\{\{tool:(\d+)\}\}');
    final hasMarkers = hasToolCalls && markerPattern.hasMatch(content);

    if (!hasMarkers) {
      // No markers — fall back to old layout: text block then all tools at bottom
      final widgets = <Widget>[];
      if (content.isNotEmpty) {
        widgets.add(_buildMarkdownSegment(context, content));
      }
      if (hasToolCalls) {
        if (content.isNotEmpty) widgets.add(const SizedBox(height: 4));
        for (var i = 0; i < message.toolCalls.length; i++) {
          widgets.add(_buildToolCard(context, i));
        }
      }
      widgets.add(const SizedBox(height: 4));
      widgets.add(Align(
        alignment: Alignment.bottomRight,
        child: Text(time, style: TextStyle(fontSize: 11, color: timeColor)),
      ));
      return widgets;
    }

    // Split content by markers and interleave text + tool cards
    final widgets = <Widget>[];
    final usedToolIndices = <int>{};
    int lastEnd = 0;

    for (final match in markerPattern.allMatches(content)) {
      // Text before this marker
      final textBefore = content.substring(lastEnd, match.start).trim();
      if (textBefore.isNotEmpty) {
        widgets.add(_buildMarkdownSegment(context, textBefore));
      }

      // The tool card
      final toolIndex = int.parse(match.group(1)!);
      widgets.add(_buildToolCard(context, toolIndex));
      usedToolIndices.add(toolIndex);

      lastEnd = match.end;
    }

    // Text after the last marker
    final textAfter = content.substring(lastEnd).trim();
    if (textAfter.isNotEmpty) {
      widgets.add(_buildMarkdownSegment(context, textAfter));
    }

    // Any tool cards not referenced by markers go at the bottom
    for (var i = 0; i < message.toolCalls.length; i++) {
      if (!usedToolIndices.contains(i)) {
        widgets.add(_buildToolCard(context, i));
      }
    }

    // Timestamp
    widgets.add(const SizedBox(height: 4));
    widgets.add(Align(
      alignment: Alignment.bottomRight,
      child: Text(time, style: TextStyle(fontSize: 11, color: timeColor)),
    ));

    return widgets;
  }

  /// User messages: plain text with inline timestamp
  Widget _buildUserTextWithTime(BuildContext context, String time) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = colorScheme.onPrimary;
    final timeColor = colorScheme.onPrimary.withValues(alpha: 0.6);

    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 6,
      children: [
        Text(
          message.content!,
          style: TextStyle(
            fontSize: 15,
            color: textColor,
            height: 1.35,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Text(
            time,
            style: TextStyle(fontSize: 11, color: timeColor),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeLabel(BuildContext context, String time) {
    final colorScheme = Theme.of(context).colorScheme;
    final timeColor = _isUser
        ? colorScheme.onPrimary.withValues(alpha: 0.6)
        : colorScheme.onSurfaceVariant.withValues(alpha: 0.6);

    return Text(
      time,
      style: TextStyle(fontSize: 11, color: timeColor),
    );
  }
}
