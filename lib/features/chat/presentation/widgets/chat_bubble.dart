import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';
import 'package:nuestra_app/features/chat/presentation/widgets/tool_call_card.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubble({super.key, required this.message});

  bool get _isUser => message.role == 'user';

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
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (_, _, _) => Container(
                          width: 160,
                          height: 160,
                          color: colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.broken_image, size: 32),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (message.content != null && message.content!.isNotEmpty)
                  const SizedBox(height: 6),
              ],

              // Text + timestamp row
              if (message.content != null && message.content!.isNotEmpty)
                _buildTextWithTime(context, time),

              // If no text but has images, show timestamp alone
              if ((message.content == null || message.content!.isEmpty) &&
                  message.toolCalls.isEmpty)
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildTimeLabel(context, time),
                ),

              // Tool call cards (assistant only)
              if (!_isUser && message.toolCalls.isNotEmpty) ...[
                const SizedBox(height: 4),
                ...message.toolCalls.map(
                  (tc) => ToolCallCard(toolCall: tc),
                ),
                const SizedBox(height: 2),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildTimeLabel(context, time),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextWithTime(BuildContext context, String time) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor =
        _isUser ? colorScheme.onPrimary : colorScheme.onSurface;
    final timeColor = _isUser
        ? colorScheme.onPrimary.withValues(alpha: 0.6)
        : colorScheme.onSurfaceVariant.withValues(alpha: 0.6);

    // Use a Wrap so the timestamp sits at the end of the last line
    // when there's room, or drops to the next line when text is long.
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
            style: TextStyle(
              fontSize: 11,
              color: timeColor,
            ),
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
