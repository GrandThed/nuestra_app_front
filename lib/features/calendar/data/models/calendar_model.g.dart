// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarUserModel _$CalendarUserModelFromJson(Map<String, dynamic> json) =>
    _CalendarUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$CalendarUserModelToJson(_CalendarUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };

_LinkedBoardModel _$LinkedBoardModelFromJson(Map<String, dynamic> json) =>
    _LinkedBoardModel(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$LinkedBoardModelToJson(_LinkedBoardModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_LinkedRecipeModel _$LinkedRecipeModelFromJson(Map<String, dynamic> json) =>
    _LinkedRecipeModel(
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$LinkedRecipeModelToJson(_LinkedRecipeModel instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};

_LinkedMenuPlanModel _$LinkedMenuPlanModelFromJson(Map<String, dynamic> json) =>
    _LinkedMenuPlanModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LinkedMenuPlanModelToJson(
  _LinkedMenuPlanModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_CalendarEventModel _$CalendarEventModelFromJson(Map<String, dynamic> json) =>
    _CalendarEventModel(
      id: json['id'] as String,
      householdId: json['householdId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate:
          json['endDate'] == null
              ? null
              : DateTime.parse(json['endDate'] as String),
      allDay: json['allDay'] as bool? ?? false,
      recurrence:
          $enumDecodeNullable(_$RecurrenceTypeEnumMap, json['recurrence']) ??
          RecurrenceType.none,
      recurrenceEndDate:
          json['recurrenceEndDate'] == null
              ? null
              : DateTime.parse(json['recurrenceEndDate'] as String),
      linkedBoard:
          json['linkedBoard'] == null
              ? null
              : LinkedBoardModel.fromJson(
                json['linkedBoard'] as Map<String, dynamic>,
              ),
      linkedRecipe:
          json['linkedRecipe'] == null
              ? null
              : LinkedRecipeModel.fromJson(
                json['linkedRecipe'] as Map<String, dynamic>,
              ),
      linkedMenuPlan:
          json['linkedMenuPlan'] == null
              ? null
              : LinkedMenuPlanModel.fromJson(
                json['linkedMenuPlan'] as Map<String, dynamic>,
              ),
      createdBy:
          json['createdBy'] == null
              ? null
              : CalendarUserModel.fromJson(
                json['createdBy'] as Map<String, dynamic>,
              ),
      isOccurrence: json['isOccurrence'] as bool? ?? false,
      occurrenceDate:
          json['occurrenceDate'] == null
              ? null
              : DateTime.parse(json['occurrenceDate'] as String),
      occurrenceId: json['occurrenceId'] as String?,
      colorHex: json['colorHex'] as String?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CalendarEventModelToJson(_CalendarEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'allDay': instance.allDay,
      'recurrence': _$RecurrenceTypeEnumMap[instance.recurrence]!,
      'recurrenceEndDate': instance.recurrenceEndDate?.toIso8601String(),
      'linkedBoard': instance.linkedBoard,
      'linkedRecipe': instance.linkedRecipe,
      'linkedMenuPlan': instance.linkedMenuPlan,
      'createdBy': instance.createdBy,
      'isOccurrence': instance.isOccurrence,
      'occurrenceDate': instance.occurrenceDate?.toIso8601String(),
      'occurrenceId': instance.occurrenceId,
      'colorHex': instance.colorHex,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$RecurrenceTypeEnumMap = {
  RecurrenceType.none: 'none',
  RecurrenceType.daily: 'daily',
  RecurrenceType.weekly: 'weekly',
  RecurrenceType.monthly: 'monthly',
  RecurrenceType.yearly: 'yearly',
};

_TimelineRecipeRef _$TimelineRecipeRefFromJson(Map<String, dynamic> json) =>
    _TimelineRecipeRef(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$TimelineRecipeRefToJson(_TimelineRecipeRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };

_TimelineMenuPlanRef _$TimelineMenuPlanRefFromJson(Map<String, dynamic> json) =>
    _TimelineMenuPlanRef(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TimelineMenuPlanRefToJson(
  _TimelineMenuPlanRef instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_TimelineBoardRef _$TimelineBoardRefFromJson(Map<String, dynamic> json) =>
    _TimelineBoardRef(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$TimelineBoardRefToJson(_TimelineBoardRef instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_AvailabilityDayModel _$AvailabilityDayModelFromJson(
  Map<String, dynamic> json,
) => _AvailabilityDayModel(
  date: json['date'] as String,
  events:
      (json['events'] as List<dynamic>)
          .map(
            (e) => AvailabilityEventModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  isFree: json['isFree'] as bool,
);

Map<String, dynamic> _$AvailabilityDayModelToJson(
  _AvailabilityDayModel instance,
) => <String, dynamic>{
  'date': instance.date,
  'events': instance.events,
  'isFree': instance.isFree,
};

_AvailabilityEventModel _$AvailabilityEventModelFromJson(
  Map<String, dynamic> json,
) => _AvailabilityEventModel(
  id: json['id'] as String,
  title: json['title'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String?,
  allDay: json['allDay'] as bool,
  createdById: json['createdById'] as String,
);

Map<String, dynamic> _$AvailabilityEventModelToJson(
  _AvailabilityEventModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'allDay': instance.allDay,
  'createdById': instance.createdById,
};

_AvailabilityMemberModel _$AvailabilityMemberModelFromJson(
  Map<String, dynamic> json,
) => _AvailabilityMemberModel(
  userId: json['userId'] as String,
  name: json['name'] as String,
  colorHex: json['colorHex'] as String,
);

Map<String, dynamic> _$AvailabilityMemberModelToJson(
  _AvailabilityMemberModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'colorHex': instance.colorHex,
};

_AvailabilityResultModel _$AvailabilityResultModelFromJson(
  Map<String, dynamic> json,
) => _AvailabilityResultModel(
  members:
      (json['members'] as List<dynamic>)
          .map(
            (e) => AvailabilityMemberModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  days:
      (json['days'] as List<dynamic>)
          .map((e) => AvailabilityDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AvailabilityResultModelToJson(
  _AvailabilityResultModel instance,
) => <String, dynamic>{'members': instance.members, 'days': instance.days};
