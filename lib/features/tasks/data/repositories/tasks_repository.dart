import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/tasks/data/models/task_model.dart';

/// Provider for TasksRepository
final tasksRepositoryProvider = Provider<TasksRepository>((ref) {
  return TasksRepository(dioClient: ref.watch(dioClientProvider));
});

/// Repository for household task operations
class TasksRepository {
  final DioClient _dioClient;

  TasksRepository({required DioClient dioClient}) : _dioClient = dioClient;

  /// Get pending (uncompleted) tasks for a household
  Future<List<PendingTaskModel>> getPendingTasks(String householdId) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.tasks,
      queryParameters: {'householdId': householdId},
    );

    final tasks = response['data']['tasks'] as List<dynamic>? ?? [];
    return tasks
        .map((t) => PendingTaskModel.fromJson(t as Map<String, dynamic>))
        .toList();
  }

  /// Complete a task occurrence
  Future<void> completeTask({
    required String taskId,
    required String occurrenceDate,
    required String householdId,
  }) async {
    await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.taskComplete(taskId),
      data: {
        'occurrenceDate': occurrenceDate,
        'householdId': householdId,
      },
    );
  }

  /// Undo a task completion
  Future<void> uncompleteTask({
    required String taskId,
    required String occurrenceDate,
    required String householdId,
  }) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.taskComplete(taskId),
      queryParameters: {
        'occurrenceDate': occurrenceDate,
        'householdId': householdId,
      },
    );
  }
}
