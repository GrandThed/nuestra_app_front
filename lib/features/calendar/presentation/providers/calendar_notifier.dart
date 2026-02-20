import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/calendar/data/models/calendar_model.dart';
import 'package:nuestra_app/features/calendar/data/repositories/calendar_repository.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_state.dart';

part 'calendar_notifier.g.dart';

/// Notifier for calendar operations
@Riverpod(keepAlive: true)
class CalendarNotifier extends _$CalendarNotifier {
  late final CalendarRepository _repository;

  @override
  CalendarState build() {
    _repository = ref.watch(calendarRepositoryProvider);
    return const CalendarState.initial();
  }

  /// Load events only if not already loaded (for screen init)
  Future<void> loadEventsIfNeeded() async {
    if (state is CalendarStateInitial || state is CalendarStateError) {
      await loadEvents();
    }
  }

  /// Load events for the currently focused month
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadEvents({
    bool forceLoading = false,
    DateTime? focusedMonth,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const CalendarState.error('No hay hogar seleccionado');
      return;
    }

    final now = DateTime.now();
    final currentState = state;

    // Determine focused month and selected date
    final month = focusedMonth ??
        (currentState is CalendarStateLoaded
            ? currentState.focusedMonth
            : DateTime(now.year, now.month, 1));
    final selectedDate = currentState is CalendarStateLoaded
        ? currentState.selectedDate
        : now;
    final viewMode = currentState is CalendarStateLoaded
        ? currentState.viewMode
        : CalendarViewMode.month;

    // Calculate date range for the month (include padding for calendar view)
    final from = DateTime(month.year, month.month - 1, 15);
    final to = DateTime(month.year, month.month + 2, 15);

    final hasData = currentState is CalendarStateLoaded;
    if (!hasData || forceLoading) {
      state = const CalendarState.loading();
    }

    try {
      final events = await _repository.getEvents(
        householdId,
        from: from,
        to: to,
      );

      state = CalendarState.loaded(
        events: events,
        selectedDate: selectedDate,
        focusedMonth: month,
        viewMode: viewMode,
      );
    } on AppException catch (e) {
      if (!hasData) {
        state = CalendarState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = CalendarState.error('Error al cargar eventos: $e');
      }
    }
  }

  /// Change the selected date
  void setSelectedDate(DateTime date) {
    final currentState = state;
    if (currentState is CalendarStateLoaded) {
      state = CalendarState.loaded(
        events: currentState.events,
        selectedDate: date,
        focusedMonth: currentState.focusedMonth,
        viewMode: currentState.viewMode,
      );
    }
  }

  /// Change the focused month and reload events
  Future<void> setFocusedMonth(DateTime month) async {
    await loadEvents(focusedMonth: DateTime(month.year, month.month, 1));
  }

  /// Toggle between month and timeline view
  void setViewMode(CalendarViewMode mode) {
    final currentState = state;
    if (currentState is CalendarStateLoaded) {
      state = CalendarState.loaded(
        events: currentState.events,
        selectedDate: currentState.selectedDate,
        focusedMonth: currentState.focusedMonth,
        viewMode: mode,
      );
    }
  }

  /// Go to today
  Future<void> goToToday() async {
    final now = DateTime.now();
    final currentState = state;
    if (currentState is CalendarStateLoaded) {
      // If already in the same month, just update selected date
      if (currentState.focusedMonth.year == now.year &&
          currentState.focusedMonth.month == now.month) {
        setSelectedDate(now);
      } else {
        // Otherwise, load the current month
        await loadEvents(focusedMonth: DateTime(now.year, now.month, 1));
        setSelectedDate(now);
      }
    } else {
      await loadEvents();
    }
  }

  // ==================== EVENT OPERATIONS ====================

  /// Create a new event
  Future<CalendarEventModel?> createEvent({
    required String title,
    required DateTime startDate,
    String? description,
    DateTime? endDate,
    bool allDay = false,
    RecurrenceType recurrence = RecurrenceType.none,
    DateTime? recurrenceEndDate,
    String? linkedBoardId,
    String? linkedRecipeId,
    String? linkedMenuPlanId,
    String? colorHex,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final event = await _repository.createEvent(
        householdId: householdId,
        title: title,
        startDate: startDate,
        description: description,
        endDate: endDate,
        allDay: allDay,
        recurrence: recurrence,
        recurrenceEndDate: recurrenceEndDate,
        linkedBoardId: linkedBoardId,
        linkedRecipeId: linkedRecipeId,
        linkedMenuPlanId: linkedMenuPlanId,
        colorHex: colorHex,
      );

      // Add to current list if in visible range
      final currentState = state;
      if (currentState is CalendarStateLoaded) {
        state = CalendarState.loaded(
          events: [...currentState.events, event],
          selectedDate: currentState.selectedDate,
          focusedMonth: currentState.focusedMonth,
          viewMode: currentState.viewMode,
        );
      }

      return event;
    } on AppException catch (e) {
      debugPrint('Error creating event: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating event: $e');
      return null;
    }
  }

  /// Update an event
  Future<CalendarEventModel?> updateEvent({
    required String id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? allDay,
    RecurrenceType? recurrence,
    DateTime? recurrenceEndDate,
    String? linkedBoardId,
    String? linkedRecipeId,
    String? linkedMenuPlanId,
    String? colorHex,
  }) async {
    try {
      final event = await _repository.updateEvent(
        id: id,
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        allDay: allDay,
        recurrence: recurrence,
        recurrenceEndDate: recurrenceEndDate,
        linkedBoardId: linkedBoardId,
        linkedRecipeId: linkedRecipeId,
        linkedMenuPlanId: linkedMenuPlanId,
        colorHex: colorHex,
      );

      // Update in current list
      final currentState = state;
      if (currentState is CalendarStateLoaded) {
        final updatedEvents = currentState.events.map((e) {
          return e.id == id ? event : e;
        }).toList();
        state = CalendarState.loaded(
          events: updatedEvents,
          selectedDate: currentState.selectedDate,
          focusedMonth: currentState.focusedMonth,
          viewMode: currentState.viewMode,
        );
      }

      return event;
    } on AppException catch (e) {
      debugPrint('Error updating event: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating event: $e');
      return null;
    }
  }

  /// Delete an event
  Future<bool> deleteEvent(
    String id, {
    String? deleteRecurring,
    DateTime? occurrenceDate,
  }) async {
    try {
      await _repository.deleteEvent(
        id,
        deleteRecurring: deleteRecurring,
        occurrenceDate: occurrenceDate,
      );

      // Remove from current list
      final currentState = state;
      if (currentState is CalendarStateLoaded) {
        final updatedEvents =
            currentState.events.where((e) => e.id != id).toList();
        state = CalendarState.loaded(
          events: updatedEvents,
          selectedDate: currentState.selectedDate,
          focusedMonth: currentState.focusedMonth,
          viewMode: currentState.viewMode,
        );
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting event: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting event: $e');
      return false;
    }
  }

  // ==================== AVAILABILITY ====================

  /// Get availability for household members in a date range
  Future<AvailabilityResultModel?> getAvailability({
    required String householdId,
    required String from,
    required String to,
    List<String>? userIds,
  }) async {
    try {
      return await _repository.getAvailability(
        householdId: householdId,
        from: from,
        to: to,
        userIds: userIds,
      );
    } catch (e) {
      debugPrint('Error getting availability: $e');
      return null;
    }
  }

  // ==================== DATE NIGHT ====================

  /// Plan a date night event
  Future<CalendarEventModel?> planDateNight({
    required String householdId,
    String? preferredDay,
  }) async {
    try {
      final event = await _repository.planDateNight(
        householdId: householdId,
        preferredDay: preferredDay,
      );
      await loadEvents(); // Refresh to show new event
      return event;
    } catch (e) {
      debugPrint('Error planning date night: $e');
      return null;
    }
  }
}

/// Notifier for timeline view
@Riverpod(keepAlive: true)
class TimelineNotifier extends _$TimelineNotifier {
  late final CalendarRepository _repository;

  @override
  TimelineState build() {
    _repository = ref.watch(calendarRepositoryProvider);
    return const TimelineState.initial();
  }

  /// Load timeline only if not already loaded
  Future<void> loadTimelineIfNeeded({DateTime? from, DateTime? to}) async {
    if (state is TimelineStateInitial || state is TimelineStateError) {
      await loadTimeline(from: from, to: to);
    }
  }

  /// Load unified timeline
  Future<void> loadTimeline({
    bool forceLoading = false,
    DateTime? from,
    DateTime? to,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const TimelineState.error('No hay hogar seleccionado');
      return;
    }

    final now = DateTime.now();
    final fromDate = from ?? DateTime(now.year, now.month, 1);
    final toDate = to ?? DateTime(now.year, now.month + 1, 0);

    final hasData = state is TimelineStateLoaded;
    if (!hasData || forceLoading) {
      state = const TimelineState.loading();
    }

    try {
      final items = await _repository.getTimeline(
        householdId,
        from: fromDate,
        to: toDate,
      );

      state = TimelineState.loaded(items);
    } on AppException catch (e) {
      if (!hasData) {
        state = TimelineState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = TimelineState.error('Error al cargar timeline: $e');
      }
    }
  }
}

/// Provider for events on a specific date
@riverpod
List<CalendarEventModel> eventsForDate(Ref ref, DateTime date) {
  final state = ref.watch(calendarNotifierProvider);
  if (state is CalendarStateLoaded) {
    return state.events.where((e) {
      final eventDate = e.occurrenceDate ?? e.startDate;
      return eventDate.year == date.year &&
          eventDate.month == date.month &&
          eventDate.day == date.day;
    }).toList();
  }
  return [];
}

/// Provider for events count per day (for calendar markers)
@riverpod
Map<DateTime, int> eventCountsByDay(Ref ref) {
  final state = ref.watch(calendarNotifierProvider);
  if (state is CalendarStateLoaded) {
    final counts = <DateTime, int>{};
    for (final event in state.events) {
      final eventDate = event.occurrenceDate ?? event.startDate;
      final day = DateTime(eventDate.year, eventDate.month, eventDate.day);
      counts[day] = (counts[day] ?? 0) + 1;
    }
    return counts;
  }
  return {};
}

/// Provider for upcoming events count (for home dashboard)
@riverpod
int upcomingEventsCount(Ref ref) {
  final state = ref.watch(calendarNotifierProvider);
  if (state is CalendarStateLoaded) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekLater = today.add(const Duration(days: 7));
    return state.events.where((e) {
      final eventDate = e.occurrenceDate ?? e.startDate;
      return eventDate.isAfter(today) && eventDate.isBefore(weekLater);
    }).length;
  }
  return 0;
}
