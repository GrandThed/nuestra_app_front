import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/tasks/data/models/task_model.dart';

part 'tasks_state.freezed.dart';

@freezed
sealed class TasksState with _$TasksState {
  const factory TasksState.initial() = TasksStateInitial;
  const factory TasksState.loading() = TasksStateLoading;
  const factory TasksState.loaded(List<PendingTaskModel> tasks) =
      TasksStateLoaded;
  const factory TasksState.error(String message) = TasksStateError;
}
