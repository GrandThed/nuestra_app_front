import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
sealed class ActivityLogModel with _$ActivityLogModel {
  const factory ActivityLogModel({
    required String id,
    required String householdId,
    required String userId,
    required ActivityUserModel user,
    required String action,
    required String entityType,
    String? entityId,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
  }) = _ActivityLogModel;

  factory ActivityLogModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogModelFromJson(json);
}

@freezed
sealed class ActivityUserModel with _$ActivityUserModel {
  const factory ActivityUserModel({
    required String id,
    required String name,
    String? avatarUrl,
  }) = _ActivityUserModel;

  factory ActivityUserModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityUserModelFromJson(json);
}

@freezed
sealed class ActivityDigestModel with _$ActivityDigestModel {
  const factory ActivityDigestModel({
    required String householdId,
    required String periodStart,
    required String periodEnd,
    required int totalActions,
    required Map<String, int> byEntityType,
    required Map<String, int> byAction,
  }) = _ActivityDigestModel;

  factory ActivityDigestModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityDigestModelFromJson(json);
}
