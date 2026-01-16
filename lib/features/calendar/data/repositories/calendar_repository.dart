import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/calendar/data/models/calendar_model.dart';

/// Provider for CalendarRepository
final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository(dioClient: ref.watch(dioClientProvider));
});

/// Repository for calendar operations
class CalendarRepository {
  final DioClient _dioClient;

  CalendarRepository({required DioClient dioClient}) : _dioClient = dioClient;

  // ==================== EVENTS ====================

  /// Get calendar events for a date range (with recurring expansion)
  Future<List<CalendarEventModel>> getEvents(
    String householdId, {
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.calendar,
      queryParameters: {
        'householdId': householdId,
        'from': from.toIso8601String(),
        'to': to.toIso8601String(),
      },
    );

    final events = response['data']['events'] as List<dynamic>? ?? [];
    return events
        .map((e) => CalendarEventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get a single event by ID
  Future<CalendarEventModel> getEvent(String id) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.calendarEvent(id),
    );

    return CalendarEventModel.fromJson(
        response['data']['event'] as Map<String, dynamic>);
  }

  /// Create a new calendar event
  Future<CalendarEventModel> createEvent({
    required String householdId,
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
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.calendar,
      data: {
        'householdId': householdId,
        'title': title,
        'startDate': startDate.toIso8601String(),
        if (description != null) 'description': description,
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        'allDay': allDay,
        'recurrence': recurrence.name,
        if (recurrenceEndDate != null)
          'recurrenceEndDate': recurrenceEndDate.toIso8601String(),
        if (linkedBoardId != null) 'linkedBoardId': linkedBoardId,
        if (linkedRecipeId != null) 'linkedRecipeId': linkedRecipeId,
        if (linkedMenuPlanId != null) 'linkedMenuPlanId': linkedMenuPlanId,
      },
    );

    return CalendarEventModel.fromJson(
        response['data']['event'] as Map<String, dynamic>);
  }

  /// Update a calendar event
  Future<CalendarEventModel> updateEvent({
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
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.calendarEvent(id),
      data: {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        if (allDay != null) 'allDay': allDay,
        if (recurrence != null) 'recurrence': recurrence.name,
        if (recurrenceEndDate != null)
          'recurrenceEndDate': recurrenceEndDate.toIso8601String(),
        if (linkedBoardId != null) 'linkedBoardId': linkedBoardId,
        if (linkedRecipeId != null) 'linkedRecipeId': linkedRecipeId,
        if (linkedMenuPlanId != null) 'linkedMenuPlanId': linkedMenuPlanId,
      },
    );

    return CalendarEventModel.fromJson(
        response['data']['event'] as Map<String, dynamic>);
  }

  /// Delete a calendar event
  /// If deleteRecurring is 'future' and occurrenceDate is provided,
  /// only future occurrences from that date will be deleted
  Future<void> deleteEvent(
    String id, {
    String? deleteRecurring,
    DateTime? occurrenceDate,
  }) async {
    final queryParams = <String, dynamic>{};
    if (deleteRecurring != null) queryParams['deleteRecurring'] = deleteRecurring;
    if (occurrenceDate != null) {
      queryParams['occurrenceDate'] = occurrenceDate.toIso8601String();
    }

    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.calendarEvent(id),
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  // ==================== TIMELINE ====================

  /// Get unified timeline (events, menu items, board items)
  Future<List<TimelineItemModel>> getTimeline(
    String householdId, {
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.calendarTimeline,
      queryParameters: {
        'householdId': householdId,
        'from': from.toIso8601String(),
        'to': to.toIso8601String(),
      },
    );

    final items = response['data']['timeline'] as List<dynamic>? ?? [];
    return items
        .map((item) => TimelineItemModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
