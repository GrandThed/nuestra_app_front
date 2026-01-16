// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarState()';
}


}

/// @nodoc
class $CalendarStateCopyWith<$Res>  {
$CalendarStateCopyWith(CalendarState _, $Res Function(CalendarState) __);
}


/// Adds pattern-matching-related methods to [CalendarState].
extension CalendarStatePatterns on CalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CalendarStateInitial value)?  initial,TResult Function( CalendarStateLoading value)?  loading,TResult Function( CalendarStateLoaded value)?  loaded,TResult Function( CalendarStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CalendarStateInitial() when initial != null:
return initial(_that);case CalendarStateLoading() when loading != null:
return loading(_that);case CalendarStateLoaded() when loaded != null:
return loaded(_that);case CalendarStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CalendarStateInitial value)  initial,required TResult Function( CalendarStateLoading value)  loading,required TResult Function( CalendarStateLoaded value)  loaded,required TResult Function( CalendarStateError value)  error,}){
final _that = this;
switch (_that) {
case CalendarStateInitial():
return initial(_that);case CalendarStateLoading():
return loading(_that);case CalendarStateLoaded():
return loaded(_that);case CalendarStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CalendarStateInitial value)?  initial,TResult? Function( CalendarStateLoading value)?  loading,TResult? Function( CalendarStateLoaded value)?  loaded,TResult? Function( CalendarStateError value)?  error,}){
final _that = this;
switch (_that) {
case CalendarStateInitial() when initial != null:
return initial(_that);case CalendarStateLoading() when loading != null:
return loading(_that);case CalendarStateLoaded() when loaded != null:
return loaded(_that);case CalendarStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CalendarEventModel> events,  DateTime selectedDate,  DateTime focusedMonth,  CalendarViewMode viewMode)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CalendarStateInitial() when initial != null:
return initial();case CalendarStateLoading() when loading != null:
return loading();case CalendarStateLoaded() when loaded != null:
return loaded(_that.events,_that.selectedDate,_that.focusedMonth,_that.viewMode);case CalendarStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CalendarEventModel> events,  DateTime selectedDate,  DateTime focusedMonth,  CalendarViewMode viewMode)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CalendarStateInitial():
return initial();case CalendarStateLoading():
return loading();case CalendarStateLoaded():
return loaded(_that.events,_that.selectedDate,_that.focusedMonth,_that.viewMode);case CalendarStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CalendarEventModel> events,  DateTime selectedDate,  DateTime focusedMonth,  CalendarViewMode viewMode)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CalendarStateInitial() when initial != null:
return initial();case CalendarStateLoading() when loading != null:
return loading();case CalendarStateLoaded() when loaded != null:
return loaded(_that.events,_that.selectedDate,_that.focusedMonth,_that.viewMode);case CalendarStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CalendarStateInitial implements CalendarState {
  const CalendarStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarState.initial()';
}


}




/// @nodoc


class CalendarStateLoading implements CalendarState {
  const CalendarStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarState.loading()';
}


}




/// @nodoc


class CalendarStateLoaded implements CalendarState {
  const CalendarStateLoaded({required final  List<CalendarEventModel> events, required this.selectedDate, required this.focusedMonth, this.viewMode = CalendarViewMode.month}): _events = events;
  

 final  List<CalendarEventModel> _events;
 List<CalendarEventModel> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

 final  DateTime selectedDate;
 final  DateTime focusedMonth;
@JsonKey() final  CalendarViewMode viewMode;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateLoadedCopyWith<CalendarStateLoaded> get copyWith => _$CalendarStateLoadedCopyWithImpl<CalendarStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarStateLoaded&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.focusedMonth, focusedMonth) || other.focusedMonth == focusedMonth)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),selectedDate,focusedMonth,viewMode);

@override
String toString() {
  return 'CalendarState.loaded(events: $events, selectedDate: $selectedDate, focusedMonth: $focusedMonth, viewMode: $viewMode)';
}


}

/// @nodoc
abstract mixin class $CalendarStateLoadedCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory $CalendarStateLoadedCopyWith(CalendarStateLoaded value, $Res Function(CalendarStateLoaded) _then) = _$CalendarStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<CalendarEventModel> events, DateTime selectedDate, DateTime focusedMonth, CalendarViewMode viewMode
});




}
/// @nodoc
class _$CalendarStateLoadedCopyWithImpl<$Res>
    implements $CalendarStateLoadedCopyWith<$Res> {
  _$CalendarStateLoadedCopyWithImpl(this._self, this._then);

  final CalendarStateLoaded _self;
  final $Res Function(CalendarStateLoaded) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? events = null,Object? selectedDate = null,Object? focusedMonth = null,Object? viewMode = null,}) {
  return _then(CalendarStateLoaded(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEventModel>,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,focusedMonth: null == focusedMonth ? _self.focusedMonth : focusedMonth // ignore: cast_nullable_to_non_nullable
as DateTime,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,
  ));
}


}

/// @nodoc


class CalendarStateError implements CalendarState {
  const CalendarStateError(this.message);
  

 final  String message;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateErrorCopyWith<CalendarStateError> get copyWith => _$CalendarStateErrorCopyWithImpl<CalendarStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CalendarState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CalendarStateErrorCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory $CalendarStateErrorCopyWith(CalendarStateError value, $Res Function(CalendarStateError) _then) = _$CalendarStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CalendarStateErrorCopyWithImpl<$Res>
    implements $CalendarStateErrorCopyWith<$Res> {
  _$CalendarStateErrorCopyWithImpl(this._self, this._then);

  final CalendarStateError _self;
  final $Res Function(CalendarStateError) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CalendarStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TimelineState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimelineState()';
}


}

/// @nodoc
class $TimelineStateCopyWith<$Res>  {
$TimelineStateCopyWith(TimelineState _, $Res Function(TimelineState) __);
}


/// Adds pattern-matching-related methods to [TimelineState].
extension TimelineStatePatterns on TimelineState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TimelineStateInitial value)?  initial,TResult Function( TimelineStateLoading value)?  loading,TResult Function( TimelineStateLoaded value)?  loaded,TResult Function( TimelineStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TimelineStateInitial() when initial != null:
return initial(_that);case TimelineStateLoading() when loading != null:
return loading(_that);case TimelineStateLoaded() when loaded != null:
return loaded(_that);case TimelineStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TimelineStateInitial value)  initial,required TResult Function( TimelineStateLoading value)  loading,required TResult Function( TimelineStateLoaded value)  loaded,required TResult Function( TimelineStateError value)  error,}){
final _that = this;
switch (_that) {
case TimelineStateInitial():
return initial(_that);case TimelineStateLoading():
return loading(_that);case TimelineStateLoaded():
return loaded(_that);case TimelineStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TimelineStateInitial value)?  initial,TResult? Function( TimelineStateLoading value)?  loading,TResult? Function( TimelineStateLoaded value)?  loaded,TResult? Function( TimelineStateError value)?  error,}){
final _that = this;
switch (_that) {
case TimelineStateInitial() when initial != null:
return initial(_that);case TimelineStateLoading() when loading != null:
return loading(_that);case TimelineStateLoaded() when loaded != null:
return loaded(_that);case TimelineStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TimelineItemModel> items)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TimelineStateInitial() when initial != null:
return initial();case TimelineStateLoading() when loading != null:
return loading();case TimelineStateLoaded() when loaded != null:
return loaded(_that.items);case TimelineStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TimelineItemModel> items)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TimelineStateInitial():
return initial();case TimelineStateLoading():
return loading();case TimelineStateLoaded():
return loaded(_that.items);case TimelineStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TimelineItemModel> items)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TimelineStateInitial() when initial != null:
return initial();case TimelineStateLoading() when loading != null:
return loading();case TimelineStateLoaded() when loaded != null:
return loaded(_that.items);case TimelineStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TimelineStateInitial implements TimelineState {
  const TimelineStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimelineState.initial()';
}


}




/// @nodoc


class TimelineStateLoading implements TimelineState {
  const TimelineStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimelineState.loading()';
}


}




/// @nodoc


class TimelineStateLoaded implements TimelineState {
  const TimelineStateLoaded(final  List<TimelineItemModel> items): _items = items;
  

 final  List<TimelineItemModel> _items;
 List<TimelineItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TimelineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineStateLoadedCopyWith<TimelineStateLoaded> get copyWith => _$TimelineStateLoadedCopyWithImpl<TimelineStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineStateLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TimelineState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $TimelineStateLoadedCopyWith<$Res> implements $TimelineStateCopyWith<$Res> {
  factory $TimelineStateLoadedCopyWith(TimelineStateLoaded value, $Res Function(TimelineStateLoaded) _then) = _$TimelineStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<TimelineItemModel> items
});




}
/// @nodoc
class _$TimelineStateLoadedCopyWithImpl<$Res>
    implements $TimelineStateLoadedCopyWith<$Res> {
  _$TimelineStateLoadedCopyWithImpl(this._self, this._then);

  final TimelineStateLoaded _self;
  final $Res Function(TimelineStateLoaded) _then;

/// Create a copy of TimelineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(TimelineStateLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TimelineItemModel>,
  ));
}


}

/// @nodoc


class TimelineStateError implements TimelineState {
  const TimelineStateError(this.message);
  

 final  String message;

/// Create a copy of TimelineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineStateErrorCopyWith<TimelineStateError> get copyWith => _$TimelineStateErrorCopyWithImpl<TimelineStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TimelineState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TimelineStateErrorCopyWith<$Res> implements $TimelineStateCopyWith<$Res> {
  factory $TimelineStateErrorCopyWith(TimelineStateError value, $Res Function(TimelineStateError) _then) = _$TimelineStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TimelineStateErrorCopyWithImpl<$Res>
    implements $TimelineStateErrorCopyWith<$Res> {
  _$TimelineStateErrorCopyWithImpl(this._self, this._then);

  final TimelineStateError _self;
  final $Res Function(TimelineStateError) _then;

/// Create a copy of TimelineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TimelineStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$EventDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventDetailState()';
}


}

/// @nodoc
class $EventDetailStateCopyWith<$Res>  {
$EventDetailStateCopyWith(EventDetailState _, $Res Function(EventDetailState) __);
}


/// Adds pattern-matching-related methods to [EventDetailState].
extension EventDetailStatePatterns on EventDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EventDetailStateInitial value)?  initial,TResult Function( EventDetailStateLoading value)?  loading,TResult Function( EventDetailStateLoaded value)?  loaded,TResult Function( EventDetailStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EventDetailStateInitial() when initial != null:
return initial(_that);case EventDetailStateLoading() when loading != null:
return loading(_that);case EventDetailStateLoaded() when loaded != null:
return loaded(_that);case EventDetailStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EventDetailStateInitial value)  initial,required TResult Function( EventDetailStateLoading value)  loading,required TResult Function( EventDetailStateLoaded value)  loaded,required TResult Function( EventDetailStateError value)  error,}){
final _that = this;
switch (_that) {
case EventDetailStateInitial():
return initial(_that);case EventDetailStateLoading():
return loading(_that);case EventDetailStateLoaded():
return loaded(_that);case EventDetailStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EventDetailStateInitial value)?  initial,TResult? Function( EventDetailStateLoading value)?  loading,TResult? Function( EventDetailStateLoaded value)?  loaded,TResult? Function( EventDetailStateError value)?  error,}){
final _that = this;
switch (_that) {
case EventDetailStateInitial() when initial != null:
return initial(_that);case EventDetailStateLoading() when loading != null:
return loading(_that);case EventDetailStateLoaded() when loaded != null:
return loaded(_that);case EventDetailStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( CalendarEventModel event)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EventDetailStateInitial() when initial != null:
return initial();case EventDetailStateLoading() when loading != null:
return loading();case EventDetailStateLoaded() when loaded != null:
return loaded(_that.event);case EventDetailStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( CalendarEventModel event)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case EventDetailStateInitial():
return initial();case EventDetailStateLoading():
return loading();case EventDetailStateLoaded():
return loaded(_that.event);case EventDetailStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( CalendarEventModel event)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case EventDetailStateInitial() when initial != null:
return initial();case EventDetailStateLoading() when loading != null:
return loading();case EventDetailStateLoaded() when loaded != null:
return loaded(_that.event);case EventDetailStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class EventDetailStateInitial implements EventDetailState {
  const EventDetailStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventDetailState.initial()';
}


}




/// @nodoc


class EventDetailStateLoading implements EventDetailState {
  const EventDetailStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventDetailState.loading()';
}


}




/// @nodoc


class EventDetailStateLoaded implements EventDetailState {
  const EventDetailStateLoaded(this.event);
  

 final  CalendarEventModel event;

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailStateLoadedCopyWith<EventDetailStateLoaded> get copyWith => _$EventDetailStateLoadedCopyWithImpl<EventDetailStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailStateLoaded&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,event);

@override
String toString() {
  return 'EventDetailState.loaded(event: $event)';
}


}

/// @nodoc
abstract mixin class $EventDetailStateLoadedCopyWith<$Res> implements $EventDetailStateCopyWith<$Res> {
  factory $EventDetailStateLoadedCopyWith(EventDetailStateLoaded value, $Res Function(EventDetailStateLoaded) _then) = _$EventDetailStateLoadedCopyWithImpl;
@useResult
$Res call({
 CalendarEventModel event
});


$CalendarEventModelCopyWith<$Res> get event;

}
/// @nodoc
class _$EventDetailStateLoadedCopyWithImpl<$Res>
    implements $EventDetailStateLoadedCopyWith<$Res> {
  _$EventDetailStateLoadedCopyWithImpl(this._self, this._then);

  final EventDetailStateLoaded _self;
  final $Res Function(EventDetailStateLoaded) _then;

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(EventDetailStateLoaded(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as CalendarEventModel,
  ));
}

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarEventModelCopyWith<$Res> get event {
  
  return $CalendarEventModelCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

/// @nodoc


class EventDetailStateError implements EventDetailState {
  const EventDetailStateError(this.message);
  

 final  String message;

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailStateErrorCopyWith<EventDetailStateError> get copyWith => _$EventDetailStateErrorCopyWithImpl<EventDetailStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'EventDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $EventDetailStateErrorCopyWith<$Res> implements $EventDetailStateCopyWith<$Res> {
  factory $EventDetailStateErrorCopyWith(EventDetailStateError value, $Res Function(EventDetailStateError) _then) = _$EventDetailStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EventDetailStateErrorCopyWithImpl<$Res>
    implements $EventDetailStateErrorCopyWith<$Res> {
  _$EventDetailStateErrorCopyWithImpl(this._self, this._then);

  final EventDetailStateError _self;
  final $Res Function(EventDetailStateError) _then;

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EventDetailStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
