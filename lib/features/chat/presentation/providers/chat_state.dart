import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';

part 'chat_state.freezed.dart';

enum ToolExecutionStatus { pending, executing, success, error }

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatMessageModel> messages,
    @Default(false) bool isSending,
    @Default(false) bool isGatheringData,
    @Default([]) List<String> suggestions,
    /// Human-readable status shown in the typing indicator bubble
    String? statusMessage,
    /// Tracks execution status per tool call: key = "messageId_toolIndex"
    @Default({}) Map<String, ToolExecutionStatus> toolExecutionStatuses,
    /// Stores result messages per tool call: key = "messageId_toolIndex"
    @Default({}) Map<String, String> toolExecutionResults,
  }) = _ChatState;
}
