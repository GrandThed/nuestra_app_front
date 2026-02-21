// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for the activity feed

@ProviderFor(ActivityFeedNotifier)
final activityFeedProvider = ActivityFeedNotifierProvider._();

/// Notifier for the activity feed
final class ActivityFeedNotifierProvider
    extends $NotifierProvider<ActivityFeedNotifier, ActivityFeedState> {
  /// Notifier for the activity feed
  ActivityFeedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityFeedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityFeedNotifierHash();

  @$internal
  @override
  ActivityFeedNotifier create() => ActivityFeedNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivityFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivityFeedState>(value),
    );
  }
}

String _$activityFeedNotifierHash() =>
    r'2168358e94a3350390eec7fcaba6a592c57e8143';

/// Notifier for the activity feed

abstract class _$ActivityFeedNotifier extends $Notifier<ActivityFeedState> {
  ActivityFeedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ActivityFeedState, ActivityFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActivityFeedState, ActivityFeedState>,
              ActivityFeedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
