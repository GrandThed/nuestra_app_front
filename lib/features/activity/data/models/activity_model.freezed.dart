// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityLogModel {

 String get id; String get householdId; String get userId; ActivityUserModel get user; String get action; String get entityType; String? get entityId; Map<String, dynamic>? get metadata; DateTime get createdAt;
/// Create a copy of ActivityLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityLogModelCopyWith<ActivityLogModel> get copyWith => _$ActivityLogModelCopyWithImpl<ActivityLogModel>(this as ActivityLogModel, _$identity);

  /// Serializes this ActivityLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.action, action) || other.action == action)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,userId,user,action,entityType,entityId,const DeepCollectionEquality().hash(metadata),createdAt);

@override
String toString() {
  return 'ActivityLogModel(id: $id, householdId: $householdId, userId: $userId, user: $user, action: $action, entityType: $entityType, entityId: $entityId, metadata: $metadata, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ActivityLogModelCopyWith<$Res>  {
  factory $ActivityLogModelCopyWith(ActivityLogModel value, $Res Function(ActivityLogModel) _then) = _$ActivityLogModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String userId, ActivityUserModel user, String action, String entityType, String? entityId, Map<String, dynamic>? metadata, DateTime createdAt
});


$ActivityUserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$ActivityLogModelCopyWithImpl<$Res>
    implements $ActivityLogModelCopyWith<$Res> {
  _$ActivityLogModelCopyWithImpl(this._self, this._then);

  final ActivityLogModel _self;
  final $Res Function(ActivityLogModel) _then;

/// Create a copy of ActivityLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? userId = null,Object? user = null,Object? action = null,Object? entityType = null,Object? entityId = freezed,Object? metadata = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ActivityUserModel,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ActivityLogModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityUserModelCopyWith<$Res> get user {
  
  return $ActivityUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivityLogModel].
extension ActivityLogModelPatterns on ActivityLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityLogModel value)  $default,){
final _that = this;
switch (_that) {
case _ActivityLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String userId,  ActivityUserModel user,  String action,  String entityType,  String? entityId,  Map<String, dynamic>? metadata,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityLogModel() when $default != null:
return $default(_that.id,_that.householdId,_that.userId,_that.user,_that.action,_that.entityType,_that.entityId,_that.metadata,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String userId,  ActivityUserModel user,  String action,  String entityType,  String? entityId,  Map<String, dynamic>? metadata,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ActivityLogModel():
return $default(_that.id,_that.householdId,_that.userId,_that.user,_that.action,_that.entityType,_that.entityId,_that.metadata,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String userId,  ActivityUserModel user,  String action,  String entityType,  String? entityId,  Map<String, dynamic>? metadata,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ActivityLogModel() when $default != null:
return $default(_that.id,_that.householdId,_that.userId,_that.user,_that.action,_that.entityType,_that.entityId,_that.metadata,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityLogModel implements ActivityLogModel {
  const _ActivityLogModel({required this.id, required this.householdId, required this.userId, required this.user, required this.action, required this.entityType, this.entityId, final  Map<String, dynamic>? metadata, required this.createdAt}): _metadata = metadata;
  factory _ActivityLogModel.fromJson(Map<String, dynamic> json) => _$ActivityLogModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String userId;
@override final  ActivityUserModel user;
@override final  String action;
@override final  String entityType;
@override final  String? entityId;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime createdAt;

/// Create a copy of ActivityLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityLogModelCopyWith<_ActivityLogModel> get copyWith => __$ActivityLogModelCopyWithImpl<_ActivityLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.action, action) || other.action == action)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,userId,user,action,entityType,entityId,const DeepCollectionEquality().hash(_metadata),createdAt);

@override
String toString() {
  return 'ActivityLogModel(id: $id, householdId: $householdId, userId: $userId, user: $user, action: $action, entityType: $entityType, entityId: $entityId, metadata: $metadata, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityLogModelCopyWith<$Res> implements $ActivityLogModelCopyWith<$Res> {
  factory _$ActivityLogModelCopyWith(_ActivityLogModel value, $Res Function(_ActivityLogModel) _then) = __$ActivityLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String userId, ActivityUserModel user, String action, String entityType, String? entityId, Map<String, dynamic>? metadata, DateTime createdAt
});


@override $ActivityUserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$ActivityLogModelCopyWithImpl<$Res>
    implements _$ActivityLogModelCopyWith<$Res> {
  __$ActivityLogModelCopyWithImpl(this._self, this._then);

  final _ActivityLogModel _self;
  final $Res Function(_ActivityLogModel) _then;

/// Create a copy of ActivityLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? userId = null,Object? user = null,Object? action = null,Object? entityType = null,Object? entityId = freezed,Object? metadata = freezed,Object? createdAt = null,}) {
  return _then(_ActivityLogModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ActivityUserModel,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ActivityLogModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityUserModelCopyWith<$Res> get user {
  
  return $ActivityUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$ActivityUserModel {

 String get id; String get name; String? get avatarUrl;
/// Create a copy of ActivityUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityUserModelCopyWith<ActivityUserModel> get copyWith => _$ActivityUserModelCopyWithImpl<ActivityUserModel>(this as ActivityUserModel, _$identity);

  /// Serializes this ActivityUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ActivityUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $ActivityUserModelCopyWith<$Res>  {
  factory $ActivityUserModelCopyWith(ActivityUserModel value, $Res Function(ActivityUserModel) _then) = _$ActivityUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class _$ActivityUserModelCopyWithImpl<$Res>
    implements $ActivityUserModelCopyWith<$Res> {
  _$ActivityUserModelCopyWithImpl(this._self, this._then);

  final ActivityUserModel _self;
  final $Res Function(ActivityUserModel) _then;

/// Create a copy of ActivityUserModel
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


/// Adds pattern-matching-related methods to [ActivityUserModel].
extension ActivityUserModelPatterns on ActivityUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityUserModel value)  $default,){
final _that = this;
switch (_that) {
case _ActivityUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityUserModel() when $default != null:
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
case _ActivityUserModel() when $default != null:
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
case _ActivityUserModel():
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
case _ActivityUserModel() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityUserModel implements ActivityUserModel {
  const _ActivityUserModel({required this.id, required this.name, this.avatarUrl});
  factory _ActivityUserModel.fromJson(Map<String, dynamic> json) => _$ActivityUserModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of ActivityUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityUserModelCopyWith<_ActivityUserModel> get copyWith => __$ActivityUserModelCopyWithImpl<_ActivityUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ActivityUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ActivityUserModelCopyWith<$Res> implements $ActivityUserModelCopyWith<$Res> {
  factory _$ActivityUserModelCopyWith(_ActivityUserModel value, $Res Function(_ActivityUserModel) _then) = __$ActivityUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class __$ActivityUserModelCopyWithImpl<$Res>
    implements _$ActivityUserModelCopyWith<$Res> {
  __$ActivityUserModelCopyWithImpl(this._self, this._then);

  final _ActivityUserModel _self;
  final $Res Function(_ActivityUserModel) _then;

/// Create a copy of ActivityUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_ActivityUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ActivityDigestModel {

 String get householdId; String get periodStart; String get periodEnd; int get totalActions; Map<String, int> get byEntityType; Map<String, int> get byAction;
/// Create a copy of ActivityDigestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityDigestModelCopyWith<ActivityDigestModel> get copyWith => _$ActivityDigestModelCopyWithImpl<ActivityDigestModel>(this as ActivityDigestModel, _$identity);

  /// Serializes this ActivityDigestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityDigestModel&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.totalActions, totalActions) || other.totalActions == totalActions)&&const DeepCollectionEquality().equals(other.byEntityType, byEntityType)&&const DeepCollectionEquality().equals(other.byAction, byAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,householdId,periodStart,periodEnd,totalActions,const DeepCollectionEquality().hash(byEntityType),const DeepCollectionEquality().hash(byAction));

@override
String toString() {
  return 'ActivityDigestModel(householdId: $householdId, periodStart: $periodStart, periodEnd: $periodEnd, totalActions: $totalActions, byEntityType: $byEntityType, byAction: $byAction)';
}


}

/// @nodoc
abstract mixin class $ActivityDigestModelCopyWith<$Res>  {
  factory $ActivityDigestModelCopyWith(ActivityDigestModel value, $Res Function(ActivityDigestModel) _then) = _$ActivityDigestModelCopyWithImpl;
@useResult
$Res call({
 String householdId, String periodStart, String periodEnd, int totalActions, Map<String, int> byEntityType, Map<String, int> byAction
});




}
/// @nodoc
class _$ActivityDigestModelCopyWithImpl<$Res>
    implements $ActivityDigestModelCopyWith<$Res> {
  _$ActivityDigestModelCopyWithImpl(this._self, this._then);

  final ActivityDigestModel _self;
  final $Res Function(ActivityDigestModel) _then;

/// Create a copy of ActivityDigestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? householdId = null,Object? periodStart = null,Object? periodEnd = null,Object? totalActions = null,Object? byEntityType = null,Object? byAction = null,}) {
  return _then(_self.copyWith(
householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as String,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as String,totalActions: null == totalActions ? _self.totalActions : totalActions // ignore: cast_nullable_to_non_nullable
as int,byEntityType: null == byEntityType ? _self.byEntityType : byEntityType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byAction: null == byAction ? _self.byAction : byAction // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityDigestModel].
extension ActivityDigestModelPatterns on ActivityDigestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityDigestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityDigestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityDigestModel value)  $default,){
final _that = this;
switch (_that) {
case _ActivityDigestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityDigestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityDigestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String householdId,  String periodStart,  String periodEnd,  int totalActions,  Map<String, int> byEntityType,  Map<String, int> byAction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityDigestModel() when $default != null:
return $default(_that.householdId,_that.periodStart,_that.periodEnd,_that.totalActions,_that.byEntityType,_that.byAction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String householdId,  String periodStart,  String periodEnd,  int totalActions,  Map<String, int> byEntityType,  Map<String, int> byAction)  $default,) {final _that = this;
switch (_that) {
case _ActivityDigestModel():
return $default(_that.householdId,_that.periodStart,_that.periodEnd,_that.totalActions,_that.byEntityType,_that.byAction);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String householdId,  String periodStart,  String periodEnd,  int totalActions,  Map<String, int> byEntityType,  Map<String, int> byAction)?  $default,) {final _that = this;
switch (_that) {
case _ActivityDigestModel() when $default != null:
return $default(_that.householdId,_that.periodStart,_that.periodEnd,_that.totalActions,_that.byEntityType,_that.byAction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityDigestModel implements ActivityDigestModel {
  const _ActivityDigestModel({required this.householdId, required this.periodStart, required this.periodEnd, required this.totalActions, required final  Map<String, int> byEntityType, required final  Map<String, int> byAction}): _byEntityType = byEntityType,_byAction = byAction;
  factory _ActivityDigestModel.fromJson(Map<String, dynamic> json) => _$ActivityDigestModelFromJson(json);

@override final  String householdId;
@override final  String periodStart;
@override final  String periodEnd;
@override final  int totalActions;
 final  Map<String, int> _byEntityType;
@override Map<String, int> get byEntityType {
  if (_byEntityType is EqualUnmodifiableMapView) return _byEntityType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byEntityType);
}

 final  Map<String, int> _byAction;
@override Map<String, int> get byAction {
  if (_byAction is EqualUnmodifiableMapView) return _byAction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byAction);
}


/// Create a copy of ActivityDigestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityDigestModelCopyWith<_ActivityDigestModel> get copyWith => __$ActivityDigestModelCopyWithImpl<_ActivityDigestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityDigestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityDigestModel&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.totalActions, totalActions) || other.totalActions == totalActions)&&const DeepCollectionEquality().equals(other._byEntityType, _byEntityType)&&const DeepCollectionEquality().equals(other._byAction, _byAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,householdId,periodStart,periodEnd,totalActions,const DeepCollectionEquality().hash(_byEntityType),const DeepCollectionEquality().hash(_byAction));

@override
String toString() {
  return 'ActivityDigestModel(householdId: $householdId, periodStart: $periodStart, periodEnd: $periodEnd, totalActions: $totalActions, byEntityType: $byEntityType, byAction: $byAction)';
}


}

/// @nodoc
abstract mixin class _$ActivityDigestModelCopyWith<$Res> implements $ActivityDigestModelCopyWith<$Res> {
  factory _$ActivityDigestModelCopyWith(_ActivityDigestModel value, $Res Function(_ActivityDigestModel) _then) = __$ActivityDigestModelCopyWithImpl;
@override @useResult
$Res call({
 String householdId, String periodStart, String periodEnd, int totalActions, Map<String, int> byEntityType, Map<String, int> byAction
});




}
/// @nodoc
class __$ActivityDigestModelCopyWithImpl<$Res>
    implements _$ActivityDigestModelCopyWith<$Res> {
  __$ActivityDigestModelCopyWithImpl(this._self, this._then);

  final _ActivityDigestModel _self;
  final $Res Function(_ActivityDigestModel) _then;

/// Create a copy of ActivityDigestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? householdId = null,Object? periodStart = null,Object? periodEnd = null,Object? totalActions = null,Object? byEntityType = null,Object? byAction = null,}) {
  return _then(_ActivityDigestModel(
householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as String,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as String,totalActions: null == totalActions ? _self.totalActions : totalActions // ignore: cast_nullable_to_non_nullable
as int,byEntityType: null == byEntityType ? _self._byEntityType : byEntityType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byAction: null == byAction ? _self._byAction : byAction // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
