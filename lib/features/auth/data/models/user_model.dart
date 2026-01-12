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
    List<HouseholdMembershipModel>? households,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
sealed class HouseholdMembershipModel with _$HouseholdMembershipModel {
  const factory HouseholdMembershipModel({
    required String id,
    required String name,
    required String role,
  }) = _HouseholdMembershipModel;

  factory HouseholdMembershipModel.fromJson(Map<String, dynamic> json) =>
      _$HouseholdMembershipModelFromJson(json);
}
