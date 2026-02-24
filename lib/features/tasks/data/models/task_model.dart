import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

/// Minimal user reference for task creator
@freezed
sealed class TaskUserRef with _$TaskUserRef {
  const factory TaskUserRef({
    required String id,
    required String name,
    String? avatarUrl,
  }) = _TaskUserRef;

  factory TaskUserRef.fromJson(Map<String, dynamic> json) =>
      _$TaskUserRefFromJson(json);
}

/// A pending task occurrence returned by GET /api/tasks
/// Each item represents one specific occurrence (date) of a recurring or one-time task
@freezed
sealed class PendingTaskModel with _$PendingTaskModel {
  const factory PendingTaskModel({
    required String id,
    required String householdId,
    required String title,
    String? description,
    required DateTime startDate,
    required String occurrenceDate,
    String? occurrenceId,
    String? recurrenceDays,
    int? recurrenceInterval,
    String? colorHex,
    TaskUserRef? createdBy,
  }) = _PendingTaskModel;

  factory PendingTaskModel.fromJson(Map<String, dynamic> json) =>
      _$PendingTaskModelFromJson(json);
}
