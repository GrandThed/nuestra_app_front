// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for calendar operations

@ProviderFor(CalendarNotifier)
final calendarProvider = CalendarNotifierProvider._();

/// Notifier for calendar operations
final class CalendarNotifierProvider
    extends $NotifierProvider<CalendarNotifier, CalendarState> {
  /// Notifier for calendar operations
  CalendarNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarNotifierHash();

  @$internal
  @override
  CalendarNotifier create() => CalendarNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarState>(value),
    );
  }
}

String _$calendarNotifierHash() => r'463f226805aac2b872aed26e6363e0cc3677463e';

/// Notifier for calendar operations

abstract class _$CalendarNotifier extends $Notifier<CalendarState> {
  CalendarState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CalendarState, CalendarState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalendarState, CalendarState>,
              CalendarState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for timeline view

@ProviderFor(TimelineNotifier)
final timelineProvider = TimelineNotifierProvider._();

/// Notifier for timeline view
final class TimelineNotifierProvider
    extends $NotifierProvider<TimelineNotifier, TimelineState> {
  /// Notifier for timeline view
  TimelineNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timelineNotifierHash();

  @$internal
  @override
  TimelineNotifier create() => TimelineNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimelineState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimelineState>(value),
    );
  }
}

String _$timelineNotifierHash() => r'004478d11bfdab72e61a4a2e071d1d481429b37d';

/// Notifier for timeline view

abstract class _$TimelineNotifier extends $Notifier<TimelineState> {
  TimelineState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TimelineState, TimelineState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TimelineState, TimelineState>,
              TimelineState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider for events on a specific date

@ProviderFor(eventsForDate)
final eventsForDateProvider = EventsForDateFamily._();

/// Provider for events on a specific date

final class EventsForDateProvider
    extends
        $FunctionalProvider<
          List<CalendarEventModel>,
          List<CalendarEventModel>,
          List<CalendarEventModel>
        >
    with $Provider<List<CalendarEventModel>> {
  /// Provider for events on a specific date
  EventsForDateProvider._({
    required EventsForDateFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'eventsForDateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventsForDateHash();

  @override
  String toString() {
    return r'eventsForDateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<CalendarEventModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CalendarEventModel> create(Ref ref) {
    final argument = this.argument as DateTime;
    return eventsForDate(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CalendarEventModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CalendarEventModel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EventsForDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventsForDateHash() => r'ad6677f1e22c0867b0a44fb10ea69bb08eeb3802';

/// Provider for events on a specific date

final class EventsForDateFamily extends $Family
    with $FunctionalFamilyOverride<List<CalendarEventModel>, DateTime> {
  EventsForDateFamily._()
    : super(
        retry: null,
        name: r'eventsForDateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for events on a specific date

  EventsForDateProvider call(DateTime date) =>
      EventsForDateProvider._(argument: date, from: this);

  @override
  String toString() => r'eventsForDateProvider';
}

/// Provider for events count per day (for calendar markers)

@ProviderFor(eventCountsByDay)
final eventCountsByDayProvider = EventCountsByDayProvider._();

/// Provider for events count per day (for calendar markers)

final class EventCountsByDayProvider
    extends
        $FunctionalProvider<
          Map<DateTime, int>,
          Map<DateTime, int>,
          Map<DateTime, int>
        >
    with $Provider<Map<DateTime, int>> {
  /// Provider for events count per day (for calendar markers)
  EventCountsByDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventCountsByDayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventCountsByDayHash();

  @$internal
  @override
  $ProviderElement<Map<DateTime, int>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<DateTime, int> create(Ref ref) {
    return eventCountsByDay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<DateTime, int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<DateTime, int>>(value),
    );
  }
}

String _$eventCountsByDayHash() => r'72889e625d2feea50397ba1d0b9a77e9a4318261';

/// Provider for upcoming events count (for home dashboard)

@ProviderFor(upcomingEventsCount)
final upcomingEventsCountProvider = UpcomingEventsCountProvider._();

/// Provider for upcoming events count (for home dashboard)

final class UpcomingEventsCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider for upcoming events count (for home dashboard)
  UpcomingEventsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingEventsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingEventsCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return upcomingEventsCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$upcomingEventsCountHash() =>
    r'b0bc83e4e0230a58df2a4498ee5c41720cd31622';
