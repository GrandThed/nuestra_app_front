import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/chat/data/models/chat_api_response.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';

/// Provider for ChatRepository
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(dioClient: ref.watch(dioClientProvider));
});

/// Repository for chat assistant API operations
class ChatRepository {
  final DioClient _dioClient;

  ChatRepository({required DioClient dioClient}) : _dioClient = dioClient;

  /// Send a new message to the assistant
  /// Returns either a data_request or a final response
  Future<ChatApiResponse> sendMessage(
    String message, {
    List<String> imageUrls = const [],
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.chat,
      data: {
        'message': message,
        if (imageUrls.isNotEmpty) 'imageUrls': imageUrls,
      },
    );

    return ChatApiResponse.fromApiData(
      response['data'] as Map<String, dynamic>,
    );
  }

  /// Send query results back to the LLM for a final response
  Future<ChatApiResponse> continueWithData(
    List<Map<String, dynamic>> requestResults,
  ) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.chatContinue,
      data: {'requestResults': requestResults},
    );

    return ChatApiResponse.fromApiData(
      response['data'] as Map<String, dynamic>,
    );
  }

  /// Fetch chat history with pagination
  Future<ChatHistoryResponse> getHistory({
    int limit = 50,
    String? before,
  }) async {
    final queryParams = <String, dynamic>{
      'limit': limit,
    };
    if (before != null) {
      queryParams['before'] = before;
    }

    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.chatHistory,
      queryParameters: queryParams,
    );

    final data = response['data'] as Map<String, dynamic>;
    final messages = (data['messages'] as List<dynamic>)
        .map((m) => ChatMessageModel.fromJson(m as Map<String, dynamic>))
        .toList();

    return ChatHistoryResponse(
      messages: messages,
      hasMore: data['hasMore'] as bool? ?? false,
    );
  }

  /// Clear all chat history
  Future<void> clearHistory() async {
    await _dioClient.delete<Map<String, dynamic>>(ApiConstants.chatHistory);
  }
}
