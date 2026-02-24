// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TasksNotifier)
final tasksProvider = TasksNotifierProvider._();

final class TasksNotifierProvider
    extends $NotifierProvider<TasksNotifier, TasksState> {
  TasksNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksNotifierHash();

  @$internal
  @override
  TasksNotifier create() => TasksNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TasksState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TasksState>(value),
    );
  }
}

String _$tasksNotifierHash() => r'c0cc8d19026460d78c2802b06364ec85d0d9f58e';

abstract class _$TasksNotifier extends $Notifier<TasksState> {
  TasksState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TasksState, TasksState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TasksState, TasksState>,
              TasksState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Top 3 pending tasks for the home card

@ProviderFor(topPendingTasks)
final topPendingTasksProvider = TopPendingTasksProvider._();

/// Top 3 pending tasks for the home card

final class TopPendingTasksProvider
    extends
        $FunctionalProvider<
          List<PendingTaskModel>,
          List<PendingTaskModel>,
          List<PendingTaskModel>
        >
    with $Provider<List<PendingTaskModel>> {
  /// Top 3 pending tasks for the home card
  TopPendingTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topPendingTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topPendingTasksHash();

  @$internal
  @override
  $ProviderElement<List<PendingTaskModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PendingTaskModel> create(Ref ref) {
    return topPendingTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PendingTaskModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PendingTaskModel>>(value),
    );
  }
}

String _$topPendingTasksHash() => r'b51e8fc45ad01747b80eed3db68cf6fe95f13289';

/// Total pending task count (for overflow display)

@ProviderFor(pendingTasksCount)
final pendingTasksCountProvider = PendingTasksCountProvider._();

/// Total pending task count (for overflow display)

final class PendingTasksCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Total pending task count (for overflow display)
  PendingTasksCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingTasksCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingTasksCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return pendingTasksCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pendingTasksCountHash() => r'233969dd2f542036309389ee1776fe3ef4dabfa4';
