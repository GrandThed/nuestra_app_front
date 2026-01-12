// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HouseholdState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HouseholdState()';
}


}

/// @nodoc
class $HouseholdStateCopyWith<$Res>  {
$HouseholdStateCopyWith(HouseholdState _, $Res Function(HouseholdState) __);
}


/// Adds pattern-matching-related methods to [HouseholdState].
extension HouseholdStatePatterns on HouseholdState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HouseholdStateInitial value)?  initial,TResult Function( HouseholdStateLoading value)?  loading,TResult Function( HouseholdStateLoaded value)?  loaded,TResult Function( HouseholdStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HouseholdStateInitial() when initial != null:
return initial(_that);case HouseholdStateLoading() when loading != null:
return loading(_that);case HouseholdStateLoaded() when loaded != null:
return loaded(_that);case HouseholdStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HouseholdStateInitial value)  initial,required TResult Function( HouseholdStateLoading value)  loading,required TResult Function( HouseholdStateLoaded value)  loaded,required TResult Function( HouseholdStateError value)  error,}){
final _that = this;
switch (_that) {
case HouseholdStateInitial():
return initial(_that);case HouseholdStateLoading():
return loading(_that);case HouseholdStateLoaded():
return loaded(_that);case HouseholdStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HouseholdStateInitial value)?  initial,TResult? Function( HouseholdStateLoading value)?  loading,TResult? Function( HouseholdStateLoaded value)?  loaded,TResult? Function( HouseholdStateError value)?  error,}){
final _that = this;
switch (_that) {
case HouseholdStateInitial() when initial != null:
return initial(_that);case HouseholdStateLoading() when loading != null:
return loading(_that);case HouseholdStateLoaded() when loaded != null:
return loaded(_that);case HouseholdStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HouseholdModel household)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HouseholdStateInitial() when initial != null:
return initial();case HouseholdStateLoading() when loading != null:
return loading();case HouseholdStateLoaded() when loaded != null:
return loaded(_that.household);case HouseholdStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HouseholdModel household)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case HouseholdStateInitial():
return initial();case HouseholdStateLoading():
return loading();case HouseholdStateLoaded():
return loaded(_that.household);case HouseholdStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HouseholdModel household)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case HouseholdStateInitial() when initial != null:
return initial();case HouseholdStateLoading() when loading != null:
return loading();case HouseholdStateLoaded() when loaded != null:
return loaded(_that.household);case HouseholdStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class HouseholdStateInitial implements HouseholdState {
  const HouseholdStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HouseholdState.initial()';
}


}




/// @nodoc


class HouseholdStateLoading implements HouseholdState {
  const HouseholdStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HouseholdState.loading()';
}


}




/// @nodoc


class HouseholdStateLoaded implements HouseholdState {
  const HouseholdStateLoaded(this.household);
  

 final  HouseholdModel household;

/// Create a copy of HouseholdState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseholdStateLoadedCopyWith<HouseholdStateLoaded> get copyWith => _$HouseholdStateLoadedCopyWithImpl<HouseholdStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdStateLoaded&&(identical(other.household, household) || other.household == household));
}


@override
int get hashCode => Object.hash(runtimeType,household);

@override
String toString() {
  return 'HouseholdState.loaded(household: $household)';
}


}

/// @nodoc
abstract mixin class $HouseholdStateLoadedCopyWith<$Res> implements $HouseholdStateCopyWith<$Res> {
  factory $HouseholdStateLoadedCopyWith(HouseholdStateLoaded value, $Res Function(HouseholdStateLoaded) _then) = _$HouseholdStateLoadedCopyWithImpl;
@useResult
$Res call({
 HouseholdModel household
});


$HouseholdModelCopyWith<$Res> get household;

}
/// @nodoc
class _$HouseholdStateLoadedCopyWithImpl<$Res>
    implements $HouseholdStateLoadedCopyWith<$Res> {
  _$HouseholdStateLoadedCopyWithImpl(this._self, this._then);

  final HouseholdStateLoaded _self;
  final $Res Function(HouseholdStateLoaded) _then;

/// Create a copy of HouseholdState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? household = null,}) {
  return _then(HouseholdStateLoaded(
null == household ? _self.household : household // ignore: cast_nullable_to_non_nullable
as HouseholdModel,
  ));
}

/// Create a copy of HouseholdState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HouseholdModelCopyWith<$Res> get household {
  
  return $HouseholdModelCopyWith<$Res>(_self.household, (value) {
    return _then(_self.copyWith(household: value));
  });
}
}

/// @nodoc


class HouseholdStateError implements HouseholdState {
  const HouseholdStateError(this.message);
  

 final  String message;

/// Create a copy of HouseholdState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseholdStateErrorCopyWith<HouseholdStateError> get copyWith => _$HouseholdStateErrorCopyWithImpl<HouseholdStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HouseholdState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HouseholdStateErrorCopyWith<$Res> implements $HouseholdStateCopyWith<$Res> {
  factory $HouseholdStateErrorCopyWith(HouseholdStateError value, $Res Function(HouseholdStateError) _then) = _$HouseholdStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HouseholdStateErrorCopyWithImpl<$Res>
    implements $HouseholdStateErrorCopyWith<$Res> {
  _$HouseholdStateErrorCopyWithImpl(this._self, this._then);

  final HouseholdStateError _self;
  final $Res Function(HouseholdStateError) _then;

/// Create a copy of HouseholdState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HouseholdStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
