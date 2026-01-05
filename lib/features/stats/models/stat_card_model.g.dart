// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatCardModel _$StatCardModelFromJson(Map<String, dynamic> json) =>
    _StatCardModel(
      type: json['type'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      amount: (json['amount'] as num?)?.toInt(),
      description: json['description'] as String?,
      id: json['id'] as String,
    );

Map<String, dynamic> _$StatCardModelToJson(_StatCardModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'date': instance.date?.toIso8601String(),
      'title': instance.title,
      'amount': instance.amount,
      'description': instance.description,
      'id': instance.id,
    };
