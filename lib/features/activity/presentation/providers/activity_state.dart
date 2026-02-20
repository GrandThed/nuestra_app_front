import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/activity/data/models/activity_model.dart';

part 'activity_state.freezed.dart';

@freezed
sealed class ActivityFeedState with _$ActivityFeedState {
  const factory ActivityFeedState.initial() = ActivityFeedStateInitial;
  const factory ActivityFeedState.loading() = ActivityFeedStateLoading;
  const factory ActivityFeedState.loaded(
    List<ActivityLogModel> activities, {
    @Default(false) bool hasMore,
  }) = ActivityFeedStateLoaded;
  const factory ActivityFeedState.error(String message) =
      ActivityFeedStateError;
}
