import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';

part 'chat_api_response.freezed.dart';
part 'chat_api_response.g.dart';

/// Response from POST /api/chat or POST /api/chat/continue
/// Can be either a data_request (LLM needs more data) or a final response
@freezed
sealed class ChatApiResponse with _$ChatApiResponse {
  const factory ChatApiResponse.dataRequest({
    required String messageId,
    required String message,
    @Default([]) List<ChatToolCallModel> requests,
  }) = ChatApiResponseDataRequest;

  const factory ChatApiResponse.response({
    required String messageId,
    required String reply,
    @Default([]) List<ChatToolCallModel> toolCalls,
    @Default([]) List<String> suggestions,
  }) = ChatApiResponseResponse;

  factory ChatApiResponse.fromApiData(Map<String, dynamic> data) {
    if (data['type'] == 'data_request') {
      return ChatApiResponse.dataRequest(
        messageId: data['messageId'] as String,
        message: data['message'] as String? ?? 'Recopilando información...',
        requests: (data['requests'] as List<dynamic>?)
                ?.map(
                  (r) => ChatToolCallModel.fromJson(r as Map<String, dynamic>),
                )
                .toList() ??
            [],
      );
    }

    return ChatApiResponse.response(
      messageId: data['messageId'] as String,
      reply: data['reply'] as String? ?? '',
      toolCalls: (data['toolCalls'] as List<dynamic>?)
              ?.map(
                (t) => ChatToolCallModel.fromJson(t as Map<String, dynamic>),
              )
              .toList() ??
          [],
      suggestions: (data['suggestions'] as List<dynamic>?)
              ?.map((s) => s as String)
              .toList() ??
          [],
    );
  }
}

/// Response from GET /api/chat/history
@freezed
sealed class ChatHistoryResponse with _$ChatHistoryResponse {
  const factory ChatHistoryResponse({
    required List<ChatMessageModel> messages,
    required bool hasMore,
  }) = _ChatHistoryResponse;

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatHistoryResponseFromJson(json);
}
