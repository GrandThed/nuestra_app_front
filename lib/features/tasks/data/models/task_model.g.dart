// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskUserRef _$TaskUserRefFromJson(Map<String, dynamic> json) => _TaskUserRef(
  id: json['id'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$TaskUserRefToJson(_TaskUserRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };

_PendingTaskModel _$PendingTaskModelFromJson(Map<String, dynamic> json) =>
    _PendingTaskModel(
      id: json['id'] as String,
      householdId: json['householdId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      occurrenceDate: json['occurrenceDate'] as String,
      occurrenceId: json['occurrenceId'] as String?,
      recurrenceDays: json['recurrenceDays'] as String?,
      recurrenceInterval: (json['recurrenceInterval'] as num?)?.toInt(),
      colorHex: json['colorHex'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : TaskUserRef.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PendingTaskModelToJson(_PendingTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'occurrenceDate': instance.occurrenceDate,
      'occurrenceId': instance.occurrenceId,
      'recurrenceDays': instance.recurrenceDays,
      'recurrenceInterval': instance.recurrenceInterval,
      'colorHex': instance.colorHex,
      'createdBy': instance.createdBy,
    };
