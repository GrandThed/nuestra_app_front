// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WishlistCategoryModel {

 String get id; String get name; String get type;// 'system' | 'custom'
 int get sortOrder; int get itemCount;
/// Create a copy of WishlistCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistCategoryModelCopyWith<WishlistCategoryModel> get copyWith => _$WishlistCategoryModelCopyWithImpl<WishlistCategoryModel>(this as WishlistCategoryModel, _$identity);

  /// Serializes this WishlistCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,sortOrder,itemCount);

@override
String toString() {
  return 'WishlistCategoryModel(id: $id, name: $name, type: $type, sortOrder: $sortOrder, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class $WishlistCategoryModelCopyWith<$Res>  {
  factory $WishlistCategoryModelCopyWith(WishlistCategoryModel value, $Res Function(WishlistCategoryModel) _then) = _$WishlistCategoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, int sortOrder, int itemCount
});




}
/// @nodoc
class _$WishlistCategoryModelCopyWithImpl<$Res>
    implements $WishlistCategoryModelCopyWith<$Res> {
  _$WishlistCategoryModelCopyWithImpl(this._self, this._then);

  final WishlistCategoryModel _self;
  final $Res Function(WishlistCategoryModel) _then;

/// Create a copy of WishlistCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? sortOrder = null,Object? itemCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WishlistCategoryModel].
extension WishlistCategoryModelPatterns on WishlistCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishlistCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishlistCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishlistCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _WishlistCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishlistCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _WishlistCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  int sortOrder,  int itemCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishlistCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.sortOrder,_that.itemCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  int sortOrder,  int itemCount)  $default,) {final _that = this;
switch (_that) {
case _WishlistCategoryModel():
return $default(_that.id,_that.name,_that.type,_that.sortOrder,_that.itemCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  int sortOrder,  int itemCount)?  $default,) {final _that = this;
switch (_that) {
case _WishlistCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.sortOrder,_that.itemCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishlistCategoryModel implements WishlistCategoryModel {
  const _WishlistCategoryModel({required this.id, required this.name, required this.type, required this.sortOrder, this.itemCount = 0});
  factory _WishlistCategoryModel.fromJson(Map<String, dynamic> json) => _$WishlistCategoryModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
// 'system' | 'custom'
@override final  int sortOrder;
@override@JsonKey() final  int itemCount;

/// Create a copy of WishlistCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishlistCategoryModelCopyWith<_WishlistCategoryModel> get copyWith => __$WishlistCategoryModelCopyWithImpl<_WishlistCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishlistCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishlistCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,sortOrder,itemCount);

@override
String toString() {
  return 'WishlistCategoryModel(id: $id, name: $name, type: $type, sortOrder: $sortOrder, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class _$WishlistCategoryModelCopyWith<$Res> implements $WishlistCategoryModelCopyWith<$Res> {
  factory _$WishlistCategoryModelCopyWith(_WishlistCategoryModel value, $Res Function(_WishlistCategoryModel) _then) = __$WishlistCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, int sortOrder, int itemCount
});




}
/// @nodoc
class __$WishlistCategoryModelCopyWithImpl<$Res>
    implements _$WishlistCategoryModelCopyWith<$Res> {
  __$WishlistCategoryModelCopyWithImpl(this._self, this._then);

  final _WishlistCategoryModel _self;
  final $Res Function(_WishlistCategoryModel) _then;

/// Create a copy of WishlistCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? sortOrder = null,Object? itemCount = null,}) {
  return _then(_WishlistCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WishlistItemModel {

 String get id; String get householdId; String get categoryId; String get name; String get ownerType;// 'shared' | 'personal'
 bool get checked; String? get userId; WishlistItemUserModel? get user; String? get url;@DecimalConverter() double? get price; String? get preferenceEmoji;@DecimalConverter() double? get quantity; String? get unit; WishlistCategoryRefModel? get category; WishlistSourceRecipeModel? get sourceRecipe; DateTime? get createdAt;
/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistItemModelCopyWith<WishlistItemModel> get copyWith => _$WishlistItemModelCopyWithImpl<WishlistItemModel>(this as WishlistItemModel, _$identity);

  /// Serializes this WishlistItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerType, ownerType) || other.ownerType == ownerType)&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.url, url) || other.url == url)&&(identical(other.price, price) || other.price == price)&&(identical(other.preferenceEmoji, preferenceEmoji) || other.preferenceEmoji == preferenceEmoji)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category)&&(identical(other.sourceRecipe, sourceRecipe) || other.sourceRecipe == sourceRecipe)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,categoryId,name,ownerType,checked,userId,user,url,price,preferenceEmoji,quantity,unit,category,sourceRecipe,createdAt);

@override
String toString() {
  return 'WishlistItemModel(id: $id, householdId: $householdId, categoryId: $categoryId, name: $name, ownerType: $ownerType, checked: $checked, userId: $userId, user: $user, url: $url, price: $price, preferenceEmoji: $preferenceEmoji, quantity: $quantity, unit: $unit, category: $category, sourceRecipe: $sourceRecipe, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WishlistItemModelCopyWith<$Res>  {
  factory $WishlistItemModelCopyWith(WishlistItemModel value, $Res Function(WishlistItemModel) _then) = _$WishlistItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String categoryId, String name, String ownerType, bool checked, String? userId, WishlistItemUserModel? user, String? url,@DecimalConverter() double? price, String? preferenceEmoji,@DecimalConverter() double? quantity, String? unit, WishlistCategoryRefModel? category, WishlistSourceRecipeModel? sourceRecipe, DateTime? createdAt
});


$WishlistItemUserModelCopyWith<$Res>? get user;$WishlistCategoryRefModelCopyWith<$Res>? get category;$WishlistSourceRecipeModelCopyWith<$Res>? get sourceRecipe;

}
/// @nodoc
class _$WishlistItemModelCopyWithImpl<$Res>
    implements $WishlistItemModelCopyWith<$Res> {
  _$WishlistItemModelCopyWithImpl(this._self, this._then);

  final WishlistItemModel _self;
  final $Res Function(WishlistItemModel) _then;

/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? categoryId = null,Object? name = null,Object? ownerType = null,Object? checked = null,Object? userId = freezed,Object? user = freezed,Object? url = freezed,Object? price = freezed,Object? preferenceEmoji = freezed,Object? quantity = freezed,Object? unit = freezed,Object? category = freezed,Object? sourceRecipe = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerType: null == ownerType ? _self.ownerType : ownerType // ignore: cast_nullable_to_non_nullable
as String,checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as WishlistItemUserModel?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,preferenceEmoji: freezed == preferenceEmoji ? _self.preferenceEmoji : preferenceEmoji // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as WishlistCategoryRefModel?,sourceRecipe: freezed == sourceRecipe ? _self.sourceRecipe : sourceRecipe // ignore: cast_nullable_to_non_nullable
as WishlistSourceRecipeModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishlistItemUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $WishlistItemUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishlistCategoryRefModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $WishlistCategoryRefModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishlistSourceRecipeModelCopyWith<$Res>? get sourceRecipe {
    if (_self.sourceRecipe == null) {
    return null;
  }

  return $WishlistSourceRecipeModelCopyWith<$Res>(_self.sourceRecipe!, (value) {
    return _then(_self.copyWith(sourceRecipe: value));
  });
}
}


/// Adds pattern-matching-related methods to [WishlistItemModel].
extension WishlistItemModelPatterns on WishlistItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishlistItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishlistItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishlistItemModel value)  $default,){
final _that = this;
switch (_that) {
case _WishlistItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishlistItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _WishlistItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String categoryId,  String name,  String ownerType,  bool checked,  String? userId,  WishlistItemUserModel? user,  String? url, @DecimalConverter()  double? price,  String? preferenceEmoji, @DecimalConverter()  double? quantity,  String? unit,  WishlistCategoryRefModel? category,  WishlistSourceRecipeModel? sourceRecipe,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishlistItemModel() when $default != null:
return $default(_that.id,_that.householdId,_that.categoryId,_that.name,_that.ownerType,_that.checked,_that.userId,_that.user,_that.url,_that.price,_that.preferenceEmoji,_that.quantity,_that.unit,_that.category,_that.sourceRecipe,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String categoryId,  String name,  String ownerType,  bool checked,  String? userId,  WishlistItemUserModel? user,  String? url, @DecimalConverter()  double? price,  String? preferenceEmoji, @DecimalConverter()  double? quantity,  String? unit,  WishlistCategoryRefModel? category,  WishlistSourceRecipeModel? sourceRecipe,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WishlistItemModel():
return $default(_that.id,_that.householdId,_that.categoryId,_that.name,_that.ownerType,_that.checked,_that.userId,_that.user,_that.url,_that.price,_that.preferenceEmoji,_that.quantity,_that.unit,_that.category,_that.sourceRecipe,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String categoryId,  String name,  String ownerType,  bool checked,  String? userId,  WishlistItemUserModel? user,  String? url, @DecimalConverter()  double? price,  String? preferenceEmoji, @DecimalConverter()  double? quantity,  String? unit,  WishlistCategoryRefModel? category,  WishlistSourceRecipeModel? sourceRecipe,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WishlistItemModel() when $default != null:
return $default(_that.id,_that.householdId,_that.categoryId,_that.name,_that.ownerType,_that.checked,_that.userId,_that.user,_that.url,_that.price,_that.preferenceEmoji,_that.quantity,_that.unit,_that.category,_that.sourceRecipe,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishlistItemModel implements WishlistItemModel {
  const _WishlistItemModel({required this.id, required this.householdId, required this.categoryId, required this.name, required this.ownerType, this.checked = false, this.userId, this.user, this.url, @DecimalConverter() this.price, this.preferenceEmoji, @DecimalConverter() this.quantity, this.unit, this.category, this.sourceRecipe, this.createdAt});
  factory _WishlistItemModel.fromJson(Map<String, dynamic> json) => _$WishlistItemModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String categoryId;
@override final  String name;
@override final  String ownerType;
// 'shared' | 'personal'
@override@JsonKey() final  bool checked;
@override final  String? userId;
@override final  WishlistItemUserModel? user;
@override final  String? url;
@override@DecimalConverter() final  double? price;
@override final  String? preferenceEmoji;
@override@DecimalConverter() final  double? quantity;
@override final  String? unit;
@override final  WishlistCategoryRefModel? category;
@override final  WishlistSourceRecipeModel? sourceRecipe;
@override final  DateTime? createdAt;

/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishlistItemModelCopyWith<_WishlistItemModel> get copyWith => __$WishlistItemModelCopyWithImpl<_WishlistItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishlistItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishlistItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerType, ownerType) || other.ownerType == ownerType)&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.url, url) || other.url == url)&&(identical(other.price, price) || other.price == price)&&(identical(other.preferenceEmoji, preferenceEmoji) || other.preferenceEmoji == preferenceEmoji)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category)&&(identical(other.sourceRecipe, sourceRecipe) || other.sourceRecipe == sourceRecipe)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,categoryId,name,ownerType,checked,userId,user,url,price,preferenceEmoji,quantity,unit,category,sourceRecipe,createdAt);

@override
String toString() {
  return 'WishlistItemModel(id: $id, householdId: $householdId, categoryId: $categoryId, name: $name, ownerType: $ownerType, checked: $checked, userId: $userId, user: $user, url: $url, price: $price, preferenceEmoji: $preferenceEmoji, quantity: $quantity, unit: $unit, category: $category, sourceRecipe: $sourceRecipe, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WishlistItemModelCopyWith<$Res> implements $WishlistItemModelCopyWith<$Res> {
  factory _$WishlistItemModelCopyWith(_WishlistItemModel value, $Res Function(_WishlistItemModel) _then) = __$WishlistItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String categoryId, String name, String ownerType, bool checked, String? userId, WishlistItemUserModel? user, String? url,@DecimalConverter() double? price, String? preferenceEmoji,@DecimalConverter() double? quantity, String? unit, WishlistCategoryRefModel? category, WishlistSourceRecipeModel? sourceRecipe, DateTime? createdAt
});


@override $WishlistItemUserModelCopyWith<$Res>? get user;@override $WishlistCategoryRefModelCopyWith<$Res>? get category;@override $WishlistSourceRecipeModelCopyWith<$Res>? get sourceRecipe;

}
/// @nodoc
class __$WishlistItemModelCopyWithImpl<$Res>
    implements _$WishlistItemModelCopyWith<$Res> {
  __$WishlistItemModelCopyWithImpl(this._self, this._then);

  final _WishlistItemModel _self;
  final $Res Function(_WishlistItemModel) _then;

/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? categoryId = null,Object? name = null,Object? ownerType = null,Object? checked = null,Object? userId = freezed,Object? user = freezed,Object? url = freezed,Object? price = freezed,Object? preferenceEmoji = freezed,Object? quantity = freezed,Object? unit = freezed,Object? category = freezed,Object? sourceRecipe = freezed,Object? createdAt = freezed,}) {
  return _then(_WishlistItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerType: null == ownerType ? _self.ownerType : ownerType // ignore: cast_nullable_to_non_nullable
as String,checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as WishlistItemUserModel?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,preferenceEmoji: freezed == preferenceEmoji ? _self.preferenceEmoji : preferenceEmoji // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as WishlistCategoryRefModel?,sourceRecipe: freezed == sourceRecipe ? _self.sourceRecipe : sourceRecipe // ignore: cast_nullable_to_non_nullable
as WishlistSourceRecipeModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishlistItemUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $WishlistItemUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishlistCategoryRefModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $WishlistCategoryRefModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of WishlistItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WishlistSourceRecipeModelCopyWith<$Res>? get sourceRecipe {
    if (_self.sourceRecipe == null) {
    return null;
  }

  return $WishlistSourceRecipeModelCopyWith<$Res>(_self.sourceRecipe!, (value) {
    return _then(_self.copyWith(sourceRecipe: value));
  });
}
}


/// @nodoc
mixin _$WishlistItemUserModel {

 String get id; String get name;
/// Create a copy of WishlistItemUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistItemUserModelCopyWith<WishlistItemUserModel> get copyWith => _$WishlistItemUserModelCopyWithImpl<WishlistItemUserModel>(this as WishlistItemUserModel, _$identity);

  /// Serializes this WishlistItemUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistItemUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'WishlistItemUserModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $WishlistItemUserModelCopyWith<$Res>  {
  factory $WishlistItemUserModelCopyWith(WishlistItemUserModel value, $Res Function(WishlistItemUserModel) _then) = _$WishlistItemUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$WishlistItemUserModelCopyWithImpl<$Res>
    implements $WishlistItemUserModelCopyWith<$Res> {
  _$WishlistItemUserModelCopyWithImpl(this._self, this._then);

  final WishlistItemUserModel _self;
  final $Res Function(WishlistItemUserModel) _then;

/// Create a copy of WishlistItemUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WishlistItemUserModel].
extension WishlistItemUserModelPatterns on WishlistItemUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishlistItemUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishlistItemUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishlistItemUserModel value)  $default,){
final _that = this;
switch (_that) {
case _WishlistItemUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishlistItemUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _WishlistItemUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishlistItemUserModel() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _WishlistItemUserModel():
return $default(_that.id,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _WishlistItemUserModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishlistItemUserModel implements WishlistItemUserModel {
  const _WishlistItemUserModel({required this.id, required this.name});
  factory _WishlistItemUserModel.fromJson(Map<String, dynamic> json) => _$WishlistItemUserModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of WishlistItemUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishlistItemUserModelCopyWith<_WishlistItemUserModel> get copyWith => __$WishlistItemUserModelCopyWithImpl<_WishlistItemUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishlistItemUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishlistItemUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'WishlistItemUserModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$WishlistItemUserModelCopyWith<$Res> implements $WishlistItemUserModelCopyWith<$Res> {
  factory _$WishlistItemUserModelCopyWith(_WishlistItemUserModel value, $Res Function(_WishlistItemUserModel) _then) = __$WishlistItemUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$WishlistItemUserModelCopyWithImpl<$Res>
    implements _$WishlistItemUserModelCopyWith<$Res> {
  __$WishlistItemUserModelCopyWithImpl(this._self, this._then);

  final _WishlistItemUserModel _self;
  final $Res Function(_WishlistItemUserModel) _then;

/// Create a copy of WishlistItemUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_WishlistItemUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WishlistCategoryRefModel {

 String get id; String get name;
/// Create a copy of WishlistCategoryRefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistCategoryRefModelCopyWith<WishlistCategoryRefModel> get copyWith => _$WishlistCategoryRefModelCopyWithImpl<WishlistCategoryRefModel>(this as WishlistCategoryRefModel, _$identity);

  /// Serializes this WishlistCategoryRefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistCategoryRefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'WishlistCategoryRefModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $WishlistCategoryRefModelCopyWith<$Res>  {
  factory $WishlistCategoryRefModelCopyWith(WishlistCategoryRefModel value, $Res Function(WishlistCategoryRefModel) _then) = _$WishlistCategoryRefModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$WishlistCategoryRefModelCopyWithImpl<$Res>
    implements $WishlistCategoryRefModelCopyWith<$Res> {
  _$WishlistCategoryRefModelCopyWithImpl(this._self, this._then);

  final WishlistCategoryRefModel _self;
  final $Res Function(WishlistCategoryRefModel) _then;

/// Create a copy of WishlistCategoryRefModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WishlistCategoryRefModel].
extension WishlistCategoryRefModelPatterns on WishlistCategoryRefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishlistCategoryRefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishlistCategoryRefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishlistCategoryRefModel value)  $default,){
final _that = this;
switch (_that) {
case _WishlistCategoryRefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishlistCategoryRefModel value)?  $default,){
final _that = this;
switch (_that) {
case _WishlistCategoryRefModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishlistCategoryRefModel() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _WishlistCategoryRefModel():
return $default(_that.id,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _WishlistCategoryRefModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishlistCategoryRefModel implements WishlistCategoryRefModel {
  const _WishlistCategoryRefModel({required this.id, required this.name});
  factory _WishlistCategoryRefModel.fromJson(Map<String, dynamic> json) => _$WishlistCategoryRefModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of WishlistCategoryRefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishlistCategoryRefModelCopyWith<_WishlistCategoryRefModel> get copyWith => __$WishlistCategoryRefModelCopyWithImpl<_WishlistCategoryRefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishlistCategoryRefModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishlistCategoryRefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'WishlistCategoryRefModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$WishlistCategoryRefModelCopyWith<$Res> implements $WishlistCategoryRefModelCopyWith<$Res> {
  factory _$WishlistCategoryRefModelCopyWith(_WishlistCategoryRefModel value, $Res Function(_WishlistCategoryRefModel) _then) = __$WishlistCategoryRefModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$WishlistCategoryRefModelCopyWithImpl<$Res>
    implements _$WishlistCategoryRefModelCopyWith<$Res> {
  __$WishlistCategoryRefModelCopyWithImpl(this._self, this._then);

  final _WishlistCategoryRefModel _self;
  final $Res Function(_WishlistCategoryRefModel) _then;

/// Create a copy of WishlistCategoryRefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_WishlistCategoryRefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WishlistSourceRecipeModel {

 String get id; String get title;
/// Create a copy of WishlistSourceRecipeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishlistSourceRecipeModelCopyWith<WishlistSourceRecipeModel> get copyWith => _$WishlistSourceRecipeModelCopyWithImpl<WishlistSourceRecipeModel>(this as WishlistSourceRecipeModel, _$identity);

  /// Serializes this WishlistSourceRecipeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishlistSourceRecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'WishlistSourceRecipeModel(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $WishlistSourceRecipeModelCopyWith<$Res>  {
  factory $WishlistSourceRecipeModelCopyWith(WishlistSourceRecipeModel value, $Res Function(WishlistSourceRecipeModel) _then) = _$WishlistSourceRecipeModelCopyWithImpl;
@useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class _$WishlistSourceRecipeModelCopyWithImpl<$Res>
    implements $WishlistSourceRecipeModelCopyWith<$Res> {
  _$WishlistSourceRecipeModelCopyWithImpl(this._self, this._then);

  final WishlistSourceRecipeModel _self;
  final $Res Function(WishlistSourceRecipeModel) _then;

/// Create a copy of WishlistSourceRecipeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WishlistSourceRecipeModel].
extension WishlistSourceRecipeModelPatterns on WishlistSourceRecipeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishlistSourceRecipeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishlistSourceRecipeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishlistSourceRecipeModel value)  $default,){
final _that = this;
switch (_that) {
case _WishlistSourceRecipeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishlistSourceRecipeModel value)?  $default,){
final _that = this;
switch (_that) {
case _WishlistSourceRecipeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishlistSourceRecipeModel() when $default != null:
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title)  $default,) {final _that = this;
switch (_that) {
case _WishlistSourceRecipeModel():
return $default(_that.id,_that.title);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title)?  $default,) {final _that = this;
switch (_that) {
case _WishlistSourceRecipeModel() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishlistSourceRecipeModel implements WishlistSourceRecipeModel {
  const _WishlistSourceRecipeModel({required this.id, required this.title});
  factory _WishlistSourceRecipeModel.fromJson(Map<String, dynamic> json) => _$WishlistSourceRecipeModelFromJson(json);

@override final  String id;
@override final  String title;

/// Create a copy of WishlistSourceRecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishlistSourceRecipeModelCopyWith<_WishlistSourceRecipeModel> get copyWith => __$WishlistSourceRecipeModelCopyWithImpl<_WishlistSourceRecipeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishlistSourceRecipeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishlistSourceRecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'WishlistSourceRecipeModel(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$WishlistSourceRecipeModelCopyWith<$Res> implements $WishlistSourceRecipeModelCopyWith<$Res> {
  factory _$WishlistSourceRecipeModelCopyWith(_WishlistSourceRecipeModel value, $Res Function(_WishlistSourceRecipeModel) _then) = __$WishlistSourceRecipeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class __$WishlistSourceRecipeModelCopyWithImpl<$Res>
    implements _$WishlistSourceRecipeModelCopyWith<$Res> {
  __$WishlistSourceRecipeModelCopyWithImpl(this._self, this._then);

  final _WishlistSourceRecipeModel _self;
  final $Res Function(_WishlistSourceRecipeModel) _then;

/// Create a copy of WishlistSourceRecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_WishlistSourceRecipeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
