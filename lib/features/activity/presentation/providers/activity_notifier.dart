import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/activity/data/repositories/activity_repository.dart';
import 'package:nuestra_app/features/activity/presentation/providers/activity_state.dart';

part 'activity_notifier.g.dart';

/// Notifier for the activity feed
@Riverpod(keepAlive: true)
class ActivityFeedNotifier extends _$ActivityFeedNotifier {
  late final ActivityRepository _repository;

  @override
  ActivityFeedState build() {
    _repository = ref.watch(activityRepositoryProvider);
    return const ActivityFeedState.initial();
  }

  /// Load activity feed only if not already loaded (for screen init)
  Future<void> loadIfNeeded(String householdId) async {
    if (state is ActivityFeedStateInitial || state is ActivityFeedStateError) {
      await load(householdId);
    }
  }

  /// Load activity feed for a household
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> load(String householdId, {bool forceLoading = false}) async {
    final hasData = state is ActivityFeedStateLoaded;

    // Only show loading spinner if no data exists yet or forced
    if (!hasData || forceLoading) {
      state = const ActivityFeedState.loading();
    }

    try {
      final activities = await _repository.getActivityFeed(householdId);
      state = ActivityFeedState.loaded(
        activities,
        hasMore: activities.length >= 20,
      );
    } on AppException catch (e) {
      // Only show error if we don't have existing data
      if (!hasData) {
        state = ActivityFeedState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = ActivityFeedState.error('Error al cargar actividad: $e');
      }
    }
  }

  /// Load more activity items (pagination)
  Future<void> loadMore(String householdId) async {
    final current = state;
    if (current is! ActivityFeedStateLoaded || !current.hasMore) return;

    try {
      final more = await _repository.getActivityFeed(
        householdId,
        offset: current.activities.length,
      );
      state = ActivityFeedState.loaded(
        [...current.activities, ...more],
        hasMore: more.length >= 20,
      );
    } catch (e) {
      // Keep existing data on load more failure
    }
  }
}
