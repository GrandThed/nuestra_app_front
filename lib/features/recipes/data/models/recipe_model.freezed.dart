// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeModel {

 String get id; String? get householdId; String get title; List<IngredientModel>? get ingredients; List<String>? get instructions; String? get imageUrl; int? get servings; String? get sourceUrl; RecipeCreatorModel? get createdBy; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeModelCopyWith<RecipeModel> get copyWith => _$RecipeModelCopyWithImpl<RecipeModel>(this as RecipeModel, _$identity);

  /// Serializes this RecipeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.ingredients, ingredients)&&const DeepCollectionEquality().equals(other.instructions, instructions)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.servings, servings) || other.servings == servings)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,title,const DeepCollectionEquality().hash(ingredients),const DeepCollectionEquality().hash(instructions),imageUrl,servings,sourceUrl,createdBy,createdAt,updatedAt);

@override
String toString() {
  return 'RecipeModel(id: $id, householdId: $householdId, title: $title, ingredients: $ingredients, instructions: $instructions, imageUrl: $imageUrl, servings: $servings, sourceUrl: $sourceUrl, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RecipeModelCopyWith<$Res>  {
  factory $RecipeModelCopyWith(RecipeModel value, $Res Function(RecipeModel) _then) = _$RecipeModelCopyWithImpl;
@useResult
$Res call({
 String id, String? householdId, String title, List<IngredientModel>? ingredients, List<String>? instructions, String? imageUrl, int? servings, String? sourceUrl, RecipeCreatorModel? createdBy, DateTime? createdAt, DateTime? updatedAt
});


$RecipeCreatorModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class _$RecipeModelCopyWithImpl<$Res>
    implements $RecipeModelCopyWith<$Res> {
  _$RecipeModelCopyWithImpl(this._self, this._then);

  final RecipeModel _self;
  final $Res Function(RecipeModel) _then;

/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = freezed,Object? title = null,Object? ingredients = freezed,Object? instructions = freezed,Object? imageUrl = freezed,Object? servings = freezed,Object? sourceUrl = freezed,Object? createdBy = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: freezed == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ingredients: freezed == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<IngredientModel>?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<String>?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,servings: freezed == servings ? _self.servings : servings // ignore: cast_nullable_to_non_nullable
as int?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as RecipeCreatorModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeCreatorModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $RecipeCreatorModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecipeModel].
extension RecipeModelPatterns on RecipeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeModel value)  $default,){
final _that = this;
switch (_that) {
case _RecipeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? householdId,  String title,  List<IngredientModel>? ingredients,  List<String>? instructions,  String? imageUrl,  int? servings,  String? sourceUrl,  RecipeCreatorModel? createdBy,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
return $default(_that.id,_that.householdId,_that.title,_that.ingredients,_that.instructions,_that.imageUrl,_that.servings,_that.sourceUrl,_that.createdBy,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? householdId,  String title,  List<IngredientModel>? ingredients,  List<String>? instructions,  String? imageUrl,  int? servings,  String? sourceUrl,  RecipeCreatorModel? createdBy,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RecipeModel():
return $default(_that.id,_that.householdId,_that.title,_that.ingredients,_that.instructions,_that.imageUrl,_that.servings,_that.sourceUrl,_that.createdBy,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? householdId,  String title,  List<IngredientModel>? ingredients,  List<String>? instructions,  String? imageUrl,  int? servings,  String? sourceUrl,  RecipeCreatorModel? createdBy,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
return $default(_that.id,_that.householdId,_that.title,_that.ingredients,_that.instructions,_that.imageUrl,_that.servings,_that.sourceUrl,_that.createdBy,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeModel implements RecipeModel {
  const _RecipeModel({required this.id, this.householdId, required this.title, final  List<IngredientModel>? ingredients, final  List<String>? instructions, this.imageUrl, this.servings, this.sourceUrl, this.createdBy, this.createdAt, this.updatedAt}): _ingredients = ingredients,_instructions = instructions;
  factory _RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);

@override final  String id;
@override final  String? householdId;
@override final  String title;
 final  List<IngredientModel>? _ingredients;
@override List<IngredientModel>? get ingredients {
  final value = _ingredients;
  if (value == null) return null;
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _instructions;
@override List<String>? get instructions {
  final value = _instructions;
  if (value == null) return null;
  if (_instructions is EqualUnmodifiableListView) return _instructions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? imageUrl;
@override final  int? servings;
@override final  String? sourceUrl;
@override final  RecipeCreatorModel? createdBy;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeModelCopyWith<_RecipeModel> get copyWith => __$RecipeModelCopyWithImpl<_RecipeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients)&&const DeepCollectionEquality().equals(other._instructions, _instructions)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.servings, servings) || other.servings == servings)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,title,const DeepCollectionEquality().hash(_ingredients),const DeepCollectionEquality().hash(_instructions),imageUrl,servings,sourceUrl,createdBy,createdAt,updatedAt);

@override
String toString() {
  return 'RecipeModel(id: $id, householdId: $householdId, title: $title, ingredients: $ingredients, instructions: $instructions, imageUrl: $imageUrl, servings: $servings, sourceUrl: $sourceUrl, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RecipeModelCopyWith<$Res> implements $RecipeModelCopyWith<$Res> {
  factory _$RecipeModelCopyWith(_RecipeModel value, $Res Function(_RecipeModel) _then) = __$RecipeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? householdId, String title, List<IngredientModel>? ingredients, List<String>? instructions, String? imageUrl, int? servings, String? sourceUrl, RecipeCreatorModel? createdBy, DateTime? createdAt, DateTime? updatedAt
});


@override $RecipeCreatorModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class __$RecipeModelCopyWithImpl<$Res>
    implements _$RecipeModelCopyWith<$Res> {
  __$RecipeModelCopyWithImpl(this._self, this._then);

  final _RecipeModel _self;
  final $Res Function(_RecipeModel) _then;

/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = freezed,Object? title = null,Object? ingredients = freezed,Object? instructions = freezed,Object? imageUrl = freezed,Object? servings = freezed,Object? sourceUrl = freezed,Object? createdBy = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_RecipeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: freezed == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ingredients: freezed == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<IngredientModel>?,instructions: freezed == instructions ? _self._instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<String>?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,servings: freezed == servings ? _self.servings : servings // ignore: cast_nullable_to_non_nullable
as int?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as RecipeCreatorModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeCreatorModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $RecipeCreatorModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// @nodoc
mixin _$IngredientModel {

 String get name; double? get quantity; String? get unit; List<IngredientModel>? get alternatives;
/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IngredientModelCopyWith<IngredientModel> get copyWith => _$IngredientModelCopyWithImpl<IngredientModel>(this as IngredientModel, _$identity);

  /// Serializes this IngredientModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IngredientModel&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&const DeepCollectionEquality().equals(other.alternatives, alternatives));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,const DeepCollectionEquality().hash(alternatives));

@override
String toString() {
  return 'IngredientModel(name: $name, quantity: $quantity, unit: $unit, alternatives: $alternatives)';
}


}

/// @nodoc
abstract mixin class $IngredientModelCopyWith<$Res>  {
  factory $IngredientModelCopyWith(IngredientModel value, $Res Function(IngredientModel) _then) = _$IngredientModelCopyWithImpl;
@useResult
$Res call({
 String name, double? quantity, String? unit, List<IngredientModel>? alternatives
});




}
/// @nodoc
class _$IngredientModelCopyWithImpl<$Res>
    implements $IngredientModelCopyWith<$Res> {
  _$IngredientModelCopyWithImpl(this._self, this._then);

  final IngredientModel _self;
  final $Res Function(IngredientModel) _then;

/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = freezed,Object? unit = freezed,Object? alternatives = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,alternatives: freezed == alternatives ? _self.alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<IngredientModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [IngredientModel].
extension IngredientModelPatterns on IngredientModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IngredientModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IngredientModel value)  $default,){
final _that = this;
switch (_that) {
case _IngredientModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IngredientModel value)?  $default,){
final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double? quantity,  String? unit,  List<IngredientModel>? alternatives)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.alternatives);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double? quantity,  String? unit,  List<IngredientModel>? alternatives)  $default,) {final _that = this;
switch (_that) {
case _IngredientModel():
return $default(_that.name,_that.quantity,_that.unit,_that.alternatives);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double? quantity,  String? unit,  List<IngredientModel>? alternatives)?  $default,) {final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.alternatives);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IngredientModel implements IngredientModel {
  const _IngredientModel({required this.name, this.quantity, this.unit, final  List<IngredientModel>? alternatives}): _alternatives = alternatives;
  factory _IngredientModel.fromJson(Map<String, dynamic> json) => _$IngredientModelFromJson(json);

@override final  String name;
@override final  double? quantity;
@override final  String? unit;
 final  List<IngredientModel>? _alternatives;
@override List<IngredientModel>? get alternatives {
  final value = _alternatives;
  if (value == null) return null;
  if (_alternatives is EqualUnmodifiableListView) return _alternatives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IngredientModelCopyWith<_IngredientModel> get copyWith => __$IngredientModelCopyWithImpl<_IngredientModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IngredientModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IngredientModel&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&const DeepCollectionEquality().equals(other._alternatives, _alternatives));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,const DeepCollectionEquality().hash(_alternatives));

@override
String toString() {
  return 'IngredientModel(name: $name, quantity: $quantity, unit: $unit, alternatives: $alternatives)';
}


}

/// @nodoc
abstract mixin class _$IngredientModelCopyWith<$Res> implements $IngredientModelCopyWith<$Res> {
  factory _$IngredientModelCopyWith(_IngredientModel value, $Res Function(_IngredientModel) _then) = __$IngredientModelCopyWithImpl;
@override @useResult
$Res call({
 String name, double? quantity, String? unit, List<IngredientModel>? alternatives
});




}
/// @nodoc
class __$IngredientModelCopyWithImpl<$Res>
    implements _$IngredientModelCopyWith<$Res> {
  __$IngredientModelCopyWithImpl(this._self, this._then);

  final _IngredientModel _self;
  final $Res Function(_IngredientModel) _then;

/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = freezed,Object? unit = freezed,Object? alternatives = freezed,}) {
  return _then(_IngredientModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,alternatives: freezed == alternatives ? _self._alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<IngredientModel>?,
  ));
}


}


/// @nodoc
mixin _$RecipeCreatorModel {

 String get id; String get name; String? get avatarUrl;
/// Create a copy of RecipeCreatorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeCreatorModelCopyWith<RecipeCreatorModel> get copyWith => _$RecipeCreatorModelCopyWithImpl<RecipeCreatorModel>(this as RecipeCreatorModel, _$identity);

  /// Serializes this RecipeCreatorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeCreatorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'RecipeCreatorModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $RecipeCreatorModelCopyWith<$Res>  {
  factory $RecipeCreatorModelCopyWith(RecipeCreatorModel value, $Res Function(RecipeCreatorModel) _then) = _$RecipeCreatorModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class _$RecipeCreatorModelCopyWithImpl<$Res>
    implements $RecipeCreatorModelCopyWith<$Res> {
  _$RecipeCreatorModelCopyWithImpl(this._self, this._then);

  final RecipeCreatorModel _self;
  final $Res Function(RecipeCreatorModel) _then;

/// Create a copy of RecipeCreatorModel
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


/// Adds pattern-matching-related methods to [RecipeCreatorModel].
extension RecipeCreatorModelPatterns on RecipeCreatorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeCreatorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeCreatorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeCreatorModel value)  $default,){
final _that = this;
switch (_that) {
case _RecipeCreatorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeCreatorModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeCreatorModel() when $default != null:
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
case _RecipeCreatorModel() when $default != null:
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
case _RecipeCreatorModel():
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
case _RecipeCreatorModel() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeCreatorModel implements RecipeCreatorModel {
  const _RecipeCreatorModel({required this.id, required this.name, this.avatarUrl});
  factory _RecipeCreatorModel.fromJson(Map<String, dynamic> json) => _$RecipeCreatorModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of RecipeCreatorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeCreatorModelCopyWith<_RecipeCreatorModel> get copyWith => __$RecipeCreatorModelCopyWithImpl<_RecipeCreatorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeCreatorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeCreatorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'RecipeCreatorModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$RecipeCreatorModelCopyWith<$Res> implements $RecipeCreatorModelCopyWith<$Res> {
  factory _$RecipeCreatorModelCopyWith(_RecipeCreatorModel value, $Res Function(_RecipeCreatorModel) _then) = __$RecipeCreatorModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class __$RecipeCreatorModelCopyWithImpl<$Res>
    implements _$RecipeCreatorModelCopyWith<$Res> {
  __$RecipeCreatorModelCopyWithImpl(this._self, this._then);

  final _RecipeCreatorModel _self;
  final $Res Function(_RecipeCreatorModel) _then;

/// Create a copy of RecipeCreatorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_RecipeCreatorModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SeasonalVegetableModel {

 String get id; String get name; int get startWeek; int get endWeek; bool get inSeason;
/// Create a copy of SeasonalVegetableModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonalVegetableModelCopyWith<SeasonalVegetableModel> get copyWith => _$SeasonalVegetableModelCopyWithImpl<SeasonalVegetableModel>(this as SeasonalVegetableModel, _$identity);

  /// Serializes this SeasonalVegetableModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonalVegetableModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startWeek, startWeek) || other.startWeek == startWeek)&&(identical(other.endWeek, endWeek) || other.endWeek == endWeek)&&(identical(other.inSeason, inSeason) || other.inSeason == inSeason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startWeek,endWeek,inSeason);

@override
String toString() {
  return 'SeasonalVegetableModel(id: $id, name: $name, startWeek: $startWeek, endWeek: $endWeek, inSeason: $inSeason)';
}


}

/// @nodoc
abstract mixin class $SeasonalVegetableModelCopyWith<$Res>  {
  factory $SeasonalVegetableModelCopyWith(SeasonalVegetableModel value, $Res Function(SeasonalVegetableModel) _then) = _$SeasonalVegetableModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, int startWeek, int endWeek, bool inSeason
});




}
/// @nodoc
class _$SeasonalVegetableModelCopyWithImpl<$Res>
    implements $SeasonalVegetableModelCopyWith<$Res> {
  _$SeasonalVegetableModelCopyWithImpl(this._self, this._then);

  final SeasonalVegetableModel _self;
  final $Res Function(SeasonalVegetableModel) _then;

/// Create a copy of SeasonalVegetableModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startWeek = null,Object? endWeek = null,Object? inSeason = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startWeek: null == startWeek ? _self.startWeek : startWeek // ignore: cast_nullable_to_non_nullable
as int,endWeek: null == endWeek ? _self.endWeek : endWeek // ignore: cast_nullable_to_non_nullable
as int,inSeason: null == inSeason ? _self.inSeason : inSeason // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonalVegetableModel].
extension SeasonalVegetableModelPatterns on SeasonalVegetableModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonalVegetableModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonalVegetableModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonalVegetableModel value)  $default,){
final _that = this;
switch (_that) {
case _SeasonalVegetableModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonalVegetableModel value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonalVegetableModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int startWeek,  int endWeek,  bool inSeason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonalVegetableModel() when $default != null:
return $default(_that.id,_that.name,_that.startWeek,_that.endWeek,_that.inSeason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int startWeek,  int endWeek,  bool inSeason)  $default,) {final _that = this;
switch (_that) {
case _SeasonalVegetableModel():
return $default(_that.id,_that.name,_that.startWeek,_that.endWeek,_that.inSeason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int startWeek,  int endWeek,  bool inSeason)?  $default,) {final _that = this;
switch (_that) {
case _SeasonalVegetableModel() when $default != null:
return $default(_that.id,_that.name,_that.startWeek,_that.endWeek,_that.inSeason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonalVegetableModel implements SeasonalVegetableModel {
  const _SeasonalVegetableModel({required this.id, required this.name, required this.startWeek, required this.endWeek, this.inSeason = false});
  factory _SeasonalVegetableModel.fromJson(Map<String, dynamic> json) => _$SeasonalVegetableModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  int startWeek;
@override final  int endWeek;
@override@JsonKey() final  bool inSeason;

/// Create a copy of SeasonalVegetableModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonalVegetableModelCopyWith<_SeasonalVegetableModel> get copyWith => __$SeasonalVegetableModelCopyWithImpl<_SeasonalVegetableModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonalVegetableModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonalVegetableModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startWeek, startWeek) || other.startWeek == startWeek)&&(identical(other.endWeek, endWeek) || other.endWeek == endWeek)&&(identical(other.inSeason, inSeason) || other.inSeason == inSeason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startWeek,endWeek,inSeason);

@override
String toString() {
  return 'SeasonalVegetableModel(id: $id, name: $name, startWeek: $startWeek, endWeek: $endWeek, inSeason: $inSeason)';
}


}

/// @nodoc
abstract mixin class _$SeasonalVegetableModelCopyWith<$Res> implements $SeasonalVegetableModelCopyWith<$Res> {
  factory _$SeasonalVegetableModelCopyWith(_SeasonalVegetableModel value, $Res Function(_SeasonalVegetableModel) _then) = __$SeasonalVegetableModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int startWeek, int endWeek, bool inSeason
});




}
/// @nodoc
class __$SeasonalVegetableModelCopyWithImpl<$Res>
    implements _$SeasonalVegetableModelCopyWith<$Res> {
  __$SeasonalVegetableModelCopyWithImpl(this._self, this._then);

  final _SeasonalVegetableModel _self;
  final $Res Function(_SeasonalVegetableModel) _then;

/// Create a copy of SeasonalVegetableModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startWeek = null,Object? endWeek = null,Object? inSeason = null,}) {
  return _then(_SeasonalVegetableModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startWeek: null == startWeek ? _self.startWeek : startWeek // ignore: cast_nullable_to_non_nullable
as int,endWeek: null == endWeek ? _self.endWeek : endWeek // ignore: cast_nullable_to_non_nullable
as int,inSeason: null == inSeason ? _self.inSeason : inSeason // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
