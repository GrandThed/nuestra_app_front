import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? avatarUrl,
    required String provider,
    required DateTime createdAt,
    List<HouseholdMembershipModel>? householdMembers,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
sealed class HouseholdMembershipModel with _$HouseholdMembershipModel {
  const factory HouseholdMembershipModel({
    required String oderId,
    required String odehouseholdId,
    required String role,
    double? monthlyIncome,
    required DateTime joinedAt,
    HouseholdBasicModel? household,
  }) = _HouseholdMembershipModel;

  factory HouseholdMembershipModel.fromJson(Map<String, dynamic> json) =>
      _$HouseholdMembershipModelFromJson(json);
}

@freezed
sealed class HouseholdBasicModel with _$HouseholdBasicModel {
  const factory HouseholdBasicModel({
    required String id,
    required String name,
  }) = _HouseholdBasicModel;

  factory HouseholdBasicModel.fromJson(Map<String, dynamic> json) =>
      _$HouseholdBasicModelFromJson(json);
}
