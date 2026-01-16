import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/calendar/data/models/calendar_model.dart';

part 'calendar_state.freezed.dart';

/// View mode for calendar screen
enum CalendarViewMode {
  month,
  timeline,
}

/// Combined state for calendar screen
@freezed
sealed class CalendarState with _$CalendarState {
  const factory CalendarState.initial() = CalendarStateInitial;
  const factory CalendarState.loading() = CalendarStateLoading;
  const factory CalendarState.loaded({
    required List<CalendarEventModel> events,
    required DateTime selectedDate,
    required DateTime focusedMonth,
    @Default(CalendarViewMode.month) CalendarViewMode viewMode,
  }) = CalendarStateLoaded;
  const factory CalendarState.error(String message) = CalendarStateError;
}

/// State for timeline view
@freezed
sealed class TimelineState with _$TimelineState {
  const factory TimelineState.initial() = TimelineStateInitial;
  const factory TimelineState.loading() = TimelineStateLoading;
  const factory TimelineState.loaded(List<TimelineItemModel> items) = TimelineStateLoaded;
  const factory TimelineState.error(String message) = TimelineStateError;
}

/// State for a single event detail
@freezed
sealed class EventDetailState with _$EventDetailState {
  const factory EventDetailState.initial() = EventDetailStateInitial;
  const factory EventDetailState.loading() = EventDetailStateLoading;
  const factory EventDetailState.loaded(CalendarEventModel event) = EventDetailStateLoaded;
  const factory EventDetailState.error(String message) = EventDetailStateError;
}
