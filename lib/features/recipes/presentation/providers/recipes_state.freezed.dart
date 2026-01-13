// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipesState()';
}


}

/// @nodoc
class $RecipesStateCopyWith<$Res>  {
$RecipesStateCopyWith(RecipesState _, $Res Function(RecipesState) __);
}


/// Adds pattern-matching-related methods to [RecipesState].
extension RecipesStatePatterns on RecipesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecipesStateInitial value)?  initial,TResult Function( RecipesStateLoading value)?  loading,TResult Function( RecipesStateLoaded value)?  loaded,TResult Function( RecipesStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecipesStateInitial() when initial != null:
return initial(_that);case RecipesStateLoading() when loading != null:
return loading(_that);case RecipesStateLoaded() when loaded != null:
return loaded(_that);case RecipesStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecipesStateInitial value)  initial,required TResult Function( RecipesStateLoading value)  loading,required TResult Function( RecipesStateLoaded value)  loaded,required TResult Function( RecipesStateError value)  error,}){
final _that = this;
switch (_that) {
case RecipesStateInitial():
return initial(_that);case RecipesStateLoading():
return loading(_that);case RecipesStateLoaded():
return loaded(_that);case RecipesStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecipesStateInitial value)?  initial,TResult? Function( RecipesStateLoading value)?  loading,TResult? Function( RecipesStateLoaded value)?  loaded,TResult? Function( RecipesStateError value)?  error,}){
final _that = this;
switch (_that) {
case RecipesStateInitial() when initial != null:
return initial(_that);case RecipesStateLoading() when loading != null:
return loading(_that);case RecipesStateLoaded() when loaded != null:
return loaded(_that);case RecipesStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RecipeModel> recipes)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecipesStateInitial() when initial != null:
return initial();case RecipesStateLoading() when loading != null:
return loading();case RecipesStateLoaded() when loaded != null:
return loaded(_that.recipes);case RecipesStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RecipeModel> recipes)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case RecipesStateInitial():
return initial();case RecipesStateLoading():
return loading();case RecipesStateLoaded():
return loaded(_that.recipes);case RecipesStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RecipeModel> recipes)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case RecipesStateInitial() when initial != null:
return initial();case RecipesStateLoading() when loading != null:
return loading();case RecipesStateLoaded() when loaded != null:
return loaded(_that.recipes);case RecipesStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RecipesStateInitial implements RecipesState {
  const RecipesStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipesStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipesState.initial()';
}


}




/// @nodoc


class RecipesStateLoading implements RecipesState {
  const RecipesStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipesStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipesState.loading()';
}


}




/// @nodoc


class RecipesStateLoaded implements RecipesState {
  const RecipesStateLoaded(final  List<RecipeModel> recipes): _recipes = recipes;
  

 final  List<RecipeModel> _recipes;
 List<RecipeModel> get recipes {
  if (_recipes is EqualUnmodifiableListView) return _recipes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipes);
}


/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipesStateLoadedCopyWith<RecipesStateLoaded> get copyWith => _$RecipesStateLoadedCopyWithImpl<RecipesStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipesStateLoaded&&const DeepCollectionEquality().equals(other._recipes, _recipes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recipes));

@override
String toString() {
  return 'RecipesState.loaded(recipes: $recipes)';
}


}

/// @nodoc
abstract mixin class $RecipesStateLoadedCopyWith<$Res> implements $RecipesStateCopyWith<$Res> {
  factory $RecipesStateLoadedCopyWith(RecipesStateLoaded value, $Res Function(RecipesStateLoaded) _then) = _$RecipesStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<RecipeModel> recipes
});




}
/// @nodoc
class _$RecipesStateLoadedCopyWithImpl<$Res>
    implements $RecipesStateLoadedCopyWith<$Res> {
  _$RecipesStateLoadedCopyWithImpl(this._self, this._then);

  final RecipesStateLoaded _self;
  final $Res Function(RecipesStateLoaded) _then;

/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recipes = null,}) {
  return _then(RecipesStateLoaded(
null == recipes ? _self._recipes : recipes // ignore: cast_nullable_to_non_nullable
as List<RecipeModel>,
  ));
}


}

/// @nodoc


class RecipesStateError implements RecipesState {
  const RecipesStateError(this.message);
  

 final  String message;

/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipesStateErrorCopyWith<RecipesStateError> get copyWith => _$RecipesStateErrorCopyWithImpl<RecipesStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipesStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecipesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RecipesStateErrorCopyWith<$Res> implements $RecipesStateCopyWith<$Res> {
  factory $RecipesStateErrorCopyWith(RecipesStateError value, $Res Function(RecipesStateError) _then) = _$RecipesStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RecipesStateErrorCopyWithImpl<$Res>
    implements $RecipesStateErrorCopyWith<$Res> {
  _$RecipesStateErrorCopyWithImpl(this._self, this._then);

  final RecipesStateError _self;
  final $Res Function(RecipesStateError) _then;

/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RecipesStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RecipeDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipeDetailState()';
}


}

/// @nodoc
class $RecipeDetailStateCopyWith<$Res>  {
$RecipeDetailStateCopyWith(RecipeDetailState _, $Res Function(RecipeDetailState) __);
}


/// Adds pattern-matching-related methods to [RecipeDetailState].
extension RecipeDetailStatePatterns on RecipeDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecipeDetailStateInitial value)?  initial,TResult Function( RecipeDetailStateLoading value)?  loading,TResult Function( RecipeDetailStateLoaded value)?  loaded,TResult Function( RecipeDetailStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecipeDetailStateInitial() when initial != null:
return initial(_that);case RecipeDetailStateLoading() when loading != null:
return loading(_that);case RecipeDetailStateLoaded() when loaded != null:
return loaded(_that);case RecipeDetailStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecipeDetailStateInitial value)  initial,required TResult Function( RecipeDetailStateLoading value)  loading,required TResult Function( RecipeDetailStateLoaded value)  loaded,required TResult Function( RecipeDetailStateError value)  error,}){
final _that = this;
switch (_that) {
case RecipeDetailStateInitial():
return initial(_that);case RecipeDetailStateLoading():
return loading(_that);case RecipeDetailStateLoaded():
return loaded(_that);case RecipeDetailStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecipeDetailStateInitial value)?  initial,TResult? Function( RecipeDetailStateLoading value)?  loading,TResult? Function( RecipeDetailStateLoaded value)?  loaded,TResult? Function( RecipeDetailStateError value)?  error,}){
final _that = this;
switch (_that) {
case RecipeDetailStateInitial() when initial != null:
return initial(_that);case RecipeDetailStateLoading() when loading != null:
return loading(_that);case RecipeDetailStateLoaded() when loaded != null:
return loaded(_that);case RecipeDetailStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( RecipeModel recipe)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecipeDetailStateInitial() when initial != null:
return initial();case RecipeDetailStateLoading() when loading != null:
return loading();case RecipeDetailStateLoaded() when loaded != null:
return loaded(_that.recipe);case RecipeDetailStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( RecipeModel recipe)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case RecipeDetailStateInitial():
return initial();case RecipeDetailStateLoading():
return loading();case RecipeDetailStateLoaded():
return loaded(_that.recipe);case RecipeDetailStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( RecipeModel recipe)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case RecipeDetailStateInitial() when initial != null:
return initial();case RecipeDetailStateLoading() when loading != null:
return loading();case RecipeDetailStateLoaded() when loaded != null:
return loaded(_that.recipe);case RecipeDetailStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RecipeDetailStateInitial implements RecipeDetailState {
  const RecipeDetailStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeDetailStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipeDetailState.initial()';
}


}




/// @nodoc


class RecipeDetailStateLoading implements RecipeDetailState {
  const RecipeDetailStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeDetailStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipeDetailState.loading()';
}


}




/// @nodoc


class RecipeDetailStateLoaded implements RecipeDetailState {
  const RecipeDetailStateLoaded(this.recipe);
  

 final  RecipeModel recipe;

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeDetailStateLoadedCopyWith<RecipeDetailStateLoaded> get copyWith => _$RecipeDetailStateLoadedCopyWithImpl<RecipeDetailStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeDetailStateLoaded&&(identical(other.recipe, recipe) || other.recipe == recipe));
}


@override
int get hashCode => Object.hash(runtimeType,recipe);

@override
String toString() {
  return 'RecipeDetailState.loaded(recipe: $recipe)';
}


}

/// @nodoc
abstract mixin class $RecipeDetailStateLoadedCopyWith<$Res> implements $RecipeDetailStateCopyWith<$Res> {
  factory $RecipeDetailStateLoadedCopyWith(RecipeDetailStateLoaded value, $Res Function(RecipeDetailStateLoaded) _then) = _$RecipeDetailStateLoadedCopyWithImpl;
@useResult
$Res call({
 RecipeModel recipe
});


$RecipeModelCopyWith<$Res> get recipe;

}
/// @nodoc
class _$RecipeDetailStateLoadedCopyWithImpl<$Res>
    implements $RecipeDetailStateLoadedCopyWith<$Res> {
  _$RecipeDetailStateLoadedCopyWithImpl(this._self, this._then);

  final RecipeDetailStateLoaded _self;
  final $Res Function(RecipeDetailStateLoaded) _then;

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recipe = null,}) {
  return _then(RecipeDetailStateLoaded(
null == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as RecipeModel,
  ));
}

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeModelCopyWith<$Res> get recipe {
  
  return $RecipeModelCopyWith<$Res>(_self.recipe, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}
}

/// @nodoc


class RecipeDetailStateError implements RecipeDetailState {
  const RecipeDetailStateError(this.message);
  

 final  String message;

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeDetailStateErrorCopyWith<RecipeDetailStateError> get copyWith => _$RecipeDetailStateErrorCopyWithImpl<RecipeDetailStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeDetailStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecipeDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RecipeDetailStateErrorCopyWith<$Res> implements $RecipeDetailStateCopyWith<$Res> {
  factory $RecipeDetailStateErrorCopyWith(RecipeDetailStateError value, $Res Function(RecipeDetailStateError) _then) = _$RecipeDetailStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RecipeDetailStateErrorCopyWithImpl<$Res>
    implements $RecipeDetailStateErrorCopyWith<$Res> {
  _$RecipeDetailStateErrorCopyWithImpl(this._self, this._then);

  final RecipeDetailStateError _self;
  final $Res Function(RecipeDetailStateError) _then;

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RecipeDetailStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SeasonalVegetablesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonalVegetablesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeasonalVegetablesState()';
}


}

/// @nodoc
class $SeasonalVegetablesStateCopyWith<$Res>  {
$SeasonalVegetablesStateCopyWith(SeasonalVegetablesState _, $Res Function(SeasonalVegetablesState) __);
}


/// Adds pattern-matching-related methods to [SeasonalVegetablesState].
extension SeasonalVegetablesStatePatterns on SeasonalVegetablesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SeasonalVegetablesStateInitial value)?  initial,TResult Function( SeasonalVegetablesStateLoading value)?  loading,TResult Function( SeasonalVegetablesStateLoaded value)?  loaded,TResult Function( SeasonalVegetablesStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SeasonalVegetablesStateInitial() when initial != null:
return initial(_that);case SeasonalVegetablesStateLoading() when loading != null:
return loading(_that);case SeasonalVegetablesStateLoaded() when loaded != null:
return loaded(_that);case SeasonalVegetablesStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SeasonalVegetablesStateInitial value)  initial,required TResult Function( SeasonalVegetablesStateLoading value)  loading,required TResult Function( SeasonalVegetablesStateLoaded value)  loaded,required TResult Function( SeasonalVegetablesStateError value)  error,}){
final _that = this;
switch (_that) {
case SeasonalVegetablesStateInitial():
return initial(_that);case SeasonalVegetablesStateLoading():
return loading(_that);case SeasonalVegetablesStateLoaded():
return loaded(_that);case SeasonalVegetablesStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SeasonalVegetablesStateInitial value)?  initial,TResult? Function( SeasonalVegetablesStateLoading value)?  loading,TResult? Function( SeasonalVegetablesStateLoaded value)?  loaded,TResult? Function( SeasonalVegetablesStateError value)?  error,}){
final _that = this;
switch (_that) {
case SeasonalVegetablesStateInitial() when initial != null:
return initial(_that);case SeasonalVegetablesStateLoading() when loading != null:
return loading(_that);case SeasonalVegetablesStateLoaded() when loaded != null:
return loaded(_that);case SeasonalVegetablesStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<SeasonalVegetableModel> vegetables)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SeasonalVegetablesStateInitial() when initial != null:
return initial();case SeasonalVegetablesStateLoading() when loading != null:
return loading();case SeasonalVegetablesStateLoaded() when loaded != null:
return loaded(_that.vegetables);case SeasonalVegetablesStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<SeasonalVegetableModel> vegetables)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SeasonalVegetablesStateInitial():
return initial();case SeasonalVegetablesStateLoading():
return loading();case SeasonalVegetablesStateLoaded():
return loaded(_that.vegetables);case SeasonalVegetablesStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<SeasonalVegetableModel> vegetables)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SeasonalVegetablesStateInitial() when initial != null:
return initial();case SeasonalVegetablesStateLoading() when loading != null:
return loading();case SeasonalVegetablesStateLoaded() when loaded != null:
return loaded(_that.vegetables);case SeasonalVegetablesStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SeasonalVegetablesStateInitial implements SeasonalVegetablesState {
  const SeasonalVegetablesStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonalVegetablesStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeasonalVegetablesState.initial()';
}


}




/// @nodoc


class SeasonalVegetablesStateLoading implements SeasonalVegetablesState {
  const SeasonalVegetablesStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonalVegetablesStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeasonalVegetablesState.loading()';
}


}




/// @nodoc


class SeasonalVegetablesStateLoaded implements SeasonalVegetablesState {
  const SeasonalVegetablesStateLoaded(final  List<SeasonalVegetableModel> vegetables): _vegetables = vegetables;
  

 final  List<SeasonalVegetableModel> _vegetables;
 List<SeasonalVegetableModel> get vegetables {
  if (_vegetables is EqualUnmodifiableListView) return _vegetables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vegetables);
}


/// Create a copy of SeasonalVegetablesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonalVegetablesStateLoadedCopyWith<SeasonalVegetablesStateLoaded> get copyWith => _$SeasonalVegetablesStateLoadedCopyWithImpl<SeasonalVegetablesStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonalVegetablesStateLoaded&&const DeepCollectionEquality().equals(other._vegetables, _vegetables));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vegetables));

@override
String toString() {
  return 'SeasonalVegetablesState.loaded(vegetables: $vegetables)';
}


}

/// @nodoc
abstract mixin class $SeasonalVegetablesStateLoadedCopyWith<$Res> implements $SeasonalVegetablesStateCopyWith<$Res> {
  factory $SeasonalVegetablesStateLoadedCopyWith(SeasonalVegetablesStateLoaded value, $Res Function(SeasonalVegetablesStateLoaded) _then) = _$SeasonalVegetablesStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<SeasonalVegetableModel> vegetables
});




}
/// @nodoc
class _$SeasonalVegetablesStateLoadedCopyWithImpl<$Res>
    implements $SeasonalVegetablesStateLoadedCopyWith<$Res> {
  _$SeasonalVegetablesStateLoadedCopyWithImpl(this._self, this._then);

  final SeasonalVegetablesStateLoaded _self;
  final $Res Function(SeasonalVegetablesStateLoaded) _then;

/// Create a copy of SeasonalVegetablesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vegetables = null,}) {
  return _then(SeasonalVegetablesStateLoaded(
null == vegetables ? _self._vegetables : vegetables // ignore: cast_nullable_to_non_nullable
as List<SeasonalVegetableModel>,
  ));
}


}

/// @nodoc


class SeasonalVegetablesStateError implements SeasonalVegetablesState {
  const SeasonalVegetablesStateError(this.message);
  

 final  String message;

/// Create a copy of SeasonalVegetablesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonalVegetablesStateErrorCopyWith<SeasonalVegetablesStateError> get copyWith => _$SeasonalVegetablesStateErrorCopyWithImpl<SeasonalVegetablesStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonalVegetablesStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeasonalVegetablesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SeasonalVegetablesStateErrorCopyWith<$Res> implements $SeasonalVegetablesStateCopyWith<$Res> {
  factory $SeasonalVegetablesStateErrorCopyWith(SeasonalVegetablesStateError value, $Res Function(SeasonalVegetablesStateError) _then) = _$SeasonalVegetablesStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SeasonalVegetablesStateErrorCopyWithImpl<$Res>
    implements $SeasonalVegetablesStateErrorCopyWith<$Res> {
  _$SeasonalVegetablesStateErrorCopyWithImpl(this._self, this._then);

  final SeasonalVegetablesStateError _self;
  final $Res Function(SeasonalVegetablesStateError) _then;

/// Create a copy of SeasonalVegetablesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SeasonalVegetablesStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
