// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatHistoryResponse _$ChatHistoryResponseFromJson(Map<String, dynamic> json) =>
    _ChatHistoryResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$ChatHistoryResponseToJson(
  _ChatHistoryResponse instance,
) => <String, dynamic>{
  'messages': instance.messages,
  'hasMore': instance.hasMore,
};
