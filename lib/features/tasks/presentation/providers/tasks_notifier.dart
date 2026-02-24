import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/tasks/data/models/task_model.dart';
import 'package:nuestra_app/features/tasks/data/repositories/tasks_repository.dart';
import 'package:nuestra_app/features/tasks/presentation/providers/tasks_state.dart';

part 'tasks_notifier.g.dart';

@Riverpod(keepAlive: true)
class TasksNotifier extends _$TasksNotifier {
  late final TasksRepository _repository;

  @override
  TasksState build() {
    _repository = ref.watch(tasksRepositoryProvider);
    return const TasksState.initial();
  }

  /// Call from screen initState - only loads if no data exists
  Future<void> loadTasksIfNeeded() async {
    if (state is TasksStateInitial || state is TasksStateError) {
      await loadTasks();
    }
  }

  /// Main load method - shows loading only on first load
  Future<void> loadTasks({bool forceLoading = false}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const TasksState.error('No hay hogar seleccionado');
      return;
    }

    final hasData = state is TasksStateLoaded;

    if (!hasData || forceLoading) {
      state = const TasksState.loading();
    }

    try {
      final tasks = await _repository.getPendingTasks(householdId);
      state = TasksState.loaded(tasks);
    } on AppException catch (e) {
      if (!hasData) state = TasksState.error(e.message);
    } catch (e) {
      if (!hasData) state = TasksState.error('Error al cargar tareas: $e');
    }
  }

  /// Complete a task from calendar event data (eventId + occurrenceDate ISO string).
  /// Use this when completing from the calendar screen where we don't have a PendingTaskModel.
  Future<bool> completeCalendarTask({
    required String eventId,
    required String occurrenceDate,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return false;

    try {
      await _repository.completeTask(
        taskId: eventId,
        occurrenceDate: occurrenceDate,
        householdId: householdId,
      );
      // Reload tasks list so home card updates
      await loadTasks();
      return true;
    } catch (e) {
      debugPrint('Error completing calendar task: $e');
      return false;
    }
  }

  /// Complete a task occurrence. Optimistically removes it from the list.
  Future<bool> completeTask(PendingTaskModel task) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return false;

    // Save previous state for rollback
    final previousState = state;

    // Optimistic: remove this task from the list
    final currentState = state;
    if (currentState is TasksStateLoaded) {
      state = TasksState.loaded(
        currentState.tasks
            .where((t) =>
                !(t.id == task.id &&
                    t.occurrenceDate == task.occurrenceDate))
            .toList(),
      );
    }

    try {
      await _repository.completeTask(
        taskId: task.id,
        occurrenceDate: task.occurrenceDate,
        householdId: householdId,
      );
      // Reload to get updated list (next occurrence may appear)
      await loadTasks();
      return true;
    } catch (e) {
      // Rollback on error
      state = previousState;
      debugPrint('Error completing task: $e');
      return false;
    }
  }
}

/// Top 3 pending tasks for the home card
@riverpod
List<PendingTaskModel> topPendingTasks(Ref ref) {
  final state = ref.watch(tasksProvider);
  if (state is TasksStateLoaded) {
    return state.tasks.take(3).toList();
  }
  return [];
}

/// Total pending task count (for overflow display)
@riverpod
int pendingTasksCount(Ref ref) {
  final state = ref.watch(tasksProvider);
  if (state is TasksStateLoaded) return state.tasks.length;
  return 0;
}
