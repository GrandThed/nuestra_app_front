import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final assistantHistoryRepositoryProvider =
    Provider<AssistantHistoryRepository>((ref) {
  return AssistantHistoryRepository(ref.watch(dioClientProvider));
});

/// Who wrote a message (or started a conversation).
class MessageAuthor {
  final String id;
  final String name;

  const MessageAuthor(this.id, this.name);

  static MessageAuthor? tryFromJson(Object? json) {
    if (json is! Map || json['id'] is! String) return null;
    return MessageAuthor(json['id'] as String, '${json['name'] ?? ''}');
  }
}

/// A message as stored in the backend. See `src/routes/assistant.js`:
/// - user: [content] is what was typed (metadata.fromAction / modelText when
///   it came from tapping a card button);
/// - assistant, metadata.kind == 'reply': [content] is the raw model reply,
///   A2UI blocks included;
/// - assistant, metadata.kind == 'proposal': an expense proposal and status.
class StoredMessage {
  final String? id;
  final String role;
  final String content;
  final Map<String, dynamic>? metadata;
  final MessageAuthor? author;

  const StoredMessage({
    this.id,
    required this.role,
    required this.content,
    this.metadata,
    this.author,
  });

  String? get kind => metadata?['kind'] as String?;

  factory StoredMessage.fromJson(Map<String, dynamic> json) => StoredMessage(
        id: json['id'] as String?,
        role: json['role'] as String,
        content: json['content'] as String? ?? '',
        metadata: (json['metadata'] as Map?)?.cast<String, dynamic>(),
        author: MessageAuthor.tryFromJson(json['author']),
      );

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
        if (metadata != null) 'metadata': metadata,
      };
}

/// An entry in the household's conversation list.
class ConversationSummary {
  final String id;
  final String title;
  final MessageAuthor? startedBy;
  final int messageCount;
  final DateTime? lastMessageAt;

  const ConversationSummary({
    required this.id,
    required this.title,
    required this.messageCount,
    this.startedBy,
    this.lastMessageAt,
  });

  factory ConversationSummary.fromJson(Map<String, dynamic> json) =>
      ConversationSummary(
        id: json['id'] as String,
        title: json['title'] as String? ?? 'Conversación',
        startedBy: MessageAuthor.tryFromJson(json['startedBy']),
        messageCount: (json['messageCount'] as num?)?.toInt() ?? 0,
        lastMessageAt: DateTime.tryParse('${json['lastMessageAt']}')?.toLocal(),
      );
}

class StoredConversation {
  final String? conversationId;
  final List<StoredMessage> messages;

  const StoredConversation(this.conversationId, this.messages);
}

/// Assistant conversations, shared by the household and saved in the
/// backend. Which conversation is open is remembered per device, so another
/// member starting a new chat never switches this phone's screen.
class AssistantHistoryRepository {
  final DioClient _dio;

  AssistantHistoryRepository(this._dio);

  /// A new conversation id (accepted by the backend: 8-64 of [A-Za-z0-9-]).
  static String newConversationId() {
    final random = Random.secure();
    return List.generate(16, (_) => random.nextInt(256))
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  /// The household's conversations, most recent activity first.
  Future<List<ConversationSummary>> listConversations(String householdId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.assistantConversations,
      queryParameters: {'householdId': householdId},
    );
    return ((response['data'] as Map<String, dynamic>)['conversations']
            as List<dynamic>? ??
        [])
        .map((c) => ConversationSummary.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  /// Messages of [conversationId], or of the household's latest conversation.
  Future<StoredConversation> loadConversation(
    String householdId, {
    String? conversationId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.assistantHistory,
      queryParameters: {
        'householdId': householdId,
        if (conversationId != null) 'conversationId': conversationId,
      },
    );
    final data = response['data'] as Map<String, dynamic>;
    final messages = (data['messages'] as List<dynamic>? ?? [])
        .map((m) => StoredMessage.fromJson(m as Map<String, dynamic>))
        .toList();
    return StoredConversation(data['conversationId'] as String?, messages);
  }

  /// Append one turn's messages, in order. Returns them with their ids.
  Future<List<StoredMessage>> append({
    required String householdId,
    required String conversationId,
    required List<StoredMessage> messages,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.assistantMessages,
      data: {
        'householdId': householdId,
        'conversationId': conversationId,
        'messages': [for (final m in messages) m.toJson()],
      },
    );
    return ((response['data'] as Map<String, dynamic>)['messages']
            as List<dynamic>)
        .map((m) => StoredMessage.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateMetadata(String id, Map<String, dynamic> metadata) async {
    await _dio.patch<Map<String, dynamic>>(
      ApiConstants.assistantMessage(id),
      data: {'metadata': metadata},
    );
  }

  // ---------- This device's open conversation ----------

  static String _currentKey(String householdId) =>
      'assistant.currentConversation.$householdId';

  Future<String?> readCurrentConversationId(String householdId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_currentKey(householdId));
    } catch (_) {
      return null;
    }
  }

  Future<void> saveCurrentConversationId(String householdId, String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currentKey(householdId), id);
    } catch (_) {
      // Not critical: next launch opens the household's latest conversation
    }
  }
}
