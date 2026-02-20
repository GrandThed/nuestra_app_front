// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityLogModel _$ActivityLogModelFromJson(Map<String, dynamic> json) =>
    _ActivityLogModel(
      id: json['id'] as String,
      householdId: json['householdId'] as String,
      userId: json['userId'] as String,
      user: ActivityUserModel.fromJson(json['user'] as Map<String, dynamic>),
      action: json['action'] as String,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ActivityLogModelToJson(_ActivityLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'userId': instance.userId,
      'user': instance.user,
      'action': instance.action,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_ActivityUserModel _$ActivityUserModelFromJson(Map<String, dynamic> json) =>
    _ActivityUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$ActivityUserModelToJson(_ActivityUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };

_ActivityDigestModel _$ActivityDigestModelFromJson(Map<String, dynamic> json) =>
    _ActivityDigestModel(
      householdId: json['householdId'] as String,
      periodStart: json['periodStart'] as String,
      periodEnd: json['periodEnd'] as String,
      totalActions: (json['totalActions'] as num).toInt(),
      byEntityType: Map<String, int>.from(json['byEntityType'] as Map),
      byAction: Map<String, int>.from(json['byAction'] as Map),
    );

Map<String, dynamic> _$ActivityDigestModelToJson(
  _ActivityDigestModel instance,
) => <String, dynamic>{
  'householdId': instance.householdId,
  'periodStart': instance.periodStart,
  'periodEnd': instance.periodEnd,
  'totalActions': instance.totalActions,
  'byEntityType': instance.byEntityType,
  'byAction': instance.byAction,
};
