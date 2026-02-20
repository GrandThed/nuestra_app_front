// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlists_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WishlistCategoriesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistCategoriesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistCategoriesState()';
}


}

/// @nodoc
class $WishlistCategoriesStateCopyWith<$Res>  {
$WishlistCategoriesStateCopyWith(WishlistCategoriesState _, $Res Function(WishlistCategoriesState) __);
}


/// Adds pattern-matching-related methods to [WishlistCategoriesState].
extension WishlistCategoriesStatePatterns on WishlistCategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WishlistCategoriesStateInitial value)?  initial,TResult Function( WishlistCategoriesStateLoading value)?  loading,TResult Function( WishlistCategoriesStateLoaded value)?  loaded,TResult Function( WishlistCategoriesStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WishlistCategoriesStateInitial() when initial != null:
return initial(_that);case WishlistCategoriesStateLoading() when loading != null:
return loading(_that);case WishlistCategoriesStateLoaded() when loaded != null:
return loaded(_that);case WishlistCategoriesStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WishlistCategoriesStateInitial value)  initial,required TResult Function( WishlistCategoriesStateLoading value)  loading,required TResult Function( WishlistCategoriesStateLoaded value)  loaded,required TResult Function( WishlistCategoriesStateError value)  error,}){
final _that = this;
switch (_that) {
case WishlistCategoriesStateInitial():
return initial(_that);case WishlistCategoriesStateLoading():
return loading(_that);case WishlistCategoriesStateLoaded():
return loaded(_that);case WishlistCategoriesStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WishlistCategoriesStateInitial value)?  initial,TResult? Function( WishlistCategoriesStateLoading value)?  loading,TResult? Function( WishlistCategoriesStateLoaded value)?  loaded,TResult? Function( WishlistCategoriesStateError value)?  error,}){
final _that = this;
switch (_that) {
case WishlistCategoriesStateInitial() when initial != null:
return initial(_that);case WishlistCategoriesStateLoading() when loading != null:
return loading(_that);case WishlistCategoriesStateLoaded() when loaded != null:
return loaded(_that);case WishlistCategoriesStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WishlistCategoryModel> categories)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WishlistCategoriesStateInitial() when initial != null:
return initial();case WishlistCategoriesStateLoading() when loading != null:
return loading();case WishlistCategoriesStateLoaded() when loaded != null:
return loaded(_that.categories);case WishlistCategoriesStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WishlistCategoryModel> categories)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case WishlistCategoriesStateInitial():
return initial();case WishlistCategoriesStateLoading():
return loading();case WishlistCategoriesStateLoaded():
return loaded(_that.categories);case WishlistCategoriesStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WishlistCategoryModel> categories)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case WishlistCategoriesStateInitial() when initial != null:
return initial();case WishlistCategoriesStateLoading() when loading != null:
return loading();case WishlistCategoriesStateLoaded() when loaded != null:
return loaded(_that.categories);case WishlistCategoriesStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class WishlistCategoriesStateInitial implements WishlistCategoriesState {
  const WishlistCategoriesStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistCategoriesStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistCategoriesState.initial()';
}


}




/// @nodoc


class WishlistCategoriesStateLoading implements WishlistCategoriesState {
  const WishlistCategoriesStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistCategoriesStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistCategoriesState.loading()';
}


}




/// @nodoc


class WishlistCategoriesStateLoaded implements WishlistCategoriesState {
  const WishlistCategoriesStateLoaded(final  List<WishlistCategoryModel> categories): _categories = categories;
  

 final  List<WishlistCategoryModel> _categories;
 List<WishlistCategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of WishlistCategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistCategoriesStateLoadedCopyWith<WishlistCategoriesStateLoaded> get copyWith => _$WishlistCategoriesStateLoadedCopyWithImpl<WishlistCategoriesStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistCategoriesStateLoaded&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'WishlistCategoriesState.loaded(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $WishlistCategoriesStateLoadedCopyWith<$Res> implements $WishlistCategoriesStateCopyWith<$Res> {
  factory $WishlistCategoriesStateLoadedCopyWith(WishlistCategoriesStateLoaded value, $Res Function(WishlistCategoriesStateLoaded) _then) = _$WishlistCategoriesStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<WishlistCategoryModel> categories
});




}
/// @nodoc
class _$WishlistCategoriesStateLoadedCopyWithImpl<$Res>
    implements $WishlistCategoriesStateLoadedCopyWith<$Res> {
  _$WishlistCategoriesStateLoadedCopyWithImpl(this._self, this._then);

  final WishlistCategoriesStateLoaded _self;
  final $Res Function(WishlistCategoriesStateLoaded) _then;

/// Create a copy of WishlistCategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(WishlistCategoriesStateLoaded(
null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<WishlistCategoryModel>,
  ));
}


}

/// @nodoc


class WishlistCategoriesStateError implements WishlistCategoriesState {
  const WishlistCategoriesStateError(this.message);
  

 final  String message;

/// Create a copy of WishlistCategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistCategoriesStateErrorCopyWith<WishlistCategoriesStateError> get copyWith => _$WishlistCategoriesStateErrorCopyWithImpl<WishlistCategoriesStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistCategoriesStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WishlistCategoriesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $WishlistCategoriesStateErrorCopyWith<$Res> implements $WishlistCategoriesStateCopyWith<$Res> {
  factory $WishlistCategoriesStateErrorCopyWith(WishlistCategoriesStateError value, $Res Function(WishlistCategoriesStateError) _then) = _$WishlistCategoriesStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WishlistCategoriesStateErrorCopyWithImpl<$Res>
    implements $WishlistCategoriesStateErrorCopyWith<$Res> {
  _$WishlistCategoriesStateErrorCopyWithImpl(this._self, this._then);

  final WishlistCategoriesStateError _self;
  final $Res Function(WishlistCategoriesStateError) _then;

/// Create a copy of WishlistCategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WishlistCategoriesStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$WishlistItemsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistItemsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistItemsState()';
}


}

/// @nodoc
class $WishlistItemsStateCopyWith<$Res>  {
$WishlistItemsStateCopyWith(WishlistItemsState _, $Res Function(WishlistItemsState) __);
}


/// Adds pattern-matching-related methods to [WishlistItemsState].
extension WishlistItemsStatePatterns on WishlistItemsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WishlistItemsStateInitial value)?  initial,TResult Function( WishlistItemsStateLoading value)?  loading,TResult Function( WishlistItemsStateLoaded value)?  loaded,TResult Function( WishlistItemsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WishlistItemsStateInitial() when initial != null:
return initial(_that);case WishlistItemsStateLoading() when loading != null:
return loading(_that);case WishlistItemsStateLoaded() when loaded != null:
return loaded(_that);case WishlistItemsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WishlistItemsStateInitial value)  initial,required TResult Function( WishlistItemsStateLoading value)  loading,required TResult Function( WishlistItemsStateLoaded value)  loaded,required TResult Function( WishlistItemsStateError value)  error,}){
final _that = this;
switch (_that) {
case WishlistItemsStateInitial():
return initial(_that);case WishlistItemsStateLoading():
return loading(_that);case WishlistItemsStateLoaded():
return loaded(_that);case WishlistItemsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WishlistItemsStateInitial value)?  initial,TResult? Function( WishlistItemsStateLoading value)?  loading,TResult? Function( WishlistItemsStateLoaded value)?  loaded,TResult? Function( WishlistItemsStateError value)?  error,}){
final _that = this;
switch (_that) {
case WishlistItemsStateInitial() when initial != null:
return initial(_that);case WishlistItemsStateLoading() when loading != null:
return loading(_that);case WishlistItemsStateLoaded() when loaded != null:
return loaded(_that);case WishlistItemsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WishlistItemModel> items)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WishlistItemsStateInitial() when initial != null:
return initial();case WishlistItemsStateLoading() when loading != null:
return loading();case WishlistItemsStateLoaded() when loaded != null:
return loaded(_that.items);case WishlistItemsStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WishlistItemModel> items)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case WishlistItemsStateInitial():
return initial();case WishlistItemsStateLoading():
return loading();case WishlistItemsStateLoaded():
return loaded(_that.items);case WishlistItemsStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WishlistItemModel> items)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case WishlistItemsStateInitial() when initial != null:
return initial();case WishlistItemsStateLoading() when loading != null:
return loading();case WishlistItemsStateLoaded() when loaded != null:
return loaded(_that.items);case WishlistItemsStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class WishlistItemsStateInitial implements WishlistItemsState {
  const WishlistItemsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistItemsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistItemsState.initial()';
}


}




/// @nodoc


class WishlistItemsStateLoading implements WishlistItemsState {
  const WishlistItemsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistItemsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistItemsState.loading()';
}


}




/// @nodoc


class WishlistItemsStateLoaded implements WishlistItemsState {
  const WishlistItemsStateLoaded(final  List<WishlistItemModel> items): _items = items;
  

 final  List<WishlistItemModel> _items;
 List<WishlistItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of WishlistItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistItemsStateLoadedCopyWith<WishlistItemsStateLoaded> get copyWith => _$WishlistItemsStateLoadedCopyWithImpl<WishlistItemsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistItemsStateLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'WishlistItemsState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $WishlistItemsStateLoadedCopyWith<$Res> implements $WishlistItemsStateCopyWith<$Res> {
  factory $WishlistItemsStateLoadedCopyWith(WishlistItemsStateLoaded value, $Res Function(WishlistItemsStateLoaded) _then) = _$WishlistItemsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<WishlistItemModel> items
});




}
/// @nodoc
class _$WishlistItemsStateLoadedCopyWithImpl<$Res>
    implements $WishlistItemsStateLoadedCopyWith<$Res> {
  _$WishlistItemsStateLoadedCopyWithImpl(this._self, this._then);

  final WishlistItemsStateLoaded _self;
  final $Res Function(WishlistItemsStateLoaded) _then;

/// Create a copy of WishlistItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(WishlistItemsStateLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WishlistItemModel>,
  ));
}


}

/// @nodoc


class WishlistItemsStateError implements WishlistItemsState {
  const WishlistItemsStateError(this.message);
  

 final  String message;

/// Create a copy of WishlistItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistItemsStateErrorCopyWith<WishlistItemsStateError> get copyWith => _$WishlistItemsStateErrorCopyWithImpl<WishlistItemsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistItemsStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WishlistItemsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $WishlistItemsStateErrorCopyWith<$Res> implements $WishlistItemsStateCopyWith<$Res> {
  factory $WishlistItemsStateErrorCopyWith(WishlistItemsStateError value, $Res Function(WishlistItemsStateError) _then) = _$WishlistItemsStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WishlistItemsStateErrorCopyWithImpl<$Res>
    implements $WishlistItemsStateErrorCopyWith<$Res> {
  _$WishlistItemsStateErrorCopyWithImpl(this._self, this._then);

  final WishlistItemsStateError _self;
  final $Res Function(WishlistItemsStateError) _then;

/// Create a copy of WishlistItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WishlistItemsStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$WishlistsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistsState()';
}


}

/// @nodoc
class $WishlistsStateCopyWith<$Res>  {
$WishlistsStateCopyWith(WishlistsState _, $Res Function(WishlistsState) __);
}


/// Adds pattern-matching-related methods to [WishlistsState].
extension WishlistsStatePatterns on WishlistsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WishlistsStateInitial value)?  initial,TResult Function( WishlistsStateLoading value)?  loading,TResult Function( WishlistsStateLoaded value)?  loaded,TResult Function( WishlistsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WishlistsStateInitial() when initial != null:
return initial(_that);case WishlistsStateLoading() when loading != null:
return loading(_that);case WishlistsStateLoaded() when loaded != null:
return loaded(_that);case WishlistsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WishlistsStateInitial value)  initial,required TResult Function( WishlistsStateLoading value)  loading,required TResult Function( WishlistsStateLoaded value)  loaded,required TResult Function( WishlistsStateError value)  error,}){
final _that = this;
switch (_that) {
case WishlistsStateInitial():
return initial(_that);case WishlistsStateLoading():
return loading(_that);case WishlistsStateLoaded():
return loaded(_that);case WishlistsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WishlistsStateInitial value)?  initial,TResult? Function( WishlistsStateLoading value)?  loading,TResult? Function( WishlistsStateLoaded value)?  loaded,TResult? Function( WishlistsStateError value)?  error,}){
final _that = this;
switch (_that) {
case WishlistsStateInitial() when initial != null:
return initial(_that);case WishlistsStateLoading() when loading != null:
return loading(_that);case WishlistsStateLoaded() when loaded != null:
return loaded(_that);case WishlistsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WishlistCategoryModel> categories,  List<WishlistItemModel> items)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WishlistsStateInitial() when initial != null:
return initial();case WishlistsStateLoading() when loading != null:
return loading();case WishlistsStateLoaded() when loaded != null:
return loaded(_that.categories,_that.items);case WishlistsStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WishlistCategoryModel> categories,  List<WishlistItemModel> items)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case WishlistsStateInitial():
return initial();case WishlistsStateLoading():
return loading();case WishlistsStateLoaded():
return loaded(_that.categories,_that.items);case WishlistsStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WishlistCategoryModel> categories,  List<WishlistItemModel> items)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case WishlistsStateInitial() when initial != null:
return initial();case WishlistsStateLoading() when loading != null:
return loading();case WishlistsStateLoaded() when loaded != null:
return loaded(_that.categories,_that.items);case WishlistsStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class WishlistsStateInitial implements WishlistsState {
  const WishlistsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistsState.initial()';
}


}




/// @nodoc


class WishlistsStateLoading implements WishlistsState {
  const WishlistsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishlistsState.loading()';
}


}




/// @nodoc


class WishlistsStateLoaded implements WishlistsState {
  const WishlistsStateLoaded({required final  List<WishlistCategoryModel> categories, required final  List<WishlistItemModel> items}): _categories = categories,_items = items;
  

 final  List<WishlistCategoryModel> _categories;
 List<WishlistCategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<WishlistItemModel> _items;
 List<WishlistItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of WishlistsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistsStateLoadedCopyWith<WishlistsStateLoaded> get copyWith => _$WishlistsStateLoadedCopyWithImpl<WishlistsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistsStateLoaded&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'WishlistsState.loaded(categories: $categories, items: $items)';
}


}

/// @nodoc
abstract mixin class $WishlistsStateLoadedCopyWith<$Res> implements $WishlistsStateCopyWith<$Res> {
  factory $WishlistsStateLoadedCopyWith(WishlistsStateLoaded value, $Res Function(WishlistsStateLoaded) _then) = _$WishlistsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<WishlistCategoryModel> categories, List<WishlistItemModel> items
});




}
/// @nodoc
class _$WishlistsStateLoadedCopyWithImpl<$Res>
    implements $WishlistsStateLoadedCopyWith<$Res> {
  _$WishlistsStateLoadedCopyWithImpl(this._self, this._then);

  final WishlistsStateLoaded _self;
  final $Res Function(WishlistsStateLoaded) _then;

/// Create a copy of WishlistsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? items = null,}) {
  return _then(WishlistsStateLoaded(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<WishlistCategoryModel>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<WishlistItemModel>,
  ));
}


}

/// @nodoc


class WishlistsStateError implements WishlistsState {
  const WishlistsStateError(this.message);
  

 final  String message;

/// Create a copy of WishlistsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistsStateErrorCopyWith<WishlistsStateError> get copyWith => _$WishlistsStateErrorCopyWithImpl<WishlistsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistsStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WishlistsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $WishlistsStateErrorCopyWith<$Res> implements $WishlistsStateCopyWith<$Res> {
  factory $WishlistsStateErrorCopyWith(WishlistsStateError value, $Res Function(WishlistsStateError) _then) = _$WishlistsStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WishlistsStateErrorCopyWithImpl<$Res>
    implements $WishlistsStateErrorCopyWith<$Res> {
  _$WishlistsStateErrorCopyWithImpl(this._self, this._then);

  final WishlistsStateError _self;
  final $Res Function(WishlistsStateError) _then;

/// Create a copy of WishlistsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WishlistsStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PurchaseHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseHistoryState()';
}


}

/// @nodoc
class $PurchaseHistoryStateCopyWith<$Res>  {
$PurchaseHistoryStateCopyWith(PurchaseHistoryState _, $Res Function(PurchaseHistoryState) __);
}


/// Adds pattern-matching-related methods to [PurchaseHistoryState].
extension PurchaseHistoryStatePatterns on PurchaseHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PurchaseHistoryStateInitial value)?  initial,TResult Function( PurchaseHistoryStateLoading value)?  loading,TResult Function( PurchaseHistoryStateLoaded value)?  loaded,TResult Function( PurchaseHistoryStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PurchaseHistoryStateInitial() when initial != null:
return initial(_that);case PurchaseHistoryStateLoading() when loading != null:
return loading(_that);case PurchaseHistoryStateLoaded() when loaded != null:
return loaded(_that);case PurchaseHistoryStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PurchaseHistoryStateInitial value)  initial,required TResult Function( PurchaseHistoryStateLoading value)  loading,required TResult Function( PurchaseHistoryStateLoaded value)  loaded,required TResult Function( PurchaseHistoryStateError value)  error,}){
final _that = this;
switch (_that) {
case PurchaseHistoryStateInitial():
return initial(_that);case PurchaseHistoryStateLoading():
return loading(_that);case PurchaseHistoryStateLoaded():
return loaded(_that);case PurchaseHistoryStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PurchaseHistoryStateInitial value)?  initial,TResult? Function( PurchaseHistoryStateLoading value)?  loading,TResult? Function( PurchaseHistoryStateLoaded value)?  loaded,TResult? Function( PurchaseHistoryStateError value)?  error,}){
final _that = this;
switch (_that) {
case PurchaseHistoryStateInitial() when initial != null:
return initial(_that);case PurchaseHistoryStateLoading() when loading != null:
return loading(_that);case PurchaseHistoryStateLoaded() when loaded != null:
return loaded(_that);case PurchaseHistoryStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WishlistPurchaseHistoryModel> history)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PurchaseHistoryStateInitial() when initial != null:
return initial();case PurchaseHistoryStateLoading() when loading != null:
return loading();case PurchaseHistoryStateLoaded() when loaded != null:
return loaded(_that.history);case PurchaseHistoryStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WishlistPurchaseHistoryModel> history)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case PurchaseHistoryStateInitial():
return initial();case PurchaseHistoryStateLoading():
return loading();case PurchaseHistoryStateLoaded():
return loaded(_that.history);case PurchaseHistoryStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WishlistPurchaseHistoryModel> history)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case PurchaseHistoryStateInitial() when initial != null:
return initial();case PurchaseHistoryStateLoading() when loading != null:
return loading();case PurchaseHistoryStateLoaded() when loaded != null:
return loaded(_that.history);case PurchaseHistoryStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PurchaseHistoryStateInitial implements PurchaseHistoryState {
  const PurchaseHistoryStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseHistoryStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseHistoryState.initial()';
}


}




/// @nodoc


class PurchaseHistoryStateLoading implements PurchaseHistoryState {
  const PurchaseHistoryStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseHistoryStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseHistoryState.loading()';
}


}




/// @nodoc


class PurchaseHistoryStateLoaded implements PurchaseHistoryState {
  const PurchaseHistoryStateLoaded(final  List<WishlistPurchaseHistoryModel> history): _history = history;
  

 final  List<WishlistPurchaseHistoryModel> _history;
 List<WishlistPurchaseHistoryModel> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of PurchaseHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseHistoryStateLoadedCopyWith<PurchaseHistoryStateLoaded> get copyWith => _$PurchaseHistoryStateLoadedCopyWithImpl<PurchaseHistoryStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseHistoryStateLoaded&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'PurchaseHistoryState.loaded(history: $history)';
}


}

/// @nodoc
abstract mixin class $PurchaseHistoryStateLoadedCopyWith<$Res> implements $PurchaseHistoryStateCopyWith<$Res> {
  factory $PurchaseHistoryStateLoadedCopyWith(PurchaseHistoryStateLoaded value, $Res Function(PurchaseHistoryStateLoaded) _then) = _$PurchaseHistoryStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<WishlistPurchaseHistoryModel> history
});




}
/// @nodoc
class _$PurchaseHistoryStateLoadedCopyWithImpl<$Res>
    implements $PurchaseHistoryStateLoadedCopyWith<$Res> {
  _$PurchaseHistoryStateLoadedCopyWithImpl(this._self, this._then);

  final PurchaseHistoryStateLoaded _self;
  final $Res Function(PurchaseHistoryStateLoaded) _then;

/// Create a copy of PurchaseHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(PurchaseHistoryStateLoaded(
null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<WishlistPurchaseHistoryModel>,
  ));
}


}

/// @nodoc


class PurchaseHistoryStateError implements PurchaseHistoryState {
  const PurchaseHistoryStateError(this.message);
  

 final  String message;

/// Create a copy of PurchaseHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseHistoryStateErrorCopyWith<PurchaseHistoryStateError> get copyWith => _$PurchaseHistoryStateErrorCopyWithImpl<PurchaseHistoryStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseHistoryStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PurchaseHistoryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PurchaseHistoryStateErrorCopyWith<$Res> implements $PurchaseHistoryStateCopyWith<$Res> {
  factory $PurchaseHistoryStateErrorCopyWith(PurchaseHistoryStateError value, $Res Function(PurchaseHistoryStateError) _then) = _$PurchaseHistoryStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PurchaseHistoryStateErrorCopyWithImpl<$Res>
    implements $PurchaseHistoryStateErrorCopyWith<$Res> {
  _$PurchaseHistoryStateErrorCopyWithImpl(this._self, this._then);

  final PurchaseHistoryStateError _self;
  final $Res Function(PurchaseHistoryStateError) _then;

/// Create a copy of PurchaseHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PurchaseHistoryStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
