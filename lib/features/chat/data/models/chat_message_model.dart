import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
sealed class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String id,
    required String role, // "user" | "assistant"
    String? content,
    @Default([]) List<String> imageUrls,
    @Default([]) List<ChatToolCallModel> toolCalls,
    @Default([]) List<String> suggestions,
    ChatUserModel? user,
    required DateTime createdAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}

@freezed
sealed class ChatToolCallModel with _$ChatToolCallModel {
  const factory ChatToolCallModel({
    required String tool,
    @Default({}) Map<String, dynamic> params,
  }) = _ChatToolCallModel;

  factory ChatToolCallModel.fromJson(Map<String, dynamic> json) =>
      _$ChatToolCallModelFromJson(json);
}

@freezed
sealed class ChatUserModel with _$ChatUserModel {
  const factory ChatUserModel({
    required String id,
    required String name,
    String? avatarUrl,
  }) = _ChatUserModel;

  factory ChatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);
}
