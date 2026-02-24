import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';

part 'chat_state.freezed.dart';

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatMessageModel> messages,
    @Default(false) bool isSending,
    @Default(false) bool isGatheringData,
    @Default([]) List<String> suggestions,
  }) = _ChatState;
}
