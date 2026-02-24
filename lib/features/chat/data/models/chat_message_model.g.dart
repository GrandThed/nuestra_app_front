// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageModel _$ChatMessageModelFromJson(
  Map<String, dynamic> json,
) => _ChatMessageModel(
  id: json['id'] as String,
  role: json['role'] as String,
  content: json['content'] as String?,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  toolCalls:
      (json['toolCalls'] as List<dynamic>?)
          ?.map((e) => ChatToolCallModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  suggestions:
      (json['suggestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  user: json['user'] == null
      ? null
      : ChatUserModel.fromJson(json['user'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ChatMessageModelToJson(_ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'content': instance.content,
      'imageUrls': instance.imageUrls,
      'toolCalls': instance.toolCalls,
      'suggestions': instance.suggestions,
      'user': instance.user,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_ChatToolCallModel _$ChatToolCallModelFromJson(Map<String, dynamic> json) =>
    _ChatToolCallModel(
      tool: json['tool'] as String,
      params: json['params'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ChatToolCallModelToJson(_ChatToolCallModel instance) =>
    <String, dynamic>{'tool': instance.tool, 'params': instance.params};

_ChatUserModel _$ChatUserModelFromJson(Map<String, dynamic> json) =>
    _ChatUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$ChatUserModelToJson(_ChatUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };
