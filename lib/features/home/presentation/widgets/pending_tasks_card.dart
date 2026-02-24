import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/tasks/data/models/task_model.dart';
import 'package:nuestra_app/features/tasks/presentation/providers/tasks_notifier.dart';
import 'package:nuestra_app/features/tasks/presentation/providers/tasks_state.dart';

/// Home dashboard card showing pending household tasks
class PendingTasksCard extends ConsumerWidget {
  const PendingTasksCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tasksProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () => context.go(AppRoutes.calendar),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Icon(
                      Icons.checklist_outlined,
                      color: colorScheme.primary,
                      size: AppSizes.iconMd,
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: Text(
                      'Tareas pendientes',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              // Body
              switch (state) {
                TasksStateInitial() || TasksStateLoading() =>
                  const _LoadingContent(),
                TasksStateError(:final message) =>
                  _ErrorContent(message: message),
                TasksStateLoaded(:final tasks) => _TasksContent(tasks: tasks),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String message;
  const _ErrorContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
        fontSize: AppSizes.fontSm,
      ),
    );
  }
}

class _TasksContent extends ConsumerWidget {
  final List<PendingTaskModel> tasks;
  const _TasksContent({required this.tasks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCount = ref.watch(pendingTasksCountProvider);
    final colorScheme = Theme.of(context).colorScheme;

    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.task_alt, size: 40, color: colorScheme.onSurfaceVariant),
              const SizedBox(height: AppSizes.sm),
              Text(
                'Sin tareas pendientes',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: AppSizes.fontSm,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final visibleTasks = tasks.take(3).toList();
    final overflowCount = totalCount - visibleTasks.length;

    return Column(
      children: [
        // Animated task list
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Column(
            key: ValueKey(
              visibleTasks.map((t) => '${t.id}_${t.occurrenceDate}').join(','),
            ),
            children: visibleTasks
                .map((task) => _TaskRow(
                      task: task,
                      onComplete: () {
                        ref
                            .read(tasksProvider.notifier)
                            .completeTask(task);
                      },
                    ))
                .toList(),
          ),
        ),
        // Overflow indicator
        if (overflowCount > 0)
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.xs),
            child: Text(
              '+$overflowCount tarea${overflowCount > 1 ? 's' : ''} mas',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: AppSizes.fontXs,
              ),
            ),
          ),
      ],
    );
  }
}

class _TaskRow extends StatelessWidget {
  final PendingTaskModel task;
  final VoidCallback onComplete;

  const _TaskRow({required this.task, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final occurrenceDateTime = DateTime.tryParse(task.occurrenceDate);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isOverdue = occurrenceDateTime != null &&
        DateTime(
              occurrenceDateTime.year,
              occurrenceDateTime.month,
              occurrenceDateTime.day,
            ).isBefore(today);
    final isToday = occurrenceDateTime != null &&
        DateTime(
              occurrenceDateTime.year,
              occurrenceDateTime.month,
              occurrenceDateTime.day,
            ) ==
            today;

    final Color accentColor;
    if (isOverdue) {
      accentColor = colorScheme.error;
    } else if (isToday) {
      accentColor = Colors.amber.shade700;
    } else {
      accentColor = colorScheme.outline;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
      child: Row(
        children: [
          // Completion circle button
          GestureDetector(
            onTap: onComplete,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accentColor, width: 2),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          // Task info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (occurrenceDateTime != null)
                  Text(
                    _formatDue(occurrenceDateTime, isOverdue, isToday),
                    style: TextStyle(
                      fontSize: AppSizes.fontXs,
                      color: isOverdue
                          ? colorScheme.error
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDue(DateTime date, bool isOverdue, bool isToday) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDay = DateTime(date.year, date.month, date.day);
    final diff = taskDay.difference(today).inDays;

    if (isToday) return 'Hoy';
    if (diff == 1) return 'Manana';
    if (diff == -1) return 'Ayer (vencida)';
    if (isOverdue) return 'Vencida hace ${diff.abs()} dias';
    return 'En $diff dias';
  }
}
