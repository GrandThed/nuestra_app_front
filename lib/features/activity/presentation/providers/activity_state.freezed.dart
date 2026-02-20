// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityFeedState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityFeedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityFeedState()';
}


}

/// @nodoc
class $ActivityFeedStateCopyWith<$Res>  {
$ActivityFeedStateCopyWith(ActivityFeedState _, $Res Function(ActivityFeedState) __);
}


/// Adds pattern-matching-related methods to [ActivityFeedState].
extension ActivityFeedStatePatterns on ActivityFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ActivityFeedStateInitial value)?  initial,TResult Function( ActivityFeedStateLoading value)?  loading,TResult Function( ActivityFeedStateLoaded value)?  loaded,TResult Function( ActivityFeedStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ActivityFeedStateInitial() when initial != null:
return initial(_that);case ActivityFeedStateLoading() when loading != null:
return loading(_that);case ActivityFeedStateLoaded() when loaded != null:
return loaded(_that);case ActivityFeedStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ActivityFeedStateInitial value)  initial,required TResult Function( ActivityFeedStateLoading value)  loading,required TResult Function( ActivityFeedStateLoaded value)  loaded,required TResult Function( ActivityFeedStateError value)  error,}){
final _that = this;
switch (_that) {
case ActivityFeedStateInitial():
return initial(_that);case ActivityFeedStateLoading():
return loading(_that);case ActivityFeedStateLoaded():
return loaded(_that);case ActivityFeedStateError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ActivityFeedStateInitial value)?  initial,TResult? Function( ActivityFeedStateLoading value)?  loading,TResult? Function( ActivityFeedStateLoaded value)?  loaded,TResult? Function( ActivityFeedStateError value)?  error,}){
final _that = this;
switch (_that) {
case ActivityFeedStateInitial() when initial != null:
return initial(_that);case ActivityFeedStateLoading() when loading != null:
return loading(_that);case ActivityFeedStateLoaded() when loaded != null:
return loaded(_that);case ActivityFeedStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ActivityLogModel> activities,  bool hasMore)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ActivityFeedStateInitial() when initial != null:
return initial();case ActivityFeedStateLoading() when loading != null:
return loading();case ActivityFeedStateLoaded() when loaded != null:
return loaded(_that.activities,_that.hasMore);case ActivityFeedStateError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ActivityLogModel> activities,  bool hasMore)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ActivityFeedStateInitial():
return initial();case ActivityFeedStateLoading():
return loading();case ActivityFeedStateLoaded():
return loaded(_that.activities,_that.hasMore);case ActivityFeedStateError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ActivityLogModel> activities,  bool hasMore)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ActivityFeedStateInitial() when initial != null:
return initial();case ActivityFeedStateLoading() when loading != null:
return loading();case ActivityFeedStateLoaded() when loaded != null:
return loaded(_that.activities,_that.hasMore);case ActivityFeedStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ActivityFeedStateInitial implements ActivityFeedState {
  const ActivityFeedStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityFeedStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityFeedState.initial()';
}


}




/// @nodoc


class ActivityFeedStateLoading implements ActivityFeedState {
  const ActivityFeedStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityFeedStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityFeedState.loading()';
}


}




/// @nodoc


class ActivityFeedStateLoaded implements ActivityFeedState {
  const ActivityFeedStateLoaded(final  List<ActivityLogModel> activities, {this.hasMore = false}): _activities = activities;
  

 final  List<ActivityLogModel> _activities;
 List<ActivityLogModel> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

@JsonKey() final  bool hasMore;

/// Create a copy of ActivityFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityFeedStateLoadedCopyWith<ActivityFeedStateLoaded> get copyWith => _$ActivityFeedStateLoadedCopyWithImpl<ActivityFeedStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityFeedStateLoaded&&const DeepCollectionEquality().equals(other._activities, _activities)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activities),hasMore);

@override
String toString() {
  return 'ActivityFeedState.loaded(activities: $activities, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $ActivityFeedStateLoadedCopyWith<$Res> implements $ActivityFeedStateCopyWith<$Res> {
  factory $ActivityFeedStateLoadedCopyWith(ActivityFeedStateLoaded value, $Res Function(ActivityFeedStateLoaded) _then) = _$ActivityFeedStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ActivityLogModel> activities, bool hasMore
});




}
/// @nodoc
class _$ActivityFeedStateLoadedCopyWithImpl<$Res>
    implements $ActivityFeedStateLoadedCopyWith<$Res> {
  _$ActivityFeedStateLoadedCopyWithImpl(this._self, this._then);

  final ActivityFeedStateLoaded _self;
  final $Res Function(ActivityFeedStateLoaded) _then;

/// Create a copy of ActivityFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activities = null,Object? hasMore = null,}) {
  return _then(ActivityFeedStateLoaded(
null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<ActivityLogModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ActivityFeedStateError implements ActivityFeedState {
  const ActivityFeedStateError(this.message);
  

 final  String message;

/// Create a copy of ActivityFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityFeedStateErrorCopyWith<ActivityFeedStateError> get copyWith => _$ActivityFeedStateErrorCopyWithImpl<ActivityFeedStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityFeedStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ActivityFeedState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ActivityFeedStateErrorCopyWith<$Res> implements $ActivityFeedStateCopyWith<$Res> {
  factory $ActivityFeedStateErrorCopyWith(ActivityFeedStateError value, $Res Function(ActivityFeedStateError) _then) = _$ActivityFeedStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ActivityFeedStateErrorCopyWithImpl<$Res>
    implements $ActivityFeedStateErrorCopyWith<$Res> {
  _$ActivityFeedStateErrorCopyWithImpl(this._self, this._then);

  final ActivityFeedStateError _self;
  final $Res Function(ActivityFeedStateError) _then;

/// Create a copy of ActivityFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ActivityFeedStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
