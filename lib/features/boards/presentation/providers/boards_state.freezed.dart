// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boards_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardsState()';
}


}

/// @nodoc
class $BoardsStateCopyWith<$Res>  {
$BoardsStateCopyWith(BoardsState _, $Res Function(BoardsState) __);
}


/// Adds pattern-matching-related methods to [BoardsState].
extension BoardsStatePatterns on BoardsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BoardsStateInitial value)?  initial,TResult Function( BoardsStateLoading value)?  loading,TResult Function( BoardsStateLoaded value)?  loaded,TResult Function( BoardsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BoardsStateInitial() when initial != null:
return initial(_that);case BoardsStateLoading() when loading != null:
return loading(_that);case BoardsStateLoaded() when loaded != null:
return loaded(_that);case BoardsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BoardsStateInitial value)  initial,required TResult Function( BoardsStateLoading value)  loading,required TResult Function( BoardsStateLoaded value)  loaded,required TResult Function( BoardsStateError value)  error,}){
final _that = this;
switch (_that) {
case BoardsStateInitial():
return initial(_that);case BoardsStateLoading():
return loading(_that);case BoardsStateLoaded():
return loaded(_that);case BoardsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BoardsStateInitial value)?  initial,TResult? Function( BoardsStateLoading value)?  loading,TResult? Function( BoardsStateLoaded value)?  loaded,TResult? Function( BoardsStateError value)?  error,}){
final _that = this;
switch (_that) {
case BoardsStateInitial() when initial != null:
return initial(_that);case BoardsStateLoading() when loading != null:
return loading(_that);case BoardsStateLoaded() when loaded != null:
return loaded(_that);case BoardsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<BoardModel> boards)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BoardsStateInitial() when initial != null:
return initial();case BoardsStateLoading() when loading != null:
return loading();case BoardsStateLoaded() when loaded != null:
return loaded(_that.boards);case BoardsStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<BoardModel> boards)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case BoardsStateInitial():
return initial();case BoardsStateLoading():
return loading();case BoardsStateLoaded():
return loaded(_that.boards);case BoardsStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<BoardModel> boards)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case BoardsStateInitial() when initial != null:
return initial();case BoardsStateLoading() when loading != null:
return loading();case BoardsStateLoaded() when loaded != null:
return loaded(_that.boards);case BoardsStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BoardsStateInitial implements BoardsState {
  const BoardsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardsState.initial()';
}


}




/// @nodoc


class BoardsStateLoading implements BoardsState {
  const BoardsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardsState.loading()';
}


}




/// @nodoc


class BoardsStateLoaded implements BoardsState {
  const BoardsStateLoaded(final  List<BoardModel> boards): _boards = boards;
  

 final  List<BoardModel> _boards;
 List<BoardModel> get boards {
  if (_boards is EqualUnmodifiableListView) return _boards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boards);
}


/// Create a copy of BoardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardsStateLoadedCopyWith<BoardsStateLoaded> get copyWith => _$BoardsStateLoadedCopyWithImpl<BoardsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardsStateLoaded&&const DeepCollectionEquality().equals(other._boards, _boards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_boards));

@override
String toString() {
  return 'BoardsState.loaded(boards: $boards)';
}


}

/// @nodoc
abstract mixin class $BoardsStateLoadedCopyWith<$Res> implements $BoardsStateCopyWith<$Res> {
  factory $BoardsStateLoadedCopyWith(BoardsStateLoaded value, $Res Function(BoardsStateLoaded) _then) = _$BoardsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<BoardModel> boards
});




}
/// @nodoc
class _$BoardsStateLoadedCopyWithImpl<$Res>
    implements $BoardsStateLoadedCopyWith<$Res> {
  _$BoardsStateLoadedCopyWithImpl(this._self, this._then);

  final BoardsStateLoaded _self;
  final $Res Function(BoardsStateLoaded) _then;

/// Create a copy of BoardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? boards = null,}) {
  return _then(BoardsStateLoaded(
null == boards ? _self._boards : boards // ignore: cast_nullable_to_non_nullable
as List<BoardModel>,
  ));
}


}

/// @nodoc


class BoardsStateError implements BoardsState {
  const BoardsStateError(this.message);
  

 final  String message;

/// Create a copy of BoardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardsStateErrorCopyWith<BoardsStateError> get copyWith => _$BoardsStateErrorCopyWithImpl<BoardsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardsStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BoardsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BoardsStateErrorCopyWith<$Res> implements $BoardsStateCopyWith<$Res> {
  factory $BoardsStateErrorCopyWith(BoardsStateError value, $Res Function(BoardsStateError) _then) = _$BoardsStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BoardsStateErrorCopyWithImpl<$Res>
    implements $BoardsStateErrorCopyWith<$Res> {
  _$BoardsStateErrorCopyWithImpl(this._self, this._then);

  final BoardsStateError _self;
  final $Res Function(BoardsStateError) _then;

/// Create a copy of BoardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BoardsStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BoardDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardDetailState()';
}


}

/// @nodoc
class $BoardDetailStateCopyWith<$Res>  {
$BoardDetailStateCopyWith(BoardDetailState _, $Res Function(BoardDetailState) __);
}


/// Adds pattern-matching-related methods to [BoardDetailState].
extension BoardDetailStatePatterns on BoardDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BoardDetailStateInitial value)?  initial,TResult Function( BoardDetailStateLoading value)?  loading,TResult Function( BoardDetailStateLoaded value)?  loaded,TResult Function( BoardDetailStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BoardDetailStateInitial() when initial != null:
return initial(_that);case BoardDetailStateLoading() when loading != null:
return loading(_that);case BoardDetailStateLoaded() when loaded != null:
return loaded(_that);case BoardDetailStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BoardDetailStateInitial value)  initial,required TResult Function( BoardDetailStateLoading value)  loading,required TResult Function( BoardDetailStateLoaded value)  loaded,required TResult Function( BoardDetailStateError value)  error,}){
final _that = this;
switch (_that) {
case BoardDetailStateInitial():
return initial(_that);case BoardDetailStateLoading():
return loading(_that);case BoardDetailStateLoaded():
return loaded(_that);case BoardDetailStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BoardDetailStateInitial value)?  initial,TResult? Function( BoardDetailStateLoading value)?  loading,TResult? Function( BoardDetailStateLoaded value)?  loaded,TResult? Function( BoardDetailStateError value)?  error,}){
final _that = this;
switch (_that) {
case BoardDetailStateInitial() when initial != null:
return initial(_that);case BoardDetailStateLoading() when loading != null:
return loading(_that);case BoardDetailStateLoaded() when loaded != null:
return loaded(_that);case BoardDetailStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( BoardModel board)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BoardDetailStateInitial() when initial != null:
return initial();case BoardDetailStateLoading() when loading != null:
return loading();case BoardDetailStateLoaded() when loaded != null:
return loaded(_that.board);case BoardDetailStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( BoardModel board)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case BoardDetailStateInitial():
return initial();case BoardDetailStateLoading():
return loading();case BoardDetailStateLoaded():
return loaded(_that.board);case BoardDetailStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( BoardModel board)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case BoardDetailStateInitial() when initial != null:
return initial();case BoardDetailStateLoading() when loading != null:
return loading();case BoardDetailStateLoaded() when loaded != null:
return loaded(_that.board);case BoardDetailStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BoardDetailStateInitial implements BoardDetailState {
  const BoardDetailStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardDetailStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardDetailState.initial()';
}


}




/// @nodoc


class BoardDetailStateLoading implements BoardDetailState {
  const BoardDetailStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardDetailStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardDetailState.loading()';
}


}




/// @nodoc


class BoardDetailStateLoaded implements BoardDetailState {
  const BoardDetailStateLoaded(this.board);
  

 final  BoardModel board;

/// Create a copy of BoardDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardDetailStateLoadedCopyWith<BoardDetailStateLoaded> get copyWith => _$BoardDetailStateLoadedCopyWithImpl<BoardDetailStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardDetailStateLoaded&&(identical(other.board, board) || other.board == board));
}


@override
int get hashCode => Object.hash(runtimeType,board);

@override
String toString() {
  return 'BoardDetailState.loaded(board: $board)';
}


}

/// @nodoc
abstract mixin class $BoardDetailStateLoadedCopyWith<$Res> implements $BoardDetailStateCopyWith<$Res> {
  factory $BoardDetailStateLoadedCopyWith(BoardDetailStateLoaded value, $Res Function(BoardDetailStateLoaded) _then) = _$BoardDetailStateLoadedCopyWithImpl;
@useResult
$Res call({
 BoardModel board
});


$BoardModelCopyWith<$Res> get board;

}
/// @nodoc
class _$BoardDetailStateLoadedCopyWithImpl<$Res>
    implements $BoardDetailStateLoadedCopyWith<$Res> {
  _$BoardDetailStateLoadedCopyWithImpl(this._self, this._then);

  final BoardDetailStateLoaded _self;
  final $Res Function(BoardDetailStateLoaded) _then;

/// Create a copy of BoardDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? board = null,}) {
  return _then(BoardDetailStateLoaded(
null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as BoardModel,
  ));
}

/// Create a copy of BoardDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardModelCopyWith<$Res> get board {
  
  return $BoardModelCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}
}

/// @nodoc


class BoardDetailStateError implements BoardDetailState {
  const BoardDetailStateError(this.message);
  

 final  String message;

/// Create a copy of BoardDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardDetailStateErrorCopyWith<BoardDetailStateError> get copyWith => _$BoardDetailStateErrorCopyWithImpl<BoardDetailStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardDetailStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BoardDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BoardDetailStateErrorCopyWith<$Res> implements $BoardDetailStateCopyWith<$Res> {
  factory $BoardDetailStateErrorCopyWith(BoardDetailStateError value, $Res Function(BoardDetailStateError) _then) = _$BoardDetailStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BoardDetailStateErrorCopyWithImpl<$Res>
    implements $BoardDetailStateErrorCopyWith<$Res> {
  _$BoardDetailStateErrorCopyWithImpl(this._self, this._then);

  final BoardDetailStateError _self;
  final $Res Function(BoardDetailStateError) _then;

/// Create a copy of BoardDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BoardDetailStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
