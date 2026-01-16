import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_model.freezed.dart';
part 'calendar_model.g.dart';

/// Recurrence type enum
enum RecurrenceType {
  @JsonValue('none')
  none,
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
}

/// Minimal user model for calendar references
@freezed
sealed class CalendarUserModel with _$CalendarUserModel {
  const factory CalendarUserModel({
    required String id,
    required String name,
    String? avatarUrl,
  }) = _CalendarUserModel;

  factory CalendarUserModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarUserModelFromJson(json);
}

/// Minimal board reference for linked events
@freezed
sealed class LinkedBoardModel with _$LinkedBoardModel {
  const factory LinkedBoardModel({
    required String id,
    required String name,
  }) = _LinkedBoardModel;

  factory LinkedBoardModel.fromJson(Map<String, dynamic> json) =>
      _$LinkedBoardModelFromJson(json);
}

/// Minimal recipe reference for linked events
@freezed
sealed class LinkedRecipeModel with _$LinkedRecipeModel {
  const factory LinkedRecipeModel({
    required String id,
    required String title,
  }) = _LinkedRecipeModel;

  factory LinkedRecipeModel.fromJson(Map<String, dynamic> json) =>
      _$LinkedRecipeModelFromJson(json);
}

/// Minimal menu plan reference for linked events
@freezed
sealed class LinkedMenuPlanModel with _$LinkedMenuPlanModel {
  const factory LinkedMenuPlanModel({
    required String id,
    required String name,
  }) = _LinkedMenuPlanModel;

  factory LinkedMenuPlanModel.fromJson(Map<String, dynamic> json) =>
      _$LinkedMenuPlanModelFromJson(json);
}

/// Model for a calendar event
@freezed
sealed class CalendarEventModel with _$CalendarEventModel {
  const factory CalendarEventModel({
    required String id,
    required String householdId,
    required String title,
    String? description,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool allDay,
    @Default(RecurrenceType.none) RecurrenceType recurrence,
    DateTime? recurrenceEndDate,
    LinkedBoardModel? linkedBoard,
    LinkedRecipeModel? linkedRecipe,
    LinkedMenuPlanModel? linkedMenuPlan,
    CalendarUserModel? createdBy,
    @Default(false) bool isOccurrence,
    DateTime? occurrenceDate,
    String? occurrenceId,
    DateTime? createdAt,
  }) = _CalendarEventModel;

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);
}

/// Timeline item type enum
enum TimelineItemType {
  @JsonValue('calendar_event')
  calendarEvent,
  @JsonValue('menu_item')
  menuItem,
  @JsonValue('board_item')
  boardItem,
}

/// Base model for timeline items
@freezed
sealed class TimelineItemModel with _$TimelineItemModel {
  /// Calendar event timeline item
  const factory TimelineItemModel.calendarEvent({
    required String id,
    required DateTime date,
    String? masterId,
    required String title,
    String? description,
    @Default(false) bool allDay,
    @Default(false) bool isOccurrence,
    LinkedBoardModel? linkedBoard,
    LinkedRecipeModel? linkedRecipe,
    LinkedMenuPlanModel? linkedMenuPlan,
  }) = TimelineCalendarEvent;

  /// Menu item timeline item
  const factory TimelineItemModel.menuItem({
    required String id,
    required DateTime date,
    required String title,
    required String mealType,
    TimelineRecipeRef? recipe,
    TimelineMenuPlanRef? menuPlan,
  }) = TimelineMenuItem;

  /// Board item timeline item
  const factory TimelineItemModel.boardItem({
    required String id,
    required DateTime date,
    required String title,
    required String itemType,
    String? url,
    String? thumbnailUrl,
    TimelineBoardRef? board,
    CalendarUserModel? createdBy,
  }) = TimelineBoardItem;

  factory TimelineItemModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    switch (type) {
      case 'calendar_event':
        return TimelineItemModel.calendarEvent(
          id: json['id'] as String,
          date: DateTime.parse(json['date'] as String),
          masterId: json['masterId'] as String?,
          title: json['title'] as String,
          description: json['description'] as String?,
          allDay: json['allDay'] as bool? ?? false,
          isOccurrence: json['isOccurrence'] as bool? ?? false,
          linkedBoard: json['linkedBoard'] != null
              ? LinkedBoardModel.fromJson(
                  json['linkedBoard'] as Map<String, dynamic>)
              : null,
          linkedRecipe: json['linkedRecipe'] != null
              ? LinkedRecipeModel.fromJson(
                  json['linkedRecipe'] as Map<String, dynamic>)
              : null,
          linkedMenuPlan: json['linkedMenuPlan'] != null
              ? LinkedMenuPlanModel.fromJson(
                  json['linkedMenuPlan'] as Map<String, dynamic>)
              : null,
        );
      case 'menu_item':
        return TimelineItemModel.menuItem(
          id: json['id'] as String,
          date: DateTime.parse(json['date'] as String),
          title: json['title'] as String,
          mealType: json['mealType'] as String,
          recipe: json['recipe'] != null
              ? TimelineRecipeRef.fromJson(
                  json['recipe'] as Map<String, dynamic>)
              : null,
          menuPlan: json['menuPlan'] != null
              ? TimelineMenuPlanRef.fromJson(
                  json['menuPlan'] as Map<String, dynamic>)
              : null,
        );
      case 'board_item':
        return TimelineItemModel.boardItem(
          id: json['id'] as String,
          date: DateTime.parse(json['date'] as String),
          title: json['title'] as String,
          itemType: json['itemType'] as String,
          url: json['url'] as String?,
          thumbnailUrl: json['thumbnailUrl'] as String?,
          board: json['board'] != null
              ? TimelineBoardRef.fromJson(json['board'] as Map<String, dynamic>)
              : null,
          createdBy: json['createdBy'] != null
              ? CalendarUserModel.fromJson(
                  json['createdBy'] as Map<String, dynamic>)
              : null,
        );
      default:
        throw FormatException('Unknown timeline item type: $type');
    }
  }
}

/// Recipe reference for timeline menu items
@freezed
sealed class TimelineRecipeRef with _$TimelineRecipeRef {
  const factory TimelineRecipeRef({
    required String id,
    required String title,
    String? imageUrl,
  }) = _TimelineRecipeRef;

  factory TimelineRecipeRef.fromJson(Map<String, dynamic> json) =>
      _$TimelineRecipeRefFromJson(json);
}

/// Menu plan reference for timeline menu items
@freezed
sealed class TimelineMenuPlanRef with _$TimelineMenuPlanRef {
  const factory TimelineMenuPlanRef({
    required String id,
    required String name,
  }) = _TimelineMenuPlanRef;

  factory TimelineMenuPlanRef.fromJson(Map<String, dynamic> json) =>
      _$TimelineMenuPlanRefFromJson(json);
}

/// Board reference for timeline board items
@freezed
sealed class TimelineBoardRef with _$TimelineBoardRef {
  const factory TimelineBoardRef({
    required String id,
    required String name,
  }) = _TimelineBoardRef;

  factory TimelineBoardRef.fromJson(Map<String, dynamic> json) =>
      _$TimelineBoardRefFromJson(json);
}
