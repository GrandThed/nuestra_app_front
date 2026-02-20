// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HouseholdModel _$HouseholdModelFromJson(Map<String, dynamic> json) =>
    _HouseholdModel(
      id: json['id'] as String,
      name: json['name'] as String,
      hemisphere: json['hemisphere'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$HouseholdModelToJson(_HouseholdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hemisphere': instance.hemisphere,
      'createdAt': instance.createdAt.toIso8601String(),
      'members': instance.members,
    };

_MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => _MemberModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  role: json['role'] as String,
  income: (json['income'] as num?)?.toDouble(),
  paysExpenses: json['paysExpenses'] as bool? ?? false,
  colorHex: json['colorHex'] as String? ?? '#667eea',
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MemberModelToJson(_MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'role': instance.role,
      'income': instance.income,
      'paysExpenses': instance.paysExpenses,
      'colorHex': instance.colorHex,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_HouseholdInviteModel _$HouseholdInviteModelFromJson(
  Map<String, dynamic> json,
) => _HouseholdInviteModel(
  id: json['id'] as String,
  code: json['code'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$HouseholdInviteModelToJson(
  _HouseholdInviteModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
};
