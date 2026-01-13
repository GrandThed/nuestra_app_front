import 'package:freezed_annotation/freezed_annotation.dart';

part 'household_model.freezed.dart';
part 'household_model.g.dart';

@freezed
sealed class HouseholdModel with _$HouseholdModel {
  const factory HouseholdModel({
    required String id,
    required String name,
    required String hemisphere,
    required DateTime createdAt,
    List<MemberModel>? members,
  }) = _HouseholdModel;

  factory HouseholdModel.fromJson(Map<String, dynamic> json) =>
      _$HouseholdModelFromJson(json);
}

@freezed
sealed class MemberModel with _$MemberModel {
  const factory MemberModel({
    required String id,
    required String userId,
    required String name,
    required String email,
    String? avatarUrl,
    required String role,
    double? income,
    DateTime? createdAt,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}

@freezed
sealed class HouseholdInviteModel with _$HouseholdInviteModel {
  const factory HouseholdInviteModel({
    required String id,
    required String code,
    required DateTime expiresAt,
    required DateTime createdAt,
  }) = _HouseholdInviteModel;

  factory HouseholdInviteModel.fromJson(Map<String, dynamic> json) =>
      _$HouseholdInviteModelFromJson(json);
}
