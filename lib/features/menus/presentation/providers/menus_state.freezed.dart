// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menus_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenuPlansState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlansState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuPlansState()';
}


}

/// @nodoc
class $MenuPlansStateCopyWith<$Res>  {
$MenuPlansStateCopyWith(MenuPlansState _, $Res Function(MenuPlansState) __);
}


/// Adds pattern-matching-related methods to [MenuPlansState].
extension MenuPlansStatePatterns on MenuPlansState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MenuPlansStateInitial value)?  initial,TResult Function( MenuPlansStateLoading value)?  loading,TResult Function( MenuPlansStateLoaded value)?  loaded,TResult Function( MenuPlansStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MenuPlansStateInitial() when initial != null:
return initial(_that);case MenuPlansStateLoading() when loading != null:
return loading(_that);case MenuPlansStateLoaded() when loaded != null:
return loaded(_that);case MenuPlansStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MenuPlansStateInitial value)  initial,required TResult Function( MenuPlansStateLoading value)  loading,required TResult Function( MenuPlansStateLoaded value)  loaded,required TResult Function( MenuPlansStateError value)  error,}){
final _that = this;
switch (_that) {
case MenuPlansStateInitial():
return initial(_that);case MenuPlansStateLoading():
return loading(_that);case MenuPlansStateLoaded():
return loaded(_that);case MenuPlansStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MenuPlansStateInitial value)?  initial,TResult? Function( MenuPlansStateLoading value)?  loading,TResult? Function( MenuPlansStateLoaded value)?  loaded,TResult? Function( MenuPlansStateError value)?  error,}){
final _that = this;
switch (_that) {
case MenuPlansStateInitial() when initial != null:
return initial(_that);case MenuPlansStateLoading() when loading != null:
return loading(_that);case MenuPlansStateLoaded() when loaded != null:
return loaded(_that);case MenuPlansStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MenuPlanModel> plans)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MenuPlansStateInitial() when initial != null:
return initial();case MenuPlansStateLoading() when loading != null:
return loading();case MenuPlansStateLoaded() when loaded != null:
return loaded(_that.plans);case MenuPlansStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MenuPlanModel> plans)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MenuPlansStateInitial():
return initial();case MenuPlansStateLoading():
return loading();case MenuPlansStateLoaded():
return loaded(_that.plans);case MenuPlansStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MenuPlanModel> plans)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MenuPlansStateInitial() when initial != null:
return initial();case MenuPlansStateLoading() when loading != null:
return loading();case MenuPlansStateLoaded() when loaded != null:
return loaded(_that.plans);case MenuPlansStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MenuPlansStateInitial implements MenuPlansState {
  const MenuPlansStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlansStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuPlansState.initial()';
}


}




/// @nodoc


class MenuPlansStateLoading implements MenuPlansState {
  const MenuPlansStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlansStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuPlansState.loading()';
}


}




/// @nodoc


class MenuPlansStateLoaded implements MenuPlansState {
  const MenuPlansStateLoaded(final  List<MenuPlanModel> plans): _plans = plans;
  

 final  List<MenuPlanModel> _plans;
 List<MenuPlanModel> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}


/// Create a copy of MenuPlansState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuPlansStateLoadedCopyWith<MenuPlansStateLoaded> get copyWith => _$MenuPlansStateLoadedCopyWithImpl<MenuPlansStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlansStateLoaded&&const DeepCollectionEquality().equals(other._plans, _plans));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_plans));

@override
String toString() {
  return 'MenuPlansState.loaded(plans: $plans)';
}


}

/// @nodoc
abstract mixin class $MenuPlansStateLoadedCopyWith<$Res> implements $MenuPlansStateCopyWith<$Res> {
  factory $MenuPlansStateLoadedCopyWith(MenuPlansStateLoaded value, $Res Function(MenuPlansStateLoaded) _then) = _$MenuPlansStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<MenuPlanModel> plans
});




}
/// @nodoc
class _$MenuPlansStateLoadedCopyWithImpl<$Res>
    implements $MenuPlansStateLoadedCopyWith<$Res> {
  _$MenuPlansStateLoadedCopyWithImpl(this._self, this._then);

  final MenuPlansStateLoaded _self;
  final $Res Function(MenuPlansStateLoaded) _then;

/// Create a copy of MenuPlansState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plans = null,}) {
  return _then(MenuPlansStateLoaded(
null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<MenuPlanModel>,
  ));
}


}

/// @nodoc


class MenuPlansStateError implements MenuPlansState {
  const MenuPlansStateError(this.message);
  

 final  String message;

/// Create a copy of MenuPlansState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuPlansStateErrorCopyWith<MenuPlansStateError> get copyWith => _$MenuPlansStateErrorCopyWithImpl<MenuPlansStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlansStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MenuPlansState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MenuPlansStateErrorCopyWith<$Res> implements $MenuPlansStateCopyWith<$Res> {
  factory $MenuPlansStateErrorCopyWith(MenuPlansStateError value, $Res Function(MenuPlansStateError) _then) = _$MenuPlansStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MenuPlansStateErrorCopyWithImpl<$Res>
    implements $MenuPlansStateErrorCopyWith<$Res> {
  _$MenuPlansStateErrorCopyWithImpl(this._self, this._then);

  final MenuPlansStateError _self;
  final $Res Function(MenuPlansStateError) _then;

/// Create a copy of MenuPlansState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MenuPlansStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MenuPlanDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlanDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuPlanDetailState()';
}


}

/// @nodoc
class $MenuPlanDetailStateCopyWith<$Res>  {
$MenuPlanDetailStateCopyWith(MenuPlanDetailState _, $Res Function(MenuPlanDetailState) __);
}


/// Adds pattern-matching-related methods to [MenuPlanDetailState].
extension MenuPlanDetailStatePatterns on MenuPlanDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MenuPlanDetailStateInitial value)?  initial,TResult Function( MenuPlanDetailStateLoading value)?  loading,TResult Function( MenuPlanDetailStateLoaded value)?  loaded,TResult Function( MenuPlanDetailStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MenuPlanDetailStateInitial() when initial != null:
return initial(_that);case MenuPlanDetailStateLoading() when loading != null:
return loading(_that);case MenuPlanDetailStateLoaded() when loaded != null:
return loaded(_that);case MenuPlanDetailStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MenuPlanDetailStateInitial value)  initial,required TResult Function( MenuPlanDetailStateLoading value)  loading,required TResult Function( MenuPlanDetailStateLoaded value)  loaded,required TResult Function( MenuPlanDetailStateError value)  error,}){
final _that = this;
switch (_that) {
case MenuPlanDetailStateInitial():
return initial(_that);case MenuPlanDetailStateLoading():
return loading(_that);case MenuPlanDetailStateLoaded():
return loaded(_that);case MenuPlanDetailStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MenuPlanDetailStateInitial value)?  initial,TResult? Function( MenuPlanDetailStateLoading value)?  loading,TResult? Function( MenuPlanDetailStateLoaded value)?  loaded,TResult? Function( MenuPlanDetailStateError value)?  error,}){
final _that = this;
switch (_that) {
case MenuPlanDetailStateInitial() when initial != null:
return initial(_that);case MenuPlanDetailStateLoading() when loading != null:
return loading(_that);case MenuPlanDetailStateLoaded() when loaded != null:
return loaded(_that);case MenuPlanDetailStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MenuPlanModel plan)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MenuPlanDetailStateInitial() when initial != null:
return initial();case MenuPlanDetailStateLoading() when loading != null:
return loading();case MenuPlanDetailStateLoaded() when loaded != null:
return loaded(_that.plan);case MenuPlanDetailStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MenuPlanModel plan)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MenuPlanDetailStateInitial():
return initial();case MenuPlanDetailStateLoading():
return loading();case MenuPlanDetailStateLoaded():
return loaded(_that.plan);case MenuPlanDetailStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MenuPlanModel plan)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MenuPlanDetailStateInitial() when initial != null:
return initial();case MenuPlanDetailStateLoading() when loading != null:
return loading();case MenuPlanDetailStateLoaded() when loaded != null:
return loaded(_that.plan);case MenuPlanDetailStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MenuPlanDetailStateInitial implements MenuPlanDetailState {
  const MenuPlanDetailStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlanDetailStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuPlanDetailState.initial()';
}


}




/// @nodoc


class MenuPlanDetailStateLoading implements MenuPlanDetailState {
  const MenuPlanDetailStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlanDetailStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuPlanDetailState.loading()';
}


}




/// @nodoc


class MenuPlanDetailStateLoaded implements MenuPlanDetailState {
  const MenuPlanDetailStateLoaded(this.plan);
  

 final  MenuPlanModel plan;

/// Create a copy of MenuPlanDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuPlanDetailStateLoadedCopyWith<MenuPlanDetailStateLoaded> get copyWith => _$MenuPlanDetailStateLoadedCopyWithImpl<MenuPlanDetailStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlanDetailStateLoaded&&(identical(other.plan, plan) || other.plan == plan));
}


@override
int get hashCode => Object.hash(runtimeType,plan);

@override
String toString() {
  return 'MenuPlanDetailState.loaded(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $MenuPlanDetailStateLoadedCopyWith<$Res> implements $MenuPlanDetailStateCopyWith<$Res> {
  factory $MenuPlanDetailStateLoadedCopyWith(MenuPlanDetailStateLoaded value, $Res Function(MenuPlanDetailStateLoaded) _then) = _$MenuPlanDetailStateLoadedCopyWithImpl;
@useResult
$Res call({
 MenuPlanModel plan
});


$MenuPlanModelCopyWith<$Res> get plan;

}
/// @nodoc
class _$MenuPlanDetailStateLoadedCopyWithImpl<$Res>
    implements $MenuPlanDetailStateLoadedCopyWith<$Res> {
  _$MenuPlanDetailStateLoadedCopyWithImpl(this._self, this._then);

  final MenuPlanDetailStateLoaded _self;
  final $Res Function(MenuPlanDetailStateLoaded) _then;

/// Create a copy of MenuPlanDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plan = null,}) {
  return _then(MenuPlanDetailStateLoaded(
null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as MenuPlanModel,
  ));
}

/// Create a copy of MenuPlanDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MenuPlanModelCopyWith<$Res> get plan {
  
  return $MenuPlanModelCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

/// @nodoc


class MenuPlanDetailStateError implements MenuPlanDetailState {
  const MenuPlanDetailStateError(this.message);
  

 final  String message;

/// Create a copy of MenuPlanDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuPlanDetailStateErrorCopyWith<MenuPlanDetailStateError> get copyWith => _$MenuPlanDetailStateErrorCopyWithImpl<MenuPlanDetailStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlanDetailStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MenuPlanDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MenuPlanDetailStateErrorCopyWith<$Res> implements $MenuPlanDetailStateCopyWith<$Res> {
  factory $MenuPlanDetailStateErrorCopyWith(MenuPlanDetailStateError value, $Res Function(MenuPlanDetailStateError) _then) = _$MenuPlanDetailStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MenuPlanDetailStateErrorCopyWithImpl<$Res>
    implements $MenuPlanDetailStateErrorCopyWith<$Res> {
  _$MenuPlanDetailStateErrorCopyWithImpl(this._self, this._then);

  final MenuPlanDetailStateError _self;
  final $Res Function(MenuPlanDetailStateError) _then;

/// Create a copy of MenuPlanDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MenuPlanDetailStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$UpcomingMealsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingMealsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpcomingMealsState()';
}


}

/// @nodoc
class $UpcomingMealsStateCopyWith<$Res>  {
$UpcomingMealsStateCopyWith(UpcomingMealsState _, $Res Function(UpcomingMealsState) __);
}


/// Adds pattern-matching-related methods to [UpcomingMealsState].
extension UpcomingMealsStatePatterns on UpcomingMealsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UpcomingMealsStateInitial value)?  initial,TResult Function( UpcomingMealsStateLoading value)?  loading,TResult Function( UpcomingMealsStateLoaded value)?  loaded,TResult Function( UpcomingMealsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UpcomingMealsStateInitial() when initial != null:
return initial(_that);case UpcomingMealsStateLoading() when loading != null:
return loading(_that);case UpcomingMealsStateLoaded() when loaded != null:
return loaded(_that);case UpcomingMealsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UpcomingMealsStateInitial value)  initial,required TResult Function( UpcomingMealsStateLoading value)  loading,required TResult Function( UpcomingMealsStateLoaded value)  loaded,required TResult Function( UpcomingMealsStateError value)  error,}){
final _that = this;
switch (_that) {
case UpcomingMealsStateInitial():
return initial(_that);case UpcomingMealsStateLoading():
return loading(_that);case UpcomingMealsStateLoaded():
return loaded(_that);case UpcomingMealsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UpcomingMealsStateInitial value)?  initial,TResult? Function( UpcomingMealsStateLoading value)?  loading,TResult? Function( UpcomingMealsStateLoaded value)?  loaded,TResult? Function( UpcomingMealsStateError value)?  error,}){
final _that = this;
switch (_that) {
case UpcomingMealsStateInitial() when initial != null:
return initial(_that);case UpcomingMealsStateLoading() when loading != null:
return loading(_that);case UpcomingMealsStateLoaded() when loaded != null:
return loaded(_that);case UpcomingMealsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MenuItemModel> items,  DateTime weekStart)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UpcomingMealsStateInitial() when initial != null:
return initial();case UpcomingMealsStateLoading() when loading != null:
return loading();case UpcomingMealsStateLoaded() when loaded != null:
return loaded(_that.items,_that.weekStart);case UpcomingMealsStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MenuItemModel> items,  DateTime weekStart)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case UpcomingMealsStateInitial():
return initial();case UpcomingMealsStateLoading():
return loading();case UpcomingMealsStateLoaded():
return loaded(_that.items,_that.weekStart);case UpcomingMealsStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MenuItemModel> items,  DateTime weekStart)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case UpcomingMealsStateInitial() when initial != null:
return initial();case UpcomingMealsStateLoading() when loading != null:
return loading();case UpcomingMealsStateLoaded() when loaded != null:
return loaded(_that.items,_that.weekStart);case UpcomingMealsStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class UpcomingMealsStateInitial implements UpcomingMealsState {
  const UpcomingMealsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingMealsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpcomingMealsState.initial()';
}


}




/// @nodoc


class UpcomingMealsStateLoading implements UpcomingMealsState {
  const UpcomingMealsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingMealsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpcomingMealsState.loading()';
}


}




/// @nodoc


class UpcomingMealsStateLoaded implements UpcomingMealsState {
  const UpcomingMealsStateLoaded(final  List<MenuItemModel> items, this.weekStart): _items = items;
  

 final  List<MenuItemModel> _items;
 List<MenuItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  DateTime weekStart;

/// Create a copy of UpcomingMealsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingMealsStateLoadedCopyWith<UpcomingMealsStateLoaded> get copyWith => _$UpcomingMealsStateLoadedCopyWithImpl<UpcomingMealsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingMealsStateLoaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),weekStart);

@override
String toString() {
  return 'UpcomingMealsState.loaded(items: $items, weekStart: $weekStart)';
}


}

/// @nodoc
abstract mixin class $UpcomingMealsStateLoadedCopyWith<$Res> implements $UpcomingMealsStateCopyWith<$Res> {
  factory $UpcomingMealsStateLoadedCopyWith(UpcomingMealsStateLoaded value, $Res Function(UpcomingMealsStateLoaded) _then) = _$UpcomingMealsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<MenuItemModel> items, DateTime weekStart
});




}
/// @nodoc
class _$UpcomingMealsStateLoadedCopyWithImpl<$Res>
    implements $UpcomingMealsStateLoadedCopyWith<$Res> {
  _$UpcomingMealsStateLoadedCopyWithImpl(this._self, this._then);

  final UpcomingMealsStateLoaded _self;
  final $Res Function(UpcomingMealsStateLoaded) _then;

/// Create a copy of UpcomingMealsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? weekStart = null,}) {
  return _then(UpcomingMealsStateLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItemModel>,null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class UpcomingMealsStateError implements UpcomingMealsState {
  const UpcomingMealsStateError(this.message);
  

 final  String message;

/// Create a copy of UpcomingMealsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingMealsStateErrorCopyWith<UpcomingMealsStateError> get copyWith => _$UpcomingMealsStateErrorCopyWithImpl<UpcomingMealsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingMealsStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UpcomingMealsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $UpcomingMealsStateErrorCopyWith<$Res> implements $UpcomingMealsStateCopyWith<$Res> {
  factory $UpcomingMealsStateErrorCopyWith(UpcomingMealsStateError value, $Res Function(UpcomingMealsStateError) _then) = _$UpcomingMealsStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UpcomingMealsStateErrorCopyWithImpl<$Res>
    implements $UpcomingMealsStateErrorCopyWith<$Res> {
  _$UpcomingMealsStateErrorCopyWithImpl(this._self, this._then);

  final UpcomingMealsStateError _self;
  final $Res Function(UpcomingMealsStateError) _then;

/// Create a copy of UpcomingMealsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UpcomingMealsStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ShoppingListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShoppingListState()';
}


}

/// @nodoc
class $ShoppingListStateCopyWith<$Res>  {
$ShoppingListStateCopyWith(ShoppingListState _, $Res Function(ShoppingListState) __);
}


/// Adds pattern-matching-related methods to [ShoppingListState].
extension ShoppingListStatePatterns on ShoppingListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShoppingListStateInitial value)?  initial,TResult Function( ShoppingListStateGenerating value)?  generating,TResult Function( ShoppingListStateSuccess value)?  success,TResult Function( ShoppingListStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShoppingListStateInitial() when initial != null:
return initial(_that);case ShoppingListStateGenerating() when generating != null:
return generating(_that);case ShoppingListStateSuccess() when success != null:
return success(_that);case ShoppingListStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShoppingListStateInitial value)  initial,required TResult Function( ShoppingListStateGenerating value)  generating,required TResult Function( ShoppingListStateSuccess value)  success,required TResult Function( ShoppingListStateError value)  error,}){
final _that = this;
switch (_that) {
case ShoppingListStateInitial():
return initial(_that);case ShoppingListStateGenerating():
return generating(_that);case ShoppingListStateSuccess():
return success(_that);case ShoppingListStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShoppingListStateInitial value)?  initial,TResult? Function( ShoppingListStateGenerating value)?  generating,TResult? Function( ShoppingListStateSuccess value)?  success,TResult? Function( ShoppingListStateError value)?  error,}){
final _that = this;
switch (_that) {
case ShoppingListStateInitial() when initial != null:
return initial(_that);case ShoppingListStateGenerating() when generating != null:
return generating(_that);case ShoppingListStateSuccess() when success != null:
return success(_that);case ShoppingListStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  generating,TResult Function( ShoppingListResultModel result)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShoppingListStateInitial() when initial != null:
return initial();case ShoppingListStateGenerating() when generating != null:
return generating();case ShoppingListStateSuccess() when success != null:
return success(_that.result);case ShoppingListStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  generating,required TResult Function( ShoppingListResultModel result)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ShoppingListStateInitial():
return initial();case ShoppingListStateGenerating():
return generating();case ShoppingListStateSuccess():
return success(_that.result);case ShoppingListStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  generating,TResult? Function( ShoppingListResultModel result)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ShoppingListStateInitial() when initial != null:
return initial();case ShoppingListStateGenerating() when generating != null:
return generating();case ShoppingListStateSuccess() when success != null:
return success(_that.result);case ShoppingListStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ShoppingListStateInitial implements ShoppingListState {
  const ShoppingListStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingListStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShoppingListState.initial()';
}


}




/// @nodoc


class ShoppingListStateGenerating implements ShoppingListState {
  const ShoppingListStateGenerating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingListStateGenerating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShoppingListState.generating()';
}


}




/// @nodoc


class ShoppingListStateSuccess implements ShoppingListState {
  const ShoppingListStateSuccess(this.result);
  

 final  ShoppingListResultModel result;

/// Create a copy of ShoppingListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingListStateSuccessCopyWith<ShoppingListStateSuccess> get copyWith => _$ShoppingListStateSuccessCopyWithImpl<ShoppingListStateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingListStateSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ShoppingListState.success(result: $result)';
}


}

/// @nodoc
abstract mixin class $ShoppingListStateSuccessCopyWith<$Res> implements $ShoppingListStateCopyWith<$Res> {
  factory $ShoppingListStateSuccessCopyWith(ShoppingListStateSuccess value, $Res Function(ShoppingListStateSuccess) _then) = _$ShoppingListStateSuccessCopyWithImpl;
@useResult
$Res call({
 ShoppingListResultModel result
});


$ShoppingListResultModelCopyWith<$Res> get result;

}
/// @nodoc
class _$ShoppingListStateSuccessCopyWithImpl<$Res>
    implements $ShoppingListStateSuccessCopyWith<$Res> {
  _$ShoppingListStateSuccessCopyWithImpl(this._self, this._then);

  final ShoppingListStateSuccess _self;
  final $Res Function(ShoppingListStateSuccess) _then;

/// Create a copy of ShoppingListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(ShoppingListStateSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ShoppingListResultModel,
  ));
}

/// Create a copy of ShoppingListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShoppingListResultModelCopyWith<$Res> get result {
  
  return $ShoppingListResultModelCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class ShoppingListStateError implements ShoppingListState {
  const ShoppingListStateError(this.message);
  

 final  String message;

/// Create a copy of ShoppingListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingListStateErrorCopyWith<ShoppingListStateError> get copyWith => _$ShoppingListStateErrorCopyWithImpl<ShoppingListStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingListStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ShoppingListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ShoppingListStateErrorCopyWith<$Res> implements $ShoppingListStateCopyWith<$Res> {
  factory $ShoppingListStateErrorCopyWith(ShoppingListStateError value, $Res Function(ShoppingListStateError) _then) = _$ShoppingListStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ShoppingListStateErrorCopyWithImpl<$Res>
    implements $ShoppingListStateErrorCopyWith<$Res> {
  _$ShoppingListStateErrorCopyWithImpl(this._self, this._then);

  final ShoppingListStateError _self;
  final $Res Function(ShoppingListStateError) _then;

/// Create a copy of ShoppingListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ShoppingListStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MealHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealHistoryState()';
}


}

/// @nodoc
class $MealHistoryStateCopyWith<$Res>  {
$MealHistoryStateCopyWith(MealHistoryState _, $Res Function(MealHistoryState) __);
}


/// Adds pattern-matching-related methods to [MealHistoryState].
extension MealHistoryStatePatterns on MealHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MealHistoryStateInitial value)?  initial,TResult Function( MealHistoryStateLoading value)?  loading,TResult Function( MealHistoryStateLoaded value)?  loaded,TResult Function( MealHistoryStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MealHistoryStateInitial() when initial != null:
return initial(_that);case MealHistoryStateLoading() when loading != null:
return loading(_that);case MealHistoryStateLoaded() when loaded != null:
return loaded(_that);case MealHistoryStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MealHistoryStateInitial value)  initial,required TResult Function( MealHistoryStateLoading value)  loading,required TResult Function( MealHistoryStateLoaded value)  loaded,required TResult Function( MealHistoryStateError value)  error,}){
final _that = this;
switch (_that) {
case MealHistoryStateInitial():
return initial(_that);case MealHistoryStateLoading():
return loading(_that);case MealHistoryStateLoaded():
return loaded(_that);case MealHistoryStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MealHistoryStateInitial value)?  initial,TResult? Function( MealHistoryStateLoading value)?  loading,TResult? Function( MealHistoryStateLoaded value)?  loaded,TResult? Function( MealHistoryStateError value)?  error,}){
final _that = this;
switch (_that) {
case MealHistoryStateInitial() when initial != null:
return initial(_that);case MealHistoryStateLoading() when loading != null:
return loading(_that);case MealHistoryStateLoaded() when loaded != null:
return loaded(_that);case MealHistoryStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MealHistoryModel> history)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MealHistoryStateInitial() when initial != null:
return initial();case MealHistoryStateLoading() when loading != null:
return loading();case MealHistoryStateLoaded() when loaded != null:
return loaded(_that.history);case MealHistoryStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MealHistoryModel> history)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MealHistoryStateInitial():
return initial();case MealHistoryStateLoading():
return loading();case MealHistoryStateLoaded():
return loaded(_that.history);case MealHistoryStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MealHistoryModel> history)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MealHistoryStateInitial() when initial != null:
return initial();case MealHistoryStateLoading() when loading != null:
return loading();case MealHistoryStateLoaded() when loaded != null:
return loaded(_that.history);case MealHistoryStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MealHistoryStateInitial implements MealHistoryState {
  const MealHistoryStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealHistoryStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealHistoryState.initial()';
}


}




/// @nodoc


class MealHistoryStateLoading implements MealHistoryState {
  const MealHistoryStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealHistoryStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealHistoryState.loading()';
}


}




/// @nodoc


class MealHistoryStateLoaded implements MealHistoryState {
  const MealHistoryStateLoaded(final  List<MealHistoryModel> history): _history = history;
  

 final  List<MealHistoryModel> _history;
 List<MealHistoryModel> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of MealHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealHistoryStateLoadedCopyWith<MealHistoryStateLoaded> get copyWith => _$MealHistoryStateLoadedCopyWithImpl<MealHistoryStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealHistoryStateLoaded&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'MealHistoryState.loaded(history: $history)';
}


}

/// @nodoc
abstract mixin class $MealHistoryStateLoadedCopyWith<$Res> implements $MealHistoryStateCopyWith<$Res> {
  factory $MealHistoryStateLoadedCopyWith(MealHistoryStateLoaded value, $Res Function(MealHistoryStateLoaded) _then) = _$MealHistoryStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<MealHistoryModel> history
});




}
/// @nodoc
class _$MealHistoryStateLoadedCopyWithImpl<$Res>
    implements $MealHistoryStateLoadedCopyWith<$Res> {
  _$MealHistoryStateLoadedCopyWithImpl(this._self, this._then);

  final MealHistoryStateLoaded _self;
  final $Res Function(MealHistoryStateLoaded) _then;

/// Create a copy of MealHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(MealHistoryStateLoaded(
null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<MealHistoryModel>,
  ));
}


}

/// @nodoc


class MealHistoryStateError implements MealHistoryState {
  const MealHistoryStateError(this.message);
  

 final  String message;

/// Create a copy of MealHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealHistoryStateErrorCopyWith<MealHistoryStateError> get copyWith => _$MealHistoryStateErrorCopyWithImpl<MealHistoryStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealHistoryStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MealHistoryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MealHistoryStateErrorCopyWith<$Res> implements $MealHistoryStateCopyWith<$Res> {
  factory $MealHistoryStateErrorCopyWith(MealHistoryStateError value, $Res Function(MealHistoryStateError) _then) = _$MealHistoryStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MealHistoryStateErrorCopyWithImpl<$Res>
    implements $MealHistoryStateErrorCopyWith<$Res> {
  _$MealHistoryStateErrorCopyWithImpl(this._self, this._then);

  final MealHistoryStateError _self;
  final $Res Function(MealHistoryStateError) _then;

/// Create a copy of MealHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MealHistoryStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
