// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MenuPlanModel {

 String get id; String get householdId; String? get name; List<MenuItemModel>? get items; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of MenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuPlanModelCopyWith<MenuPlanModel> get copyWith => _$MenuPlanModelCopyWithImpl<MenuPlanModel>(this as MenuPlanModel, _$identity);

  /// Serializes this MenuPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,name,const DeepCollectionEquality().hash(items),createdAt,updatedAt);

@override
String toString() {
  return 'MenuPlanModel(id: $id, householdId: $householdId, name: $name, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MenuPlanModelCopyWith<$Res>  {
  factory $MenuPlanModelCopyWith(MenuPlanModel value, $Res Function(MenuPlanModel) _then) = _$MenuPlanModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String? name, List<MenuItemModel>? items, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$MenuPlanModelCopyWithImpl<$Res>
    implements $MenuPlanModelCopyWith<$Res> {
  _$MenuPlanModelCopyWithImpl(this._self, this._then);

  final MenuPlanModel _self;
  final $Res Function(MenuPlanModel) _then;

/// Create a copy of MenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? name = freezed,Object? items = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItemModel>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuPlanModel].
extension MenuPlanModelPatterns on MenuPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _MenuPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _MenuPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String? name,  List<MenuItemModel>? items,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuPlanModel() when $default != null:
return $default(_that.id,_that.householdId,_that.name,_that.items,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String? name,  List<MenuItemModel>? items,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MenuPlanModel():
return $default(_that.id,_that.householdId,_that.name,_that.items,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String? name,  List<MenuItemModel>? items,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MenuPlanModel() when $default != null:
return $default(_that.id,_that.householdId,_that.name,_that.items,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuPlanModel implements MenuPlanModel {
  const _MenuPlanModel({required this.id, required this.householdId, this.name, final  List<MenuItemModel>? items, this.createdAt, this.updatedAt}): _items = items;
  factory _MenuPlanModel.fromJson(Map<String, dynamic> json) => _$MenuPlanModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String? name;
 final  List<MenuItemModel>? _items;
@override List<MenuItemModel>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of MenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuPlanModelCopyWith<_MenuPlanModel> get copyWith => __$MenuPlanModelCopyWithImpl<_MenuPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,name,const DeepCollectionEquality().hash(_items),createdAt,updatedAt);

@override
String toString() {
  return 'MenuPlanModel(id: $id, householdId: $householdId, name: $name, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MenuPlanModelCopyWith<$Res> implements $MenuPlanModelCopyWith<$Res> {
  factory _$MenuPlanModelCopyWith(_MenuPlanModel value, $Res Function(_MenuPlanModel) _then) = __$MenuPlanModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String? name, List<MenuItemModel>? items, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$MenuPlanModelCopyWithImpl<$Res>
    implements _$MenuPlanModelCopyWith<$Res> {
  __$MenuPlanModelCopyWithImpl(this._self, this._then);

  final _MenuPlanModel _self;
  final $Res Function(_MenuPlanModel) _then;

/// Create a copy of MenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? name = freezed,Object? items = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_MenuPlanModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItemModel>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$MenuItemModel {

 String get id; DateTime get date; String get mealType;// 'breakfast' | 'lunch' | 'dinner' | 'snack'
 RecipeModel? get recipe; String? get recipeId; Map<String, dynamic>? get substitutions; bool get isLeftover; String? get originalMenuItemId; MenuItemCreatorModel? get createdBy; DateTime? get createdAt;
/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuItemModelCopyWith<MenuItemModel> get copyWith => _$MenuItemModelCopyWithImpl<MenuItemModel>(this as MenuItemModel, _$identity);

  /// Serializes this MenuItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&const DeepCollectionEquality().equals(other.substitutions, substitutions)&&(identical(other.isLeftover, isLeftover) || other.isLeftover == isLeftover)&&(identical(other.originalMenuItemId, originalMenuItemId) || other.originalMenuItemId == originalMenuItemId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,mealType,recipe,recipeId,const DeepCollectionEquality().hash(substitutions),isLeftover,originalMenuItemId,createdBy,createdAt);

@override
String toString() {
  return 'MenuItemModel(id: $id, date: $date, mealType: $mealType, recipe: $recipe, recipeId: $recipeId, substitutions: $substitutions, isLeftover: $isLeftover, originalMenuItemId: $originalMenuItemId, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MenuItemModelCopyWith<$Res>  {
  factory $MenuItemModelCopyWith(MenuItemModel value, $Res Function(MenuItemModel) _then) = _$MenuItemModelCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String mealType, RecipeModel? recipe, String? recipeId, Map<String, dynamic>? substitutions, bool isLeftover, String? originalMenuItemId, MenuItemCreatorModel? createdBy, DateTime? createdAt
});


$RecipeModelCopyWith<$Res>? get recipe;$MenuItemCreatorModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class _$MenuItemModelCopyWithImpl<$Res>
    implements $MenuItemModelCopyWith<$Res> {
  _$MenuItemModelCopyWithImpl(this._self, this._then);

  final MenuItemModel _self;
  final $Res Function(MenuItemModel) _then;

/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? mealType = null,Object? recipe = freezed,Object? recipeId = freezed,Object? substitutions = freezed,Object? isLeftover = null,Object? originalMenuItemId = freezed,Object? createdBy = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as String,recipe: freezed == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as RecipeModel?,recipeId: freezed == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String?,substitutions: freezed == substitutions ? _self.substitutions : substitutions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isLeftover: null == isLeftover ? _self.isLeftover : isLeftover // ignore: cast_nullable_to_non_nullable
as bool,originalMenuItemId: freezed == originalMenuItemId ? _self.originalMenuItemId : originalMenuItemId // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as MenuItemCreatorModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeModelCopyWith<$Res>? get recipe {
    if (_self.recipe == null) {
    return null;
  }

  return $RecipeModelCopyWith<$Res>(_self.recipe!, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MenuItemCreatorModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $MenuItemCreatorModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [MenuItemModel].
extension MenuItemModelPatterns on MenuItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuItemModel value)  $default,){
final _that = this;
switch (_that) {
case _MenuItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  String mealType,  RecipeModel? recipe,  String? recipeId,  Map<String, dynamic>? substitutions,  bool isLeftover,  String? originalMenuItemId,  MenuItemCreatorModel? createdBy,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
return $default(_that.id,_that.date,_that.mealType,_that.recipe,_that.recipeId,_that.substitutions,_that.isLeftover,_that.originalMenuItemId,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  String mealType,  RecipeModel? recipe,  String? recipeId,  Map<String, dynamic>? substitutions,  bool isLeftover,  String? originalMenuItemId,  MenuItemCreatorModel? createdBy,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MenuItemModel():
return $default(_that.id,_that.date,_that.mealType,_that.recipe,_that.recipeId,_that.substitutions,_that.isLeftover,_that.originalMenuItemId,_that.createdBy,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  String mealType,  RecipeModel? recipe,  String? recipeId,  Map<String, dynamic>? substitutions,  bool isLeftover,  String? originalMenuItemId,  MenuItemCreatorModel? createdBy,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MenuItemModel() when $default != null:
return $default(_that.id,_that.date,_that.mealType,_that.recipe,_that.recipeId,_that.substitutions,_that.isLeftover,_that.originalMenuItemId,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuItemModel implements MenuItemModel {
  const _MenuItemModel({required this.id, required this.date, required this.mealType, this.recipe, this.recipeId, final  Map<String, dynamic>? substitutions, this.isLeftover = false, this.originalMenuItemId, this.createdBy, this.createdAt}): _substitutions = substitutions;
  factory _MenuItemModel.fromJson(Map<String, dynamic> json) => _$MenuItemModelFromJson(json);

@override final  String id;
@override final  DateTime date;
@override final  String mealType;
// 'breakfast' | 'lunch' | 'dinner' | 'snack'
@override final  RecipeModel? recipe;
@override final  String? recipeId;
 final  Map<String, dynamic>? _substitutions;
@override Map<String, dynamic>? get substitutions {
  final value = _substitutions;
  if (value == null) return null;
  if (_substitutions is EqualUnmodifiableMapView) return _substitutions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  bool isLeftover;
@override final  String? originalMenuItemId;
@override final  MenuItemCreatorModel? createdBy;
@override final  DateTime? createdAt;

/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuItemModelCopyWith<_MenuItemModel> get copyWith => __$MenuItemModelCopyWithImpl<_MenuItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&const DeepCollectionEquality().equals(other._substitutions, _substitutions)&&(identical(other.isLeftover, isLeftover) || other.isLeftover == isLeftover)&&(identical(other.originalMenuItemId, originalMenuItemId) || other.originalMenuItemId == originalMenuItemId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,mealType,recipe,recipeId,const DeepCollectionEquality().hash(_substitutions),isLeftover,originalMenuItemId,createdBy,createdAt);

@override
String toString() {
  return 'MenuItemModel(id: $id, date: $date, mealType: $mealType, recipe: $recipe, recipeId: $recipeId, substitutions: $substitutions, isLeftover: $isLeftover, originalMenuItemId: $originalMenuItemId, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MenuItemModelCopyWith<$Res> implements $MenuItemModelCopyWith<$Res> {
  factory _$MenuItemModelCopyWith(_MenuItemModel value, $Res Function(_MenuItemModel) _then) = __$MenuItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String mealType, RecipeModel? recipe, String? recipeId, Map<String, dynamic>? substitutions, bool isLeftover, String? originalMenuItemId, MenuItemCreatorModel? createdBy, DateTime? createdAt
});


@override $RecipeModelCopyWith<$Res>? get recipe;@override $MenuItemCreatorModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class __$MenuItemModelCopyWithImpl<$Res>
    implements _$MenuItemModelCopyWith<$Res> {
  __$MenuItemModelCopyWithImpl(this._self, this._then);

  final _MenuItemModel _self;
  final $Res Function(_MenuItemModel) _then;

/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? mealType = null,Object? recipe = freezed,Object? recipeId = freezed,Object? substitutions = freezed,Object? isLeftover = null,Object? originalMenuItemId = freezed,Object? createdBy = freezed,Object? createdAt = freezed,}) {
  return _then(_MenuItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as String,recipe: freezed == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as RecipeModel?,recipeId: freezed == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String?,substitutions: freezed == substitutions ? _self._substitutions : substitutions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isLeftover: null == isLeftover ? _self.isLeftover : isLeftover // ignore: cast_nullable_to_non_nullable
as bool,originalMenuItemId: freezed == originalMenuItemId ? _self.originalMenuItemId : originalMenuItemId // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as MenuItemCreatorModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeModelCopyWith<$Res>? get recipe {
    if (_self.recipe == null) {
    return null;
  }

  return $RecipeModelCopyWith<$Res>(_self.recipe!, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}/// Create a copy of MenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MenuItemCreatorModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $MenuItemCreatorModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// @nodoc
mixin _$MenuItemCreatorModel {

 String get id; String get name; String? get avatarUrl;
/// Create a copy of MenuItemCreatorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuItemCreatorModelCopyWith<MenuItemCreatorModel> get copyWith => _$MenuItemCreatorModelCopyWithImpl<MenuItemCreatorModel>(this as MenuItemCreatorModel, _$identity);

  /// Serializes this MenuItemCreatorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuItemCreatorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'MenuItemCreatorModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $MenuItemCreatorModelCopyWith<$Res>  {
  factory $MenuItemCreatorModelCopyWith(MenuItemCreatorModel value, $Res Function(MenuItemCreatorModel) _then) = _$MenuItemCreatorModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class _$MenuItemCreatorModelCopyWithImpl<$Res>
    implements $MenuItemCreatorModelCopyWith<$Res> {
  _$MenuItemCreatorModelCopyWithImpl(this._self, this._then);

  final MenuItemCreatorModel _self;
  final $Res Function(MenuItemCreatorModel) _then;

/// Create a copy of MenuItemCreatorModel
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


/// Adds pattern-matching-related methods to [MenuItemCreatorModel].
extension MenuItemCreatorModelPatterns on MenuItemCreatorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuItemCreatorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuItemCreatorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuItemCreatorModel value)  $default,){
final _that = this;
switch (_that) {
case _MenuItemCreatorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuItemCreatorModel value)?  $default,){
final _that = this;
switch (_that) {
case _MenuItemCreatorModel() when $default != null:
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
case _MenuItemCreatorModel() when $default != null:
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
case _MenuItemCreatorModel():
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
case _MenuItemCreatorModel() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuItemCreatorModel implements MenuItemCreatorModel {
  const _MenuItemCreatorModel({required this.id, required this.name, this.avatarUrl});
  factory _MenuItemCreatorModel.fromJson(Map<String, dynamic> json) => _$MenuItemCreatorModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of MenuItemCreatorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuItemCreatorModelCopyWith<_MenuItemCreatorModel> get copyWith => __$MenuItemCreatorModelCopyWithImpl<_MenuItemCreatorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuItemCreatorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuItemCreatorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'MenuItemCreatorModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$MenuItemCreatorModelCopyWith<$Res> implements $MenuItemCreatorModelCopyWith<$Res> {
  factory _$MenuItemCreatorModelCopyWith(_MenuItemCreatorModel value, $Res Function(_MenuItemCreatorModel) _then) = __$MenuItemCreatorModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class __$MenuItemCreatorModelCopyWithImpl<$Res>
    implements _$MenuItemCreatorModelCopyWith<$Res> {
  __$MenuItemCreatorModelCopyWithImpl(this._self, this._then);

  final _MenuItemCreatorModel _self;
  final $Res Function(_MenuItemCreatorModel) _then;

/// Create a copy of MenuItemCreatorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_MenuItemCreatorModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ShoppingListResultModel {

 String get menuPlanId; String? get menuName; double get servingsMultiplier; int get itemsCreated; List<ShoppingItemModel>? get shoppingList;
/// Create a copy of ShoppingListResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingListResultModelCopyWith<ShoppingListResultModel> get copyWith => _$ShoppingListResultModelCopyWithImpl<ShoppingListResultModel>(this as ShoppingListResultModel, _$identity);

  /// Serializes this ShoppingListResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingListResultModel&&(identical(other.menuPlanId, menuPlanId) || other.menuPlanId == menuPlanId)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.servingsMultiplier, servingsMultiplier) || other.servingsMultiplier == servingsMultiplier)&&(identical(other.itemsCreated, itemsCreated) || other.itemsCreated == itemsCreated)&&const DeepCollectionEquality().equals(other.shoppingList, shoppingList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuPlanId,menuName,servingsMultiplier,itemsCreated,const DeepCollectionEquality().hash(shoppingList));

@override
String toString() {
  return 'ShoppingListResultModel(menuPlanId: $menuPlanId, menuName: $menuName, servingsMultiplier: $servingsMultiplier, itemsCreated: $itemsCreated, shoppingList: $shoppingList)';
}


}

/// @nodoc
abstract mixin class $ShoppingListResultModelCopyWith<$Res>  {
  factory $ShoppingListResultModelCopyWith(ShoppingListResultModel value, $Res Function(ShoppingListResultModel) _then) = _$ShoppingListResultModelCopyWithImpl;
@useResult
$Res call({
 String menuPlanId, String? menuName, double servingsMultiplier, int itemsCreated, List<ShoppingItemModel>? shoppingList
});




}
/// @nodoc
class _$ShoppingListResultModelCopyWithImpl<$Res>
    implements $ShoppingListResultModelCopyWith<$Res> {
  _$ShoppingListResultModelCopyWithImpl(this._self, this._then);

  final ShoppingListResultModel _self;
  final $Res Function(ShoppingListResultModel) _then;

/// Create a copy of ShoppingListResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuPlanId = null,Object? menuName = freezed,Object? servingsMultiplier = null,Object? itemsCreated = null,Object? shoppingList = freezed,}) {
  return _then(_self.copyWith(
menuPlanId: null == menuPlanId ? _self.menuPlanId : menuPlanId // ignore: cast_nullable_to_non_nullable
as String,menuName: freezed == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String?,servingsMultiplier: null == servingsMultiplier ? _self.servingsMultiplier : servingsMultiplier // ignore: cast_nullable_to_non_nullable
as double,itemsCreated: null == itemsCreated ? _self.itemsCreated : itemsCreated // ignore: cast_nullable_to_non_nullable
as int,shoppingList: freezed == shoppingList ? _self.shoppingList : shoppingList // ignore: cast_nullable_to_non_nullable
as List<ShoppingItemModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShoppingListResultModel].
extension ShoppingListResultModelPatterns on ShoppingListResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShoppingListResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShoppingListResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShoppingListResultModel value)  $default,){
final _that = this;
switch (_that) {
case _ShoppingListResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShoppingListResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShoppingListResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String menuPlanId,  String? menuName,  double servingsMultiplier,  int itemsCreated,  List<ShoppingItemModel>? shoppingList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShoppingListResultModel() when $default != null:
return $default(_that.menuPlanId,_that.menuName,_that.servingsMultiplier,_that.itemsCreated,_that.shoppingList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String menuPlanId,  String? menuName,  double servingsMultiplier,  int itemsCreated,  List<ShoppingItemModel>? shoppingList)  $default,) {final _that = this;
switch (_that) {
case _ShoppingListResultModel():
return $default(_that.menuPlanId,_that.menuName,_that.servingsMultiplier,_that.itemsCreated,_that.shoppingList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String menuPlanId,  String? menuName,  double servingsMultiplier,  int itemsCreated,  List<ShoppingItemModel>? shoppingList)?  $default,) {final _that = this;
switch (_that) {
case _ShoppingListResultModel() when $default != null:
return $default(_that.menuPlanId,_that.menuName,_that.servingsMultiplier,_that.itemsCreated,_that.shoppingList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShoppingListResultModel implements ShoppingListResultModel {
  const _ShoppingListResultModel({required this.menuPlanId, this.menuName, required this.servingsMultiplier, required this.itemsCreated, final  List<ShoppingItemModel>? shoppingList}): _shoppingList = shoppingList;
  factory _ShoppingListResultModel.fromJson(Map<String, dynamic> json) => _$ShoppingListResultModelFromJson(json);

@override final  String menuPlanId;
@override final  String? menuName;
@override final  double servingsMultiplier;
@override final  int itemsCreated;
 final  List<ShoppingItemModel>? _shoppingList;
@override List<ShoppingItemModel>? get shoppingList {
  final value = _shoppingList;
  if (value == null) return null;
  if (_shoppingList is EqualUnmodifiableListView) return _shoppingList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ShoppingListResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShoppingListResultModelCopyWith<_ShoppingListResultModel> get copyWith => __$ShoppingListResultModelCopyWithImpl<_ShoppingListResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShoppingListResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShoppingListResultModel&&(identical(other.menuPlanId, menuPlanId) || other.menuPlanId == menuPlanId)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.servingsMultiplier, servingsMultiplier) || other.servingsMultiplier == servingsMultiplier)&&(identical(other.itemsCreated, itemsCreated) || other.itemsCreated == itemsCreated)&&const DeepCollectionEquality().equals(other._shoppingList, _shoppingList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuPlanId,menuName,servingsMultiplier,itemsCreated,const DeepCollectionEquality().hash(_shoppingList));

@override
String toString() {
  return 'ShoppingListResultModel(menuPlanId: $menuPlanId, menuName: $menuName, servingsMultiplier: $servingsMultiplier, itemsCreated: $itemsCreated, shoppingList: $shoppingList)';
}


}

/// @nodoc
abstract mixin class _$ShoppingListResultModelCopyWith<$Res> implements $ShoppingListResultModelCopyWith<$Res> {
  factory _$ShoppingListResultModelCopyWith(_ShoppingListResultModel value, $Res Function(_ShoppingListResultModel) _then) = __$ShoppingListResultModelCopyWithImpl;
@override @useResult
$Res call({
 String menuPlanId, String? menuName, double servingsMultiplier, int itemsCreated, List<ShoppingItemModel>? shoppingList
});




}
/// @nodoc
class __$ShoppingListResultModelCopyWithImpl<$Res>
    implements _$ShoppingListResultModelCopyWith<$Res> {
  __$ShoppingListResultModelCopyWithImpl(this._self, this._then);

  final _ShoppingListResultModel _self;
  final $Res Function(_ShoppingListResultModel) _then;

/// Create a copy of ShoppingListResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuPlanId = null,Object? menuName = freezed,Object? servingsMultiplier = null,Object? itemsCreated = null,Object? shoppingList = freezed,}) {
  return _then(_ShoppingListResultModel(
menuPlanId: null == menuPlanId ? _self.menuPlanId : menuPlanId // ignore: cast_nullable_to_non_nullable
as String,menuName: freezed == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String?,servingsMultiplier: null == servingsMultiplier ? _self.servingsMultiplier : servingsMultiplier // ignore: cast_nullable_to_non_nullable
as double,itemsCreated: null == itemsCreated ? _self.itemsCreated : itemsCreated // ignore: cast_nullable_to_non_nullable
as int,shoppingList: freezed == shoppingList ? _self._shoppingList : shoppingList // ignore: cast_nullable_to_non_nullable
as List<ShoppingItemModel>?,
  ));
}


}


/// @nodoc
mixin _$ShoppingItemModel {

 String get name; double? get quantity; String? get unit; String? get sourceRecipeId; String? get sourceRecipeName;
/// Create a copy of ShoppingItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingItemModelCopyWith<ShoppingItemModel> get copyWith => _$ShoppingItemModelCopyWithImpl<ShoppingItemModel>(this as ShoppingItemModel, _$identity);

  /// Serializes this ShoppingItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingItemModel&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.sourceRecipeId, sourceRecipeId) || other.sourceRecipeId == sourceRecipeId)&&(identical(other.sourceRecipeName, sourceRecipeName) || other.sourceRecipeName == sourceRecipeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,sourceRecipeId,sourceRecipeName);

@override
String toString() {
  return 'ShoppingItemModel(name: $name, quantity: $quantity, unit: $unit, sourceRecipeId: $sourceRecipeId, sourceRecipeName: $sourceRecipeName)';
}


}

/// @nodoc
abstract mixin class $ShoppingItemModelCopyWith<$Res>  {
  factory $ShoppingItemModelCopyWith(ShoppingItemModel value, $Res Function(ShoppingItemModel) _then) = _$ShoppingItemModelCopyWithImpl;
@useResult
$Res call({
 String name, double? quantity, String? unit, String? sourceRecipeId, String? sourceRecipeName
});




}
/// @nodoc
class _$ShoppingItemModelCopyWithImpl<$Res>
    implements $ShoppingItemModelCopyWith<$Res> {
  _$ShoppingItemModelCopyWithImpl(this._self, this._then);

  final ShoppingItemModel _self;
  final $Res Function(ShoppingItemModel) _then;

/// Create a copy of ShoppingItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = freezed,Object? unit = freezed,Object? sourceRecipeId = freezed,Object? sourceRecipeName = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,sourceRecipeId: freezed == sourceRecipeId ? _self.sourceRecipeId : sourceRecipeId // ignore: cast_nullable_to_non_nullable
as String?,sourceRecipeName: freezed == sourceRecipeName ? _self.sourceRecipeName : sourceRecipeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShoppingItemModel].
extension ShoppingItemModelPatterns on ShoppingItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShoppingItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShoppingItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShoppingItemModel value)  $default,){
final _that = this;
switch (_that) {
case _ShoppingItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShoppingItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShoppingItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double? quantity,  String? unit,  String? sourceRecipeId,  String? sourceRecipeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShoppingItemModel() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.sourceRecipeId,_that.sourceRecipeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double? quantity,  String? unit,  String? sourceRecipeId,  String? sourceRecipeName)  $default,) {final _that = this;
switch (_that) {
case _ShoppingItemModel():
return $default(_that.name,_that.quantity,_that.unit,_that.sourceRecipeId,_that.sourceRecipeName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double? quantity,  String? unit,  String? sourceRecipeId,  String? sourceRecipeName)?  $default,) {final _that = this;
switch (_that) {
case _ShoppingItemModel() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.sourceRecipeId,_that.sourceRecipeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShoppingItemModel implements ShoppingItemModel {
  const _ShoppingItemModel({required this.name, this.quantity, this.unit, this.sourceRecipeId, this.sourceRecipeName});
  factory _ShoppingItemModel.fromJson(Map<String, dynamic> json) => _$ShoppingItemModelFromJson(json);

@override final  String name;
@override final  double? quantity;
@override final  String? unit;
@override final  String? sourceRecipeId;
@override final  String? sourceRecipeName;

/// Create a copy of ShoppingItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShoppingItemModelCopyWith<_ShoppingItemModel> get copyWith => __$ShoppingItemModelCopyWithImpl<_ShoppingItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShoppingItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShoppingItemModel&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.sourceRecipeId, sourceRecipeId) || other.sourceRecipeId == sourceRecipeId)&&(identical(other.sourceRecipeName, sourceRecipeName) || other.sourceRecipeName == sourceRecipeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,sourceRecipeId,sourceRecipeName);

@override
String toString() {
  return 'ShoppingItemModel(name: $name, quantity: $quantity, unit: $unit, sourceRecipeId: $sourceRecipeId, sourceRecipeName: $sourceRecipeName)';
}


}

/// @nodoc
abstract mixin class _$ShoppingItemModelCopyWith<$Res> implements $ShoppingItemModelCopyWith<$Res> {
  factory _$ShoppingItemModelCopyWith(_ShoppingItemModel value, $Res Function(_ShoppingItemModel) _then) = __$ShoppingItemModelCopyWithImpl;
@override @useResult
$Res call({
 String name, double? quantity, String? unit, String? sourceRecipeId, String? sourceRecipeName
});




}
/// @nodoc
class __$ShoppingItemModelCopyWithImpl<$Res>
    implements _$ShoppingItemModelCopyWith<$Res> {
  __$ShoppingItemModelCopyWithImpl(this._self, this._then);

  final _ShoppingItemModel _self;
  final $Res Function(_ShoppingItemModel) _then;

/// Create a copy of ShoppingItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = freezed,Object? unit = freezed,Object? sourceRecipeId = freezed,Object? sourceRecipeName = freezed,}) {
  return _then(_ShoppingItemModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,sourceRecipeId: freezed == sourceRecipeId ? _self.sourceRecipeId : sourceRecipeId // ignore: cast_nullable_to_non_nullable
as String?,sourceRecipeName: freezed == sourceRecipeName ? _self.sourceRecipeName : sourceRecipeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpcomingMealsModel {

 List<MenuItemModel> get items; DateTime get from; DateTime get to;
/// Create a copy of UpcomingMealsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingMealsModelCopyWith<UpcomingMealsModel> get copyWith => _$UpcomingMealsModelCopyWithImpl<UpcomingMealsModel>(this as UpcomingMealsModel, _$identity);

  /// Serializes this UpcomingMealsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingMealsModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),from,to);

@override
String toString() {
  return 'UpcomingMealsModel(items: $items, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $UpcomingMealsModelCopyWith<$Res>  {
  factory $UpcomingMealsModelCopyWith(UpcomingMealsModel value, $Res Function(UpcomingMealsModel) _then) = _$UpcomingMealsModelCopyWithImpl;
@useResult
$Res call({
 List<MenuItemModel> items, DateTime from, DateTime to
});




}
/// @nodoc
class _$UpcomingMealsModelCopyWithImpl<$Res>
    implements $UpcomingMealsModelCopyWith<$Res> {
  _$UpcomingMealsModelCopyWithImpl(this._self, this._then);

  final UpcomingMealsModel _self;
  final $Res Function(UpcomingMealsModel) _then;

/// Create a copy of UpcomingMealsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItemModel>,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingMealsModel].
extension UpcomingMealsModelPatterns on UpcomingMealsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingMealsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingMealsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingMealsModel value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingMealsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingMealsModel value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingMealsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MenuItemModel> items,  DateTime from,  DateTime to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingMealsModel() when $default != null:
return $default(_that.items,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MenuItemModel> items,  DateTime from,  DateTime to)  $default,) {final _that = this;
switch (_that) {
case _UpcomingMealsModel():
return $default(_that.items,_that.from,_that.to);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MenuItemModel> items,  DateTime from,  DateTime to)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingMealsModel() when $default != null:
return $default(_that.items,_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpcomingMealsModel implements UpcomingMealsModel {
  const _UpcomingMealsModel({required final  List<MenuItemModel> items, required this.from, required this.to}): _items = items;
  factory _UpcomingMealsModel.fromJson(Map<String, dynamic> json) => _$UpcomingMealsModelFromJson(json);

 final  List<MenuItemModel> _items;
@override List<MenuItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  DateTime from;
@override final  DateTime to;

/// Create a copy of UpcomingMealsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingMealsModelCopyWith<_UpcomingMealsModel> get copyWith => __$UpcomingMealsModelCopyWithImpl<_UpcomingMealsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpcomingMealsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingMealsModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),from,to);

@override
String toString() {
  return 'UpcomingMealsModel(items: $items, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$UpcomingMealsModelCopyWith<$Res> implements $UpcomingMealsModelCopyWith<$Res> {
  factory _$UpcomingMealsModelCopyWith(_UpcomingMealsModel value, $Res Function(_UpcomingMealsModel) _then) = __$UpcomingMealsModelCopyWithImpl;
@override @useResult
$Res call({
 List<MenuItemModel> items, DateTime from, DateTime to
});




}
/// @nodoc
class __$UpcomingMealsModelCopyWithImpl<$Res>
    implements _$UpcomingMealsModelCopyWith<$Res> {
  __$UpcomingMealsModelCopyWithImpl(this._self, this._then);

  final _UpcomingMealsModel _self;
  final $Res Function(_UpcomingMealsModel) _then;

/// Create a copy of UpcomingMealsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? from = null,Object? to = null,}) {
  return _then(_UpcomingMealsModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MenuItemModel>,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$MealHistoryModel {

 String get recipeId; String get title; String? get imageUrl; int get timesCooked; DateTime get lastCooked; int get daysSinceLastCooked;
/// Create a copy of MealHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealHistoryModelCopyWith<MealHistoryModel> get copyWith => _$MealHistoryModelCopyWithImpl<MealHistoryModel>(this as MealHistoryModel, _$identity);

  /// Serializes this MealHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealHistoryModel&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.timesCooked, timesCooked) || other.timesCooked == timesCooked)&&(identical(other.lastCooked, lastCooked) || other.lastCooked == lastCooked)&&(identical(other.daysSinceLastCooked, daysSinceLastCooked) || other.daysSinceLastCooked == daysSinceLastCooked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipeId,title,imageUrl,timesCooked,lastCooked,daysSinceLastCooked);

@override
String toString() {
  return 'MealHistoryModel(recipeId: $recipeId, title: $title, imageUrl: $imageUrl, timesCooked: $timesCooked, lastCooked: $lastCooked, daysSinceLastCooked: $daysSinceLastCooked)';
}


}

/// @nodoc
abstract mixin class $MealHistoryModelCopyWith<$Res>  {
  factory $MealHistoryModelCopyWith(MealHistoryModel value, $Res Function(MealHistoryModel) _then) = _$MealHistoryModelCopyWithImpl;
@useResult
$Res call({
 String recipeId, String title, String? imageUrl, int timesCooked, DateTime lastCooked, int daysSinceLastCooked
});




}
/// @nodoc
class _$MealHistoryModelCopyWithImpl<$Res>
    implements $MealHistoryModelCopyWith<$Res> {
  _$MealHistoryModelCopyWithImpl(this._self, this._then);

  final MealHistoryModel _self;
  final $Res Function(MealHistoryModel) _then;

/// Create a copy of MealHistoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recipeId = null,Object? title = null,Object? imageUrl = freezed,Object? timesCooked = null,Object? lastCooked = null,Object? daysSinceLastCooked = null,}) {
  return _then(_self.copyWith(
recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,timesCooked: null == timesCooked ? _self.timesCooked : timesCooked // ignore: cast_nullable_to_non_nullable
as int,lastCooked: null == lastCooked ? _self.lastCooked : lastCooked // ignore: cast_nullable_to_non_nullable
as DateTime,daysSinceLastCooked: null == daysSinceLastCooked ? _self.daysSinceLastCooked : daysSinceLastCooked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MealHistoryModel].
extension MealHistoryModelPatterns on MealHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _MealHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _MealHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String recipeId,  String title,  String? imageUrl,  int timesCooked,  DateTime lastCooked,  int daysSinceLastCooked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealHistoryModel() when $default != null:
return $default(_that.recipeId,_that.title,_that.imageUrl,_that.timesCooked,_that.lastCooked,_that.daysSinceLastCooked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String recipeId,  String title,  String? imageUrl,  int timesCooked,  DateTime lastCooked,  int daysSinceLastCooked)  $default,) {final _that = this;
switch (_that) {
case _MealHistoryModel():
return $default(_that.recipeId,_that.title,_that.imageUrl,_that.timesCooked,_that.lastCooked,_that.daysSinceLastCooked);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String recipeId,  String title,  String? imageUrl,  int timesCooked,  DateTime lastCooked,  int daysSinceLastCooked)?  $default,) {final _that = this;
switch (_that) {
case _MealHistoryModel() when $default != null:
return $default(_that.recipeId,_that.title,_that.imageUrl,_that.timesCooked,_that.lastCooked,_that.daysSinceLastCooked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MealHistoryModel implements MealHistoryModel {
  const _MealHistoryModel({required this.recipeId, required this.title, this.imageUrl, required this.timesCooked, required this.lastCooked, required this.daysSinceLastCooked});
  factory _MealHistoryModel.fromJson(Map<String, dynamic> json) => _$MealHistoryModelFromJson(json);

@override final  String recipeId;
@override final  String title;
@override final  String? imageUrl;
@override final  int timesCooked;
@override final  DateTime lastCooked;
@override final  int daysSinceLastCooked;

/// Create a copy of MealHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealHistoryModelCopyWith<_MealHistoryModel> get copyWith => __$MealHistoryModelCopyWithImpl<_MealHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MealHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealHistoryModel&&(identical(other.recipeId, recipeId) || other.recipeId == recipeId)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.timesCooked, timesCooked) || other.timesCooked == timesCooked)&&(identical(other.lastCooked, lastCooked) || other.lastCooked == lastCooked)&&(identical(other.daysSinceLastCooked, daysSinceLastCooked) || other.daysSinceLastCooked == daysSinceLastCooked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipeId,title,imageUrl,timesCooked,lastCooked,daysSinceLastCooked);

@override
String toString() {
  return 'MealHistoryModel(recipeId: $recipeId, title: $title, imageUrl: $imageUrl, timesCooked: $timesCooked, lastCooked: $lastCooked, daysSinceLastCooked: $daysSinceLastCooked)';
}


}

/// @nodoc
abstract mixin class _$MealHistoryModelCopyWith<$Res> implements $MealHistoryModelCopyWith<$Res> {
  factory _$MealHistoryModelCopyWith(_MealHistoryModel value, $Res Function(_MealHistoryModel) _then) = __$MealHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 String recipeId, String title, String? imageUrl, int timesCooked, DateTime lastCooked, int daysSinceLastCooked
});




}
/// @nodoc
class __$MealHistoryModelCopyWithImpl<$Res>
    implements _$MealHistoryModelCopyWith<$Res> {
  __$MealHistoryModelCopyWithImpl(this._self, this._then);

  final _MealHistoryModel _self;
  final $Res Function(_MealHistoryModel) _then;

/// Create a copy of MealHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recipeId = null,Object? title = null,Object? imageUrl = freezed,Object? timesCooked = null,Object? lastCooked = null,Object? daysSinceLastCooked = null,}) {
  return _then(_MealHistoryModel(
recipeId: null == recipeId ? _self.recipeId : recipeId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,timesCooked: null == timesCooked ? _self.timesCooked : timesCooked // ignore: cast_nullable_to_non_nullable
as int,lastCooked: null == lastCooked ? _self.lastCooked : lastCooked // ignore: cast_nullable_to_non_nullable
as DateTime,daysSinceLastCooked: null == daysSinceLastCooked ? _self.daysSinceLastCooked : daysSinceLastCooked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
