// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  provider: json['provider'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  householdMembers:
      (json['householdMembers'] as List<dynamic>?)
          ?.map(
            (e) => HouseholdMembershipModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'provider': instance.provider,
      'createdAt': instance.createdAt.toIso8601String(),
      'householdMembers': instance.householdMembers,
    };

_HouseholdMembershipModel _$HouseholdMembershipModelFromJson(
  Map<String, dynamic> json,
) => _HouseholdMembershipModel(
  oderId: json['oderId'] as String,
  odehouseholdId: json['odehouseholdId'] as String,
  role: json['role'] as String,
  monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble(),
  joinedAt: DateTime.parse(json['joinedAt'] as String),
  household:
      json['household'] == null
          ? null
          : HouseholdBasicModel.fromJson(
            json['household'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$HouseholdMembershipModelToJson(
  _HouseholdMembershipModel instance,
) => <String, dynamic>{
  'oderId': instance.oderId,
  'odehouseholdId': instance.odehouseholdId,
  'role': instance.role,
  'monthlyIncome': instance.monthlyIncome,
  'joinedAt': instance.joinedAt.toIso8601String(),
  'household': instance.household,
};

_HouseholdBasicModel _$HouseholdBasicModelFromJson(Map<String, dynamic> json) =>
    _HouseholdBasicModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$HouseholdBasicModelToJson(
  _HouseholdBasicModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
