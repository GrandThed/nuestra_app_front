// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskUserRef {

 String get id; String get name; String? get avatarUrl;
/// Create a copy of TaskUserRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskUserRefCopyWith<TaskUserRef> get copyWith => _$TaskUserRefCopyWithImpl<TaskUserRef>(this as TaskUserRef, _$identity);

  /// Serializes this TaskUserRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskUserRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'TaskUserRef(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $TaskUserRefCopyWith<$Res>  {
  factory $TaskUserRefCopyWith(TaskUserRef value, $Res Function(TaskUserRef) _then) = _$TaskUserRefCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class _$TaskUserRefCopyWithImpl<$Res>
    implements $TaskUserRefCopyWith<$Res> {
  _$TaskUserRefCopyWithImpl(this._self, this._then);

  final TaskUserRef _self;
  final $Res Function(TaskUserRef) _then;

/// Create a copy of TaskUserRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskUserRef].
extension TaskUserRefPatterns on TaskUserRef {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskUserRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskUserRef() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskUserRef value)  $default,){
final _that = this;
switch (_that) {
case _TaskUserRef():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskUserRef value)?  $default,){
final _that = this;
switch (_that) {
case _TaskUserRef() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskUserRef() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _TaskUserRef():
return $default(_that.id,_that.name,_that.avatarUrl);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _TaskUserRef() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskUserRef implements TaskUserRef {
  const _TaskUserRef({required this.id, required this.name, this.avatarUrl});
  factory _TaskUserRef.fromJson(Map<String, dynamic> json) => _$TaskUserRefFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of TaskUserRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskUserRefCopyWith<_TaskUserRef> get copyWith => __$TaskUserRefCopyWithImpl<_TaskUserRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskUserRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskUserRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'TaskUserRef(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$TaskUserRefCopyWith<$Res> implements $TaskUserRefCopyWith<$Res> {
  factory _$TaskUserRefCopyWith(_TaskUserRef value, $Res Function(_TaskUserRef) _then) = __$TaskUserRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class __$TaskUserRefCopyWithImpl<$Res>
    implements _$TaskUserRefCopyWith<$Res> {
  __$TaskUserRefCopyWithImpl(this._self, this._then);

  final _TaskUserRef _self;
  final $Res Function(_TaskUserRef) _then;

/// Create a copy of TaskUserRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_TaskUserRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PendingTaskModel {

 String get id; String get householdId; String get title; String? get description; DateTime get startDate; String get occurrenceDate; String? get occurrenceId; String? get recurrenceDays; int? get recurrenceInterval; String? get colorHex; TaskUserRef? get createdBy;
/// Create a copy of PendingTaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingTaskModelCopyWith<PendingTaskModel> get copyWith => _$PendingTaskModelCopyWithImpl<PendingTaskModel>(this as PendingTaskModel, _$identity);

  /// Serializes this PendingTaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingTaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.occurrenceDate, occurrenceDate) || other.occurrenceDate == occurrenceDate)&&(identical(other.occurrenceId, occurrenceId) || other.occurrenceId == occurrenceId)&&(identical(other.recurrenceDays, recurrenceDays) || other.recurrenceDays == recurrenceDays)&&(identical(other.recurrenceInterval, recurrenceInterval) || other.recurrenceInterval == recurrenceInterval)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,title,description,startDate,occurrenceDate,occurrenceId,recurrenceDays,recurrenceInterval,colorHex,createdBy);

@override
String toString() {
  return 'PendingTaskModel(id: $id, householdId: $householdId, title: $title, description: $description, startDate: $startDate, occurrenceDate: $occurrenceDate, occurrenceId: $occurrenceId, recurrenceDays: $recurrenceDays, recurrenceInterval: $recurrenceInterval, colorHex: $colorHex, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $PendingTaskModelCopyWith<$Res>  {
  factory $PendingTaskModelCopyWith(PendingTaskModel value, $Res Function(PendingTaskModel) _then) = _$PendingTaskModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String title, String? description, DateTime startDate, String occurrenceDate, String? occurrenceId, String? recurrenceDays, int? recurrenceInterval, String? colorHex, TaskUserRef? createdBy
});


$TaskUserRefCopyWith<$Res>? get createdBy;

}
/// @nodoc
class _$PendingTaskModelCopyWithImpl<$Res>
    implements $PendingTaskModelCopyWith<$Res> {
  _$PendingTaskModelCopyWithImpl(this._self, this._then);

  final PendingTaskModel _self;
  final $Res Function(PendingTaskModel) _then;

/// Create a copy of PendingTaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? title = null,Object? description = freezed,Object? startDate = null,Object? occurrenceDate = null,Object? occurrenceId = freezed,Object? recurrenceDays = freezed,Object? recurrenceInterval = freezed,Object? colorHex = freezed,Object? createdBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,occurrenceDate: null == occurrenceDate ? _self.occurrenceDate : occurrenceDate // ignore: cast_nullable_to_non_nullable
as String,occurrenceId: freezed == occurrenceId ? _self.occurrenceId : occurrenceId // ignore: cast_nullable_to_non_nullable
as String?,recurrenceDays: freezed == recurrenceDays ? _self.recurrenceDays : recurrenceDays // ignore: cast_nullable_to_non_nullable
as String?,recurrenceInterval: freezed == recurrenceInterval ? _self.recurrenceInterval : recurrenceInterval // ignore: cast_nullable_to_non_nullable
as int?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as TaskUserRef?,
  ));
}
/// Create a copy of PendingTaskModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskUserRefCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $TaskUserRefCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [PendingTaskModel].
extension PendingTaskModelPatterns on PendingTaskModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingTaskModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingTaskModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingTaskModel value)  $default,){
final _that = this;
switch (_that) {
case _PendingTaskModel():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingTaskModel value)?  $default,){
final _that = this;
switch (_that) {
case _PendingTaskModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String title,  String? description,  DateTime startDate,  String occurrenceDate,  String? occurrenceId,  String? recurrenceDays,  int? recurrenceInterval,  String? colorHex,  TaskUserRef? createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingTaskModel() when $default != null:
return $default(_that.id,_that.householdId,_that.title,_that.description,_that.startDate,_that.occurrenceDate,_that.occurrenceId,_that.recurrenceDays,_that.recurrenceInterval,_that.colorHex,_that.createdBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String title,  String? description,  DateTime startDate,  String occurrenceDate,  String? occurrenceId,  String? recurrenceDays,  int? recurrenceInterval,  String? colorHex,  TaskUserRef? createdBy)  $default,) {final _that = this;
switch (_that) {
case _PendingTaskModel():
return $default(_that.id,_that.householdId,_that.title,_that.description,_that.startDate,_that.occurrenceDate,_that.occurrenceId,_that.recurrenceDays,_that.recurrenceInterval,_that.colorHex,_that.createdBy);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String title,  String? description,  DateTime startDate,  String occurrenceDate,  String? occurrenceId,  String? recurrenceDays,  int? recurrenceInterval,  String? colorHex,  TaskUserRef? createdBy)?  $default,) {final _that = this;
switch (_that) {
case _PendingTaskModel() when $default != null:
return $default(_that.id,_that.householdId,_that.title,_that.description,_that.startDate,_that.occurrenceDate,_that.occurrenceId,_that.recurrenceDays,_that.recurrenceInterval,_that.colorHex,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingTaskModel implements PendingTaskModel {
  const _PendingTaskModel({required this.id, required this.householdId, required this.title, this.description, required this.startDate, required this.occurrenceDate, this.occurrenceId, this.recurrenceDays, this.recurrenceInterval, this.colorHex, this.createdBy});
  factory _PendingTaskModel.fromJson(Map<String, dynamic> json) => _$PendingTaskModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String title;
@override final  String? description;
@override final  DateTime startDate;
@override final  String occurrenceDate;
@override final  String? occurrenceId;
@override final  String? recurrenceDays;
@override final  int? recurrenceInterval;
@override final  String? colorHex;
@override final  TaskUserRef? createdBy;

/// Create a copy of PendingTaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingTaskModelCopyWith<_PendingTaskModel> get copyWith => __$PendingTaskModelCopyWithImpl<_PendingTaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingTaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingTaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.occurrenceDate, occurrenceDate) || other.occurrenceDate == occurrenceDate)&&(identical(other.occurrenceId, occurrenceId) || other.occurrenceId == occurrenceId)&&(identical(other.recurrenceDays, recurrenceDays) || other.recurrenceDays == recurrenceDays)&&(identical(other.recurrenceInterval, recurrenceInterval) || other.recurrenceInterval == recurrenceInterval)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,title,description,startDate,occurrenceDate,occurrenceId,recurrenceDays,recurrenceInterval,colorHex,createdBy);

@override
String toString() {
  return 'PendingTaskModel(id: $id, householdId: $householdId, title: $title, description: $description, startDate: $startDate, occurrenceDate: $occurrenceDate, occurrenceId: $occurrenceId, recurrenceDays: $recurrenceDays, recurrenceInterval: $recurrenceInterval, colorHex: $colorHex, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$PendingTaskModelCopyWith<$Res> implements $PendingTaskModelCopyWith<$Res> {
  factory _$PendingTaskModelCopyWith(_PendingTaskModel value, $Res Function(_PendingTaskModel) _then) = __$PendingTaskModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String title, String? description, DateTime startDate, String occurrenceDate, String? occurrenceId, String? recurrenceDays, int? recurrenceInterval, String? colorHex, TaskUserRef? createdBy
});


@override $TaskUserRefCopyWith<$Res>? get createdBy;

}
/// @nodoc
class __$PendingTaskModelCopyWithImpl<$Res>
    implements _$PendingTaskModelCopyWith<$Res> {
  __$PendingTaskModelCopyWithImpl(this._self, this._then);

  final _PendingTaskModel _self;
  final $Res Function(_PendingTaskModel) _then;

/// Create a copy of PendingTaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? title = null,Object? description = freezed,Object? startDate = null,Object? occurrenceDate = null,Object? occurrenceId = freezed,Object? recurrenceDays = freezed,Object? recurrenceInterval = freezed,Object? colorHex = freezed,Object? createdBy = freezed,}) {
  return _then(_PendingTaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,occurrenceDate: null == occurrenceDate ? _self.occurrenceDate : occurrenceDate // ignore: cast_nullable_to_non_nullable
as String,occurrenceId: freezed == occurrenceId ? _self.occurrenceId : occurrenceId // ignore: cast_nullable_to_non_nullable
as String?,recurrenceDays: freezed == recurrenceDays ? _self.recurrenceDays : recurrenceDays // ignore: cast_nullable_to_non_nullable
as String?,recurrenceInterval: freezed == recurrenceInterval ? _self.recurrenceInterval : recurrenceInterval // ignore: cast_nullable_to_non_nullable
as int?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as TaskUserRef?,
  ));
}

/// Create a copy of PendingTaskModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskUserRefCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $TaskUserRefCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}

// dart format on
