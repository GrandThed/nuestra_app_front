// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsForDateHash() => r'ad6677f1e22c0867b0a44fb10ea69bb08eeb3802';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for events on a specific date
///
/// Copied from [eventsForDate].
@ProviderFor(eventsForDate)
const eventsForDateProvider = EventsForDateFamily();

/// Provider for events on a specific date
///
/// Copied from [eventsForDate].
class EventsForDateFamily extends Family<List<CalendarEventModel>> {
  /// Provider for events on a specific date
  ///
  /// Copied from [eventsForDate].
  const EventsForDateFamily();

  /// Provider for events on a specific date
  ///
  /// Copied from [eventsForDate].
  EventsForDateProvider call(DateTime date) {
    return EventsForDateProvider(date);
  }

  @override
  EventsForDateProvider getProviderOverride(
    covariant EventsForDateProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventsForDateProvider';
}

/// Provider for events on a specific date
///
/// Copied from [eventsForDate].
class EventsForDateProvider
    extends AutoDisposeProvider<List<CalendarEventModel>> {
  /// Provider for events on a specific date
  ///
  /// Copied from [eventsForDate].
  EventsForDateProvider(DateTime date)
    : this._internal(
        (ref) => eventsForDate(ref as EventsForDateRef, date),
        from: eventsForDateProvider,
        name: r'eventsForDateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$eventsForDateHash,
        dependencies: EventsForDateFamily._dependencies,
        allTransitiveDependencies:
            EventsForDateFamily._allTransitiveDependencies,
        date: date,
      );

  EventsForDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    List<CalendarEventModel> Function(EventsForDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsForDateProvider._internal(
        (ref) => create(ref as EventsForDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<CalendarEventModel>> createElement() {
    return _EventsForDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsForDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventsForDateRef on AutoDisposeProviderRef<List<CalendarEventModel>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _EventsForDateProviderElement
    extends AutoDisposeProviderElement<List<CalendarEventModel>>
    with EventsForDateRef {
  _EventsForDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as EventsForDateProvider).date;
}

String _$eventCountsByDayHash() => r'72889e625d2feea50397ba1d0b9a77e9a4318261';

/// Provider for events count per day (for calendar markers)
///
/// Copied from [eventCountsByDay].
@ProviderFor(eventCountsByDay)
final eventCountsByDayProvider =
    AutoDisposeProvider<Map<DateTime, int>>.internal(
      eventCountsByDay,
      name: r'eventCountsByDayProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$eventCountsByDayHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventCountsByDayRef = AutoDisposeProviderRef<Map<DateTime, int>>;
String _$upcomingEventsCountHash() =>
    r'b0bc83e4e0230a58df2a4498ee5c41720cd31622';

/// Provider for upcoming events count (for home dashboard)
///
/// Copied from [upcomingEventsCount].
@ProviderFor(upcomingEventsCount)
final upcomingEventsCountProvider = AutoDisposeProvider<int>.internal(
  upcomingEventsCount,
  name: r'upcomingEventsCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$upcomingEventsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingEventsCountRef = AutoDisposeProviderRef<int>;
String _$calendarNotifierHash() => r'e7196d4fbb4fb2d2ab8243b114c463becc7cf874';

/// Notifier for calendar operations
///
/// Copied from [CalendarNotifier].
@ProviderFor(CalendarNotifier)
final calendarNotifierProvider =
    NotifierProvider<CalendarNotifier, CalendarState>.internal(
      CalendarNotifier.new,
      name: r'calendarNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$calendarNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CalendarNotifier = Notifier<CalendarState>;
String _$timelineNotifierHash() => r'004478d11bfdab72e61a4a2e071d1d481429b37d';

/// Notifier for timeline view
///
/// Copied from [TimelineNotifier].
@ProviderFor(TimelineNotifier)
final timelineNotifierProvider =
    NotifierProvider<TimelineNotifier, TimelineState>.internal(
      TimelineNotifier.new,
      name: r'timelineNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$timelineNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TimelineNotifier = Notifier<TimelineState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
