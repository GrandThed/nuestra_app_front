// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseCategoryModel {

 String get id; String get name; String? get icon; int get expenseCount;
/// Create a copy of ExpenseCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCategoryModelCopyWith<ExpenseCategoryModel> get copyWith => _$ExpenseCategoryModelCopyWithImpl<ExpenseCategoryModel>(this as ExpenseCategoryModel, _$identity);

  /// Serializes this ExpenseCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.expenseCount, expenseCount) || other.expenseCount == expenseCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,expenseCount);

@override
String toString() {
  return 'ExpenseCategoryModel(id: $id, name: $name, icon: $icon, expenseCount: $expenseCount)';
}


}

/// @nodoc
abstract mixin class $ExpenseCategoryModelCopyWith<$Res>  {
  factory $ExpenseCategoryModelCopyWith(ExpenseCategoryModel value, $Res Function(ExpenseCategoryModel) _then) = _$ExpenseCategoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? icon, int expenseCount
});




}
/// @nodoc
class _$ExpenseCategoryModelCopyWithImpl<$Res>
    implements $ExpenseCategoryModelCopyWith<$Res> {
  _$ExpenseCategoryModelCopyWithImpl(this._self, this._then);

  final ExpenseCategoryModel _self;
  final $Res Function(ExpenseCategoryModel) _then;

/// Create a copy of ExpenseCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = freezed,Object? expenseCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,expenseCount: null == expenseCount ? _self.expenseCount : expenseCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseCategoryModel].
extension ExpenseCategoryModelPatterns on ExpenseCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? icon,  int expenseCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.expenseCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? icon,  int expenseCount)  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategoryModel():
return $default(_that.id,_that.name,_that.icon,_that.expenseCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? icon,  int expenseCount)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.expenseCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseCategoryModel implements ExpenseCategoryModel {
  const _ExpenseCategoryModel({required this.id, required this.name, this.icon, this.expenseCount = 0});
  factory _ExpenseCategoryModel.fromJson(Map<String, dynamic> json) => _$ExpenseCategoryModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? icon;
@override@JsonKey() final  int expenseCount;

/// Create a copy of ExpenseCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCategoryModelCopyWith<_ExpenseCategoryModel> get copyWith => __$ExpenseCategoryModelCopyWithImpl<_ExpenseCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.expenseCount, expenseCount) || other.expenseCount == expenseCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,expenseCount);

@override
String toString() {
  return 'ExpenseCategoryModel(id: $id, name: $name, icon: $icon, expenseCount: $expenseCount)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCategoryModelCopyWith<$Res> implements $ExpenseCategoryModelCopyWith<$Res> {
  factory _$ExpenseCategoryModelCopyWith(_ExpenseCategoryModel value, $Res Function(_ExpenseCategoryModel) _then) = __$ExpenseCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? icon, int expenseCount
});




}
/// @nodoc
class __$ExpenseCategoryModelCopyWithImpl<$Res>
    implements _$ExpenseCategoryModelCopyWith<$Res> {
  __$ExpenseCategoryModelCopyWithImpl(this._self, this._then);

  final _ExpenseCategoryModel _self;
  final $Res Function(_ExpenseCategoryModel) _then;

/// Create a copy of ExpenseCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = freezed,Object? expenseCount = null,}) {
  return _then(_ExpenseCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,expenseCount: null == expenseCount ? _self.expenseCount : expenseCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExpenseUserModel {

 String get id; String get name; String? get avatarUrl;
/// Create a copy of ExpenseUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<ExpenseUserModel> get copyWith => _$ExpenseUserModelCopyWithImpl<ExpenseUserModel>(this as ExpenseUserModel, _$identity);

  /// Serializes this ExpenseUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ExpenseUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $ExpenseUserModelCopyWith<$Res>  {
  factory $ExpenseUserModelCopyWith(ExpenseUserModel value, $Res Function(ExpenseUserModel) _then) = _$ExpenseUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class _$ExpenseUserModelCopyWithImpl<$Res>
    implements $ExpenseUserModelCopyWith<$Res> {
  _$ExpenseUserModelCopyWithImpl(this._self, this._then);

  final ExpenseUserModel _self;
  final $Res Function(ExpenseUserModel) _then;

/// Create a copy of ExpenseUserModel
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


/// Adds pattern-matching-related methods to [ExpenseUserModel].
extension ExpenseUserModelPatterns on ExpenseUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseUserModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseUserModel() when $default != null:
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
case _ExpenseUserModel() when $default != null:
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
case _ExpenseUserModel():
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
case _ExpenseUserModel() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseUserModel implements ExpenseUserModel {
  const _ExpenseUserModel({required this.id, required this.name, this.avatarUrl});
  factory _ExpenseUserModel.fromJson(Map<String, dynamic> json) => _$ExpenseUserModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of ExpenseUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseUserModelCopyWith<_ExpenseUserModel> get copyWith => __$ExpenseUserModelCopyWithImpl<_ExpenseUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ExpenseUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ExpenseUserModelCopyWith<$Res> implements $ExpenseUserModelCopyWith<$Res> {
  factory _$ExpenseUserModelCopyWith(_ExpenseUserModel value, $Res Function(_ExpenseUserModel) _then) = __$ExpenseUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class __$ExpenseUserModelCopyWithImpl<$Res>
    implements _$ExpenseUserModelCopyWith<$Res> {
  __$ExpenseUserModelCopyWithImpl(this._self, this._then);

  final _ExpenseUserModel _self;
  final $Res Function(_ExpenseUserModel) _then;

/// Create a copy of ExpenseUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_ExpenseUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ExpenseSplitModel {

 String get id; String get userId; ExpenseUserModel? get user;@DecimalConverter() double get amount; bool get settled;@NullableDecimalConverter() double? get customAmount; bool get isCustom;
/// Create a copy of ExpenseSplitModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSplitModelCopyWith<ExpenseSplitModel> get copyWith => _$ExpenseSplitModelCopyWithImpl<ExpenseSplitModel>(this as ExpenseSplitModel, _$identity);

  /// Serializes this ExpenseSplitModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSplitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.settled, settled) || other.settled == settled)&&(identical(other.customAmount, customAmount) || other.customAmount == customAmount)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,user,amount,settled,customAmount,isCustom);

@override
String toString() {
  return 'ExpenseSplitModel(id: $id, userId: $userId, user: $user, amount: $amount, settled: $settled, customAmount: $customAmount, isCustom: $isCustom)';
}


}

/// @nodoc
abstract mixin class $ExpenseSplitModelCopyWith<$Res>  {
  factory $ExpenseSplitModelCopyWith(ExpenseSplitModel value, $Res Function(ExpenseSplitModel) _then) = _$ExpenseSplitModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, ExpenseUserModel? user,@DecimalConverter() double amount, bool settled,@NullableDecimalConverter() double? customAmount, bool isCustom
});


$ExpenseUserModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$ExpenseSplitModelCopyWithImpl<$Res>
    implements $ExpenseSplitModelCopyWith<$Res> {
  _$ExpenseSplitModelCopyWithImpl(this._self, this._then);

  final ExpenseSplitModel _self;
  final $Res Function(ExpenseSplitModel) _then;

/// Create a copy of ExpenseSplitModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? user = freezed,Object? amount = null,Object? settled = null,Object? customAmount = freezed,Object? isCustom = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,settled: null == settled ? _self.settled : settled // ignore: cast_nullable_to_non_nullable
as bool,customAmount: freezed == customAmount ? _self.customAmount : customAmount // ignore: cast_nullable_to_non_nullable
as double?,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ExpenseSplitModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ExpenseUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpenseSplitModel].
extension ExpenseSplitModelPatterns on ExpenseSplitModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseSplitModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseSplitModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseSplitModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseSplitModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseSplitModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseSplitModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  ExpenseUserModel? user, @DecimalConverter()  double amount,  bool settled, @NullableDecimalConverter()  double? customAmount,  bool isCustom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseSplitModel() when $default != null:
return $default(_that.id,_that.userId,_that.user,_that.amount,_that.settled,_that.customAmount,_that.isCustom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  ExpenseUserModel? user, @DecimalConverter()  double amount,  bool settled, @NullableDecimalConverter()  double? customAmount,  bool isCustom)  $default,) {final _that = this;
switch (_that) {
case _ExpenseSplitModel():
return $default(_that.id,_that.userId,_that.user,_that.amount,_that.settled,_that.customAmount,_that.isCustom);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  ExpenseUserModel? user, @DecimalConverter()  double amount,  bool settled, @NullableDecimalConverter()  double? customAmount,  bool isCustom)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseSplitModel() when $default != null:
return $default(_that.id,_that.userId,_that.user,_that.amount,_that.settled,_that.customAmount,_that.isCustom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseSplitModel implements ExpenseSplitModel {
  const _ExpenseSplitModel({required this.id, required this.userId, this.user, @DecimalConverter() required this.amount, this.settled = false, @NullableDecimalConverter() this.customAmount, this.isCustom = false});
  factory _ExpenseSplitModel.fromJson(Map<String, dynamic> json) => _$ExpenseSplitModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  ExpenseUserModel? user;
@override@DecimalConverter() final  double amount;
@override@JsonKey() final  bool settled;
@override@NullableDecimalConverter() final  double? customAmount;
@override@JsonKey() final  bool isCustom;

/// Create a copy of ExpenseSplitModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseSplitModelCopyWith<_ExpenseSplitModel> get copyWith => __$ExpenseSplitModelCopyWithImpl<_ExpenseSplitModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseSplitModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseSplitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.settled, settled) || other.settled == settled)&&(identical(other.customAmount, customAmount) || other.customAmount == customAmount)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,user,amount,settled,customAmount,isCustom);

@override
String toString() {
  return 'ExpenseSplitModel(id: $id, userId: $userId, user: $user, amount: $amount, settled: $settled, customAmount: $customAmount, isCustom: $isCustom)';
}


}

/// @nodoc
abstract mixin class _$ExpenseSplitModelCopyWith<$Res> implements $ExpenseSplitModelCopyWith<$Res> {
  factory _$ExpenseSplitModelCopyWith(_ExpenseSplitModel value, $Res Function(_ExpenseSplitModel) _then) = __$ExpenseSplitModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, ExpenseUserModel? user,@DecimalConverter() double amount, bool settled,@NullableDecimalConverter() double? customAmount, bool isCustom
});


@override $ExpenseUserModelCopyWith<$Res>? get user;

}
/// @nodoc
class __$ExpenseSplitModelCopyWithImpl<$Res>
    implements _$ExpenseSplitModelCopyWith<$Res> {
  __$ExpenseSplitModelCopyWithImpl(this._self, this._then);

  final _ExpenseSplitModel _self;
  final $Res Function(_ExpenseSplitModel) _then;

/// Create a copy of ExpenseSplitModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? user = freezed,Object? amount = null,Object? settled = null,Object? customAmount = freezed,Object? isCustom = null,}) {
  return _then(_ExpenseSplitModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,settled: null == settled ? _self.settled : settled // ignore: cast_nullable_to_non_nullable
as bool,customAmount: freezed == customAmount ? _self.customAmount : customAmount // ignore: cast_nullable_to_non_nullable
as double?,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ExpenseSplitModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ExpenseUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$ExpenseModel {

 String get id; String get householdId; String get description;@DecimalConverter() double get amount; String get currency; DateTime get date; String? get receiptUrl; ExpenseCategoryModel? get category; ExpenseUserModel get paidBy; List<ExpenseSplitModel> get splits; bool get allSettled; DateTime? get createdAt; String? get recurringExpenseId; String? get linkedWishlistItemId;
/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseModelCopyWith<ExpenseModel> get copyWith => _$ExpenseModelCopyWithImpl<ExpenseModel>(this as ExpenseModel, _$identity);

  /// Serializes this ExpenseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.date, date) || other.date == date)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&const DeepCollectionEquality().equals(other.splits, splits)&&(identical(other.allSettled, allSettled) || other.allSettled == allSettled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.recurringExpenseId, recurringExpenseId) || other.recurringExpenseId == recurringExpenseId)&&(identical(other.linkedWishlistItemId, linkedWishlistItemId) || other.linkedWishlistItemId == linkedWishlistItemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,description,amount,currency,date,receiptUrl,category,paidBy,const DeepCollectionEquality().hash(splits),allSettled,createdAt,recurringExpenseId,linkedWishlistItemId);

@override
String toString() {
  return 'ExpenseModel(id: $id, householdId: $householdId, description: $description, amount: $amount, currency: $currency, date: $date, receiptUrl: $receiptUrl, category: $category, paidBy: $paidBy, splits: $splits, allSettled: $allSettled, createdAt: $createdAt, recurringExpenseId: $recurringExpenseId, linkedWishlistItemId: $linkedWishlistItemId)';
}


}

/// @nodoc
abstract mixin class $ExpenseModelCopyWith<$Res>  {
  factory $ExpenseModelCopyWith(ExpenseModel value, $Res Function(ExpenseModel) _then) = _$ExpenseModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String description,@DecimalConverter() double amount, String currency, DateTime date, String? receiptUrl, ExpenseCategoryModel? category, ExpenseUserModel paidBy, List<ExpenseSplitModel> splits, bool allSettled, DateTime? createdAt, String? recurringExpenseId, String? linkedWishlistItemId
});


$ExpenseCategoryModelCopyWith<$Res>? get category;$ExpenseUserModelCopyWith<$Res> get paidBy;

}
/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._self, this._then);

  final ExpenseModel _self;
  final $Res Function(ExpenseModel) _then;

/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? description = null,Object? amount = null,Object? currency = null,Object? date = null,Object? receiptUrl = freezed,Object? category = freezed,Object? paidBy = null,Object? splits = null,Object? allSettled = null,Object? createdAt = freezed,Object? recurringExpenseId = freezed,Object? linkedWishlistItemId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategoryModel?,paidBy: null == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel,splits: null == splits ? _self.splits : splits // ignore: cast_nullable_to_non_nullable
as List<ExpenseSplitModel>,allSettled: null == allSettled ? _self.allSettled : allSettled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recurringExpenseId: freezed == recurringExpenseId ? _self.recurringExpenseId : recurringExpenseId // ignore: cast_nullable_to_non_nullable
as String?,linkedWishlistItemId: freezed == linkedWishlistItemId ? _self.linkedWishlistItemId : linkedWishlistItemId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ExpenseCategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res> get paidBy {
  
  return $ExpenseUserModelCopyWith<$Res>(_self.paidBy, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpenseModel].
extension ExpenseModelPatterns on ExpenseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String description, @DecimalConverter()  double amount,  String currency,  DateTime date,  String? receiptUrl,  ExpenseCategoryModel? category,  ExpenseUserModel paidBy,  List<ExpenseSplitModel> splits,  bool allSettled,  DateTime? createdAt,  String? recurringExpenseId,  String? linkedWishlistItemId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
return $default(_that.id,_that.householdId,_that.description,_that.amount,_that.currency,_that.date,_that.receiptUrl,_that.category,_that.paidBy,_that.splits,_that.allSettled,_that.createdAt,_that.recurringExpenseId,_that.linkedWishlistItemId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String description, @DecimalConverter()  double amount,  String currency,  DateTime date,  String? receiptUrl,  ExpenseCategoryModel? category,  ExpenseUserModel paidBy,  List<ExpenseSplitModel> splits,  bool allSettled,  DateTime? createdAt,  String? recurringExpenseId,  String? linkedWishlistItemId)  $default,) {final _that = this;
switch (_that) {
case _ExpenseModel():
return $default(_that.id,_that.householdId,_that.description,_that.amount,_that.currency,_that.date,_that.receiptUrl,_that.category,_that.paidBy,_that.splits,_that.allSettled,_that.createdAt,_that.recurringExpenseId,_that.linkedWishlistItemId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String description, @DecimalConverter()  double amount,  String currency,  DateTime date,  String? receiptUrl,  ExpenseCategoryModel? category,  ExpenseUserModel paidBy,  List<ExpenseSplitModel> splits,  bool allSettled,  DateTime? createdAt,  String? recurringExpenseId,  String? linkedWishlistItemId)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
return $default(_that.id,_that.householdId,_that.description,_that.amount,_that.currency,_that.date,_that.receiptUrl,_that.category,_that.paidBy,_that.splits,_that.allSettled,_that.createdAt,_that.recurringExpenseId,_that.linkedWishlistItemId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseModel implements ExpenseModel {
  const _ExpenseModel({required this.id, required this.householdId, required this.description, @DecimalConverter() required this.amount, this.currency = 'ARS', required this.date, this.receiptUrl, this.category, required this.paidBy, final  List<ExpenseSplitModel> splits = const [], this.allSettled = false, this.createdAt, this.recurringExpenseId, this.linkedWishlistItemId}): _splits = splits;
  factory _ExpenseModel.fromJson(Map<String, dynamic> json) => _$ExpenseModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String description;
@override@DecimalConverter() final  double amount;
@override@JsonKey() final  String currency;
@override final  DateTime date;
@override final  String? receiptUrl;
@override final  ExpenseCategoryModel? category;
@override final  ExpenseUserModel paidBy;
 final  List<ExpenseSplitModel> _splits;
@override@JsonKey() List<ExpenseSplitModel> get splits {
  if (_splits is EqualUnmodifiableListView) return _splits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_splits);
}

@override@JsonKey() final  bool allSettled;
@override final  DateTime? createdAt;
@override final  String? recurringExpenseId;
@override final  String? linkedWishlistItemId;

/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseModelCopyWith<_ExpenseModel> get copyWith => __$ExpenseModelCopyWithImpl<_ExpenseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.date, date) || other.date == date)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&const DeepCollectionEquality().equals(other._splits, _splits)&&(identical(other.allSettled, allSettled) || other.allSettled == allSettled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.recurringExpenseId, recurringExpenseId) || other.recurringExpenseId == recurringExpenseId)&&(identical(other.linkedWishlistItemId, linkedWishlistItemId) || other.linkedWishlistItemId == linkedWishlistItemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,description,amount,currency,date,receiptUrl,category,paidBy,const DeepCollectionEquality().hash(_splits),allSettled,createdAt,recurringExpenseId,linkedWishlistItemId);

@override
String toString() {
  return 'ExpenseModel(id: $id, householdId: $householdId, description: $description, amount: $amount, currency: $currency, date: $date, receiptUrl: $receiptUrl, category: $category, paidBy: $paidBy, splits: $splits, allSettled: $allSettled, createdAt: $createdAt, recurringExpenseId: $recurringExpenseId, linkedWishlistItemId: $linkedWishlistItemId)';
}


}

/// @nodoc
abstract mixin class _$ExpenseModelCopyWith<$Res> implements $ExpenseModelCopyWith<$Res> {
  factory _$ExpenseModelCopyWith(_ExpenseModel value, $Res Function(_ExpenseModel) _then) = __$ExpenseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String description,@DecimalConverter() double amount, String currency, DateTime date, String? receiptUrl, ExpenseCategoryModel? category, ExpenseUserModel paidBy, List<ExpenseSplitModel> splits, bool allSettled, DateTime? createdAt, String? recurringExpenseId, String? linkedWishlistItemId
});


@override $ExpenseCategoryModelCopyWith<$Res>? get category;@override $ExpenseUserModelCopyWith<$Res> get paidBy;

}
/// @nodoc
class __$ExpenseModelCopyWithImpl<$Res>
    implements _$ExpenseModelCopyWith<$Res> {
  __$ExpenseModelCopyWithImpl(this._self, this._then);

  final _ExpenseModel _self;
  final $Res Function(_ExpenseModel) _then;

/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? description = null,Object? amount = null,Object? currency = null,Object? date = null,Object? receiptUrl = freezed,Object? category = freezed,Object? paidBy = null,Object? splits = null,Object? allSettled = null,Object? createdAt = freezed,Object? recurringExpenseId = freezed,Object? linkedWishlistItemId = freezed,}) {
  return _then(_ExpenseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategoryModel?,paidBy: null == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel,splits: null == splits ? _self._splits : splits // ignore: cast_nullable_to_non_nullable
as List<ExpenseSplitModel>,allSettled: null == allSettled ? _self.allSettled : allSettled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recurringExpenseId: freezed == recurringExpenseId ? _self.recurringExpenseId : recurringExpenseId // ignore: cast_nullable_to_non_nullable
as String?,linkedWishlistItemId: freezed == linkedWishlistItemId ? _self.linkedWishlistItemId : linkedWishlistItemId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ExpenseCategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res> get paidBy {
  
  return $ExpenseUserModelCopyWith<$Res>(_self.paidBy, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}
}


/// @nodoc
mixin _$ExpensePeriodModel {

 int get month; int get year;
/// Create a copy of ExpensePeriodModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpensePeriodModelCopyWith<ExpensePeriodModel> get copyWith => _$ExpensePeriodModelCopyWithImpl<ExpensePeriodModel>(this as ExpensePeriodModel, _$identity);

  /// Serializes this ExpensePeriodModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpensePeriodModel&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,year);

@override
String toString() {
  return 'ExpensePeriodModel(month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class $ExpensePeriodModelCopyWith<$Res>  {
  factory $ExpensePeriodModelCopyWith(ExpensePeriodModel value, $Res Function(ExpensePeriodModel) _then) = _$ExpensePeriodModelCopyWithImpl;
@useResult
$Res call({
 int month, int year
});




}
/// @nodoc
class _$ExpensePeriodModelCopyWithImpl<$Res>
    implements $ExpensePeriodModelCopyWith<$Res> {
  _$ExpensePeriodModelCopyWithImpl(this._self, this._then);

  final ExpensePeriodModel _self;
  final $Res Function(ExpensePeriodModel) _then;

/// Create a copy of ExpensePeriodModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? year = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpensePeriodModel].
extension ExpensePeriodModelPatterns on ExpensePeriodModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpensePeriodModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpensePeriodModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpensePeriodModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpensePeriodModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpensePeriodModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpensePeriodModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int month,  int year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpensePeriodModel() when $default != null:
return $default(_that.month,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int month,  int year)  $default,) {final _that = this;
switch (_that) {
case _ExpensePeriodModel():
return $default(_that.month,_that.year);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int month,  int year)?  $default,) {final _that = this;
switch (_that) {
case _ExpensePeriodModel() when $default != null:
return $default(_that.month,_that.year);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpensePeriodModel implements ExpensePeriodModel {
  const _ExpensePeriodModel({required this.month, required this.year});
  factory _ExpensePeriodModel.fromJson(Map<String, dynamic> json) => _$ExpensePeriodModelFromJson(json);

@override final  int month;
@override final  int year;

/// Create a copy of ExpensePeriodModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpensePeriodModelCopyWith<_ExpensePeriodModel> get copyWith => __$ExpensePeriodModelCopyWithImpl<_ExpensePeriodModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpensePeriodModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpensePeriodModel&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,year);

@override
String toString() {
  return 'ExpensePeriodModel(month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class _$ExpensePeriodModelCopyWith<$Res> implements $ExpensePeriodModelCopyWith<$Res> {
  factory _$ExpensePeriodModelCopyWith(_ExpensePeriodModel value, $Res Function(_ExpensePeriodModel) _then) = __$ExpensePeriodModelCopyWithImpl;
@override @useResult
$Res call({
 int month, int year
});




}
/// @nodoc
class __$ExpensePeriodModelCopyWithImpl<$Res>
    implements _$ExpensePeriodModelCopyWith<$Res> {
  __$ExpensePeriodModelCopyWithImpl(this._self, this._then);

  final _ExpensePeriodModel _self;
  final $Res Function(_ExpensePeriodModel) _then;

/// Create a copy of ExpensePeriodModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,}) {
  return _then(_ExpensePeriodModel(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExpenseCategoryBreakdownModel {

 String get name; String? get icon;@DecimalConverter() double get total; int get count;
/// Create a copy of ExpenseCategoryBreakdownModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCategoryBreakdownModelCopyWith<ExpenseCategoryBreakdownModel> get copyWith => _$ExpenseCategoryBreakdownModelCopyWithImpl<ExpenseCategoryBreakdownModel>(this as ExpenseCategoryBreakdownModel, _$identity);

  /// Serializes this ExpenseCategoryBreakdownModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseCategoryBreakdownModel&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.total, total) || other.total == total)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,icon,total,count);

@override
String toString() {
  return 'ExpenseCategoryBreakdownModel(name: $name, icon: $icon, total: $total, count: $count)';
}


}

/// @nodoc
abstract mixin class $ExpenseCategoryBreakdownModelCopyWith<$Res>  {
  factory $ExpenseCategoryBreakdownModelCopyWith(ExpenseCategoryBreakdownModel value, $Res Function(ExpenseCategoryBreakdownModel) _then) = _$ExpenseCategoryBreakdownModelCopyWithImpl;
@useResult
$Res call({
 String name, String? icon,@DecimalConverter() double total, int count
});




}
/// @nodoc
class _$ExpenseCategoryBreakdownModelCopyWithImpl<$Res>
    implements $ExpenseCategoryBreakdownModelCopyWith<$Res> {
  _$ExpenseCategoryBreakdownModelCopyWithImpl(this._self, this._then);

  final ExpenseCategoryBreakdownModel _self;
  final $Res Function(ExpenseCategoryBreakdownModel) _then;

/// Create a copy of ExpenseCategoryBreakdownModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? icon = freezed,Object? total = null,Object? count = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseCategoryBreakdownModel].
extension ExpenseCategoryBreakdownModelPatterns on ExpenseCategoryBreakdownModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseCategoryBreakdownModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdownModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseCategoryBreakdownModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdownModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseCategoryBreakdownModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdownModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? icon, @DecimalConverter()  double total,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdownModel() when $default != null:
return $default(_that.name,_that.icon,_that.total,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? icon, @DecimalConverter()  double total,  int count)  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdownModel():
return $default(_that.name,_that.icon,_that.total,_that.count);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? icon, @DecimalConverter()  double total,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdownModel() when $default != null:
return $default(_that.name,_that.icon,_that.total,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseCategoryBreakdownModel implements ExpenseCategoryBreakdownModel {
  const _ExpenseCategoryBreakdownModel({required this.name, this.icon, @DecimalConverter() required this.total, required this.count});
  factory _ExpenseCategoryBreakdownModel.fromJson(Map<String, dynamic> json) => _$ExpenseCategoryBreakdownModelFromJson(json);

@override final  String name;
@override final  String? icon;
@override@DecimalConverter() final  double total;
@override final  int count;

/// Create a copy of ExpenseCategoryBreakdownModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCategoryBreakdownModelCopyWith<_ExpenseCategoryBreakdownModel> get copyWith => __$ExpenseCategoryBreakdownModelCopyWithImpl<_ExpenseCategoryBreakdownModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseCategoryBreakdownModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseCategoryBreakdownModel&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.total, total) || other.total == total)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,icon,total,count);

@override
String toString() {
  return 'ExpenseCategoryBreakdownModel(name: $name, icon: $icon, total: $total, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCategoryBreakdownModelCopyWith<$Res> implements $ExpenseCategoryBreakdownModelCopyWith<$Res> {
  factory _$ExpenseCategoryBreakdownModelCopyWith(_ExpenseCategoryBreakdownModel value, $Res Function(_ExpenseCategoryBreakdownModel) _then) = __$ExpenseCategoryBreakdownModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String? icon,@DecimalConverter() double total, int count
});




}
/// @nodoc
class __$ExpenseCategoryBreakdownModelCopyWithImpl<$Res>
    implements _$ExpenseCategoryBreakdownModelCopyWith<$Res> {
  __$ExpenseCategoryBreakdownModelCopyWithImpl(this._self, this._then);

  final _ExpenseCategoryBreakdownModel _self;
  final $Res Function(_ExpenseCategoryBreakdownModel) _then;

/// Create a copy of ExpenseCategoryBreakdownModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? icon = freezed,Object? total = null,Object? count = null,}) {
  return _then(_ExpenseCategoryBreakdownModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MemberBalanceModel {

 String get userId; String get name; String? get avatarUrl;@DecimalConverter() double get paid;@DecimalConverter() double get owes;@DecimalConverter() double get balance;
/// Create a copy of MemberBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberBalanceModelCopyWith<MemberBalanceModel> get copyWith => _$MemberBalanceModelCopyWithImpl<MemberBalanceModel>(this as MemberBalanceModel, _$identity);

  /// Serializes this MemberBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberBalanceModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.owes, owes) || other.owes == owes)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,avatarUrl,paid,owes,balance);

@override
String toString() {
  return 'MemberBalanceModel(userId: $userId, name: $name, avatarUrl: $avatarUrl, paid: $paid, owes: $owes, balance: $balance)';
}


}

/// @nodoc
abstract mixin class $MemberBalanceModelCopyWith<$Res>  {
  factory $MemberBalanceModelCopyWith(MemberBalanceModel value, $Res Function(MemberBalanceModel) _then) = _$MemberBalanceModelCopyWithImpl;
@useResult
$Res call({
 String userId, String name, String? avatarUrl,@DecimalConverter() double paid,@DecimalConverter() double owes,@DecimalConverter() double balance
});




}
/// @nodoc
class _$MemberBalanceModelCopyWithImpl<$Res>
    implements $MemberBalanceModelCopyWith<$Res> {
  _$MemberBalanceModelCopyWithImpl(this._self, this._then);

  final MemberBalanceModel _self;
  final $Res Function(MemberBalanceModel) _then;

/// Create a copy of MemberBalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? paid = null,Object? owes = null,Object? balance = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as double,owes: null == owes ? _self.owes : owes // ignore: cast_nullable_to_non_nullable
as double,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberBalanceModel].
extension MemberBalanceModelPatterns on MemberBalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberBalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberBalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberBalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberBalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberBalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberBalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String name,  String? avatarUrl, @DecimalConverter()  double paid, @DecimalConverter()  double owes, @DecimalConverter()  double balance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberBalanceModel() when $default != null:
return $default(_that.userId,_that.name,_that.avatarUrl,_that.paid,_that.owes,_that.balance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String name,  String? avatarUrl, @DecimalConverter()  double paid, @DecimalConverter()  double owes, @DecimalConverter()  double balance)  $default,) {final _that = this;
switch (_that) {
case _MemberBalanceModel():
return $default(_that.userId,_that.name,_that.avatarUrl,_that.paid,_that.owes,_that.balance);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String name,  String? avatarUrl, @DecimalConverter()  double paid, @DecimalConverter()  double owes, @DecimalConverter()  double balance)?  $default,) {final _that = this;
switch (_that) {
case _MemberBalanceModel() when $default != null:
return $default(_that.userId,_that.name,_that.avatarUrl,_that.paid,_that.owes,_that.balance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberBalanceModel implements MemberBalanceModel {
  const _MemberBalanceModel({required this.userId, required this.name, this.avatarUrl, @DecimalConverter() required this.paid, @DecimalConverter() required this.owes, @DecimalConverter() required this.balance});
  factory _MemberBalanceModel.fromJson(Map<String, dynamic> json) => _$MemberBalanceModelFromJson(json);

@override final  String userId;
@override final  String name;
@override final  String? avatarUrl;
@override@DecimalConverter() final  double paid;
@override@DecimalConverter() final  double owes;
@override@DecimalConverter() final  double balance;

/// Create a copy of MemberBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberBalanceModelCopyWith<_MemberBalanceModel> get copyWith => __$MemberBalanceModelCopyWithImpl<_MemberBalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberBalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberBalanceModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.owes, owes) || other.owes == owes)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,avatarUrl,paid,owes,balance);

@override
String toString() {
  return 'MemberBalanceModel(userId: $userId, name: $name, avatarUrl: $avatarUrl, paid: $paid, owes: $owes, balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$MemberBalanceModelCopyWith<$Res> implements $MemberBalanceModelCopyWith<$Res> {
  factory _$MemberBalanceModelCopyWith(_MemberBalanceModel value, $Res Function(_MemberBalanceModel) _then) = __$MemberBalanceModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String name, String? avatarUrl,@DecimalConverter() double paid,@DecimalConverter() double owes,@DecimalConverter() double balance
});




}
/// @nodoc
class __$MemberBalanceModelCopyWithImpl<$Res>
    implements _$MemberBalanceModelCopyWith<$Res> {
  __$MemberBalanceModelCopyWithImpl(this._self, this._then);

  final _MemberBalanceModel _self;
  final $Res Function(_MemberBalanceModel) _then;

/// Create a copy of MemberBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? paid = null,Object? owes = null,Object? balance = null,}) {
  return _then(_MemberBalanceModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as double,owes: null == owes ? _self.owes : owes // ignore: cast_nullable_to_non_nullable
as double,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SettlementModel {

 ExpenseUserModel get from; ExpenseUserModel get to;@DecimalConverter() double get amount;
/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementModelCopyWith<SettlementModel> get copyWith => _$SettlementModelCopyWithImpl<SettlementModel>(this as SettlementModel, _$identity);

  /// Serializes this SettlementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementModel&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,amount);

@override
String toString() {
  return 'SettlementModel(from: $from, to: $to, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $SettlementModelCopyWith<$Res>  {
  factory $SettlementModelCopyWith(SettlementModel value, $Res Function(SettlementModel) _then) = _$SettlementModelCopyWithImpl;
@useResult
$Res call({
 ExpenseUserModel from, ExpenseUserModel to,@DecimalConverter() double amount
});


$ExpenseUserModelCopyWith<$Res> get from;$ExpenseUserModelCopyWith<$Res> get to;

}
/// @nodoc
class _$SettlementModelCopyWithImpl<$Res>
    implements $SettlementModelCopyWith<$Res> {
  _$SettlementModelCopyWithImpl(this._self, this._then);

  final SettlementModel _self;
  final $Res Function(SettlementModel) _then;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? amount = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res> get from {
  
  return $ExpenseUserModelCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res> get to {
  
  return $ExpenseUserModelCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettlementModel].
extension SettlementModelPatterns on SettlementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementModel value)  $default,){
final _that = this;
switch (_that) {
case _SettlementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementModel value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExpenseUserModel from,  ExpenseUserModel to, @DecimalConverter()  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
return $default(_that.from,_that.to,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExpenseUserModel from,  ExpenseUserModel to, @DecimalConverter()  double amount)  $default,) {final _that = this;
switch (_that) {
case _SettlementModel():
return $default(_that.from,_that.to,_that.amount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExpenseUserModel from,  ExpenseUserModel to, @DecimalConverter()  double amount)?  $default,) {final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
return $default(_that.from,_that.to,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementModel implements SettlementModel {
  const _SettlementModel({required this.from, required this.to, @DecimalConverter() required this.amount});
  factory _SettlementModel.fromJson(Map<String, dynamic> json) => _$SettlementModelFromJson(json);

@override final  ExpenseUserModel from;
@override final  ExpenseUserModel to;
@override@DecimalConverter() final  double amount;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementModelCopyWith<_SettlementModel> get copyWith => __$SettlementModelCopyWithImpl<_SettlementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementModel&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,amount);

@override
String toString() {
  return 'SettlementModel(from: $from, to: $to, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$SettlementModelCopyWith<$Res> implements $SettlementModelCopyWith<$Res> {
  factory _$SettlementModelCopyWith(_SettlementModel value, $Res Function(_SettlementModel) _then) = __$SettlementModelCopyWithImpl;
@override @useResult
$Res call({
 ExpenseUserModel from, ExpenseUserModel to,@DecimalConverter() double amount
});


@override $ExpenseUserModelCopyWith<$Res> get from;@override $ExpenseUserModelCopyWith<$Res> get to;

}
/// @nodoc
class __$SettlementModelCopyWithImpl<$Res>
    implements _$SettlementModelCopyWith<$Res> {
  __$SettlementModelCopyWithImpl(this._self, this._then);

  final _SettlementModel _self;
  final $Res Function(_SettlementModel) _then;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? amount = null,}) {
  return _then(_SettlementModel(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res> get from {
  
  return $ExpenseUserModelCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res> get to {
  
  return $ExpenseUserModelCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// @nodoc
mixin _$ExpenseSummaryModel {

 ExpensePeriodModel get period;@DecimalConverter() double get totalAmount; int get expenseCount; List<ExpenseCategoryBreakdownModel> get byCategory; List<MemberBalanceModel> get memberBalances; List<SettlementModel> get settlements;
/// Create a copy of ExpenseSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSummaryModelCopyWith<ExpenseSummaryModel> get copyWith => _$ExpenseSummaryModelCopyWithImpl<ExpenseSummaryModel>(this as ExpenseSummaryModel, _$identity);

  /// Serializes this ExpenseSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummaryModel&&(identical(other.period, period) || other.period == period)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.expenseCount, expenseCount) || other.expenseCount == expenseCount)&&const DeepCollectionEquality().equals(other.byCategory, byCategory)&&const DeepCollectionEquality().equals(other.memberBalances, memberBalances)&&const DeepCollectionEquality().equals(other.settlements, settlements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,totalAmount,expenseCount,const DeepCollectionEquality().hash(byCategory),const DeepCollectionEquality().hash(memberBalances),const DeepCollectionEquality().hash(settlements));

@override
String toString() {
  return 'ExpenseSummaryModel(period: $period, totalAmount: $totalAmount, expenseCount: $expenseCount, byCategory: $byCategory, memberBalances: $memberBalances, settlements: $settlements)';
}


}

/// @nodoc
abstract mixin class $ExpenseSummaryModelCopyWith<$Res>  {
  factory $ExpenseSummaryModelCopyWith(ExpenseSummaryModel value, $Res Function(ExpenseSummaryModel) _then) = _$ExpenseSummaryModelCopyWithImpl;
@useResult
$Res call({
 ExpensePeriodModel period,@DecimalConverter() double totalAmount, int expenseCount, List<ExpenseCategoryBreakdownModel> byCategory, List<MemberBalanceModel> memberBalances, List<SettlementModel> settlements
});


$ExpensePeriodModelCopyWith<$Res> get period;

}
/// @nodoc
class _$ExpenseSummaryModelCopyWithImpl<$Res>
    implements $ExpenseSummaryModelCopyWith<$Res> {
  _$ExpenseSummaryModelCopyWithImpl(this._self, this._then);

  final ExpenseSummaryModel _self;
  final $Res Function(ExpenseSummaryModel) _then;

/// Create a copy of ExpenseSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? totalAmount = null,Object? expenseCount = null,Object? byCategory = null,Object? memberBalances = null,Object? settlements = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ExpensePeriodModel,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,expenseCount: null == expenseCount ? _self.expenseCount : expenseCount // ignore: cast_nullable_to_non_nullable
as int,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategoryBreakdownModel>,memberBalances: null == memberBalances ? _self.memberBalances : memberBalances // ignore: cast_nullable_to_non_nullable
as List<MemberBalanceModel>,settlements: null == settlements ? _self.settlements : settlements // ignore: cast_nullable_to_non_nullable
as List<SettlementModel>,
  ));
}
/// Create a copy of ExpenseSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpensePeriodModelCopyWith<$Res> get period {
  
  return $ExpensePeriodModelCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpenseSummaryModel].
extension ExpenseSummaryModelPatterns on ExpenseSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExpensePeriodModel period, @DecimalConverter()  double totalAmount,  int expenseCount,  List<ExpenseCategoryBreakdownModel> byCategory,  List<MemberBalanceModel> memberBalances,  List<SettlementModel> settlements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseSummaryModel() when $default != null:
return $default(_that.period,_that.totalAmount,_that.expenseCount,_that.byCategory,_that.memberBalances,_that.settlements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExpensePeriodModel period, @DecimalConverter()  double totalAmount,  int expenseCount,  List<ExpenseCategoryBreakdownModel> byCategory,  List<MemberBalanceModel> memberBalances,  List<SettlementModel> settlements)  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummaryModel():
return $default(_that.period,_that.totalAmount,_that.expenseCount,_that.byCategory,_that.memberBalances,_that.settlements);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExpensePeriodModel period, @DecimalConverter()  double totalAmount,  int expenseCount,  List<ExpenseCategoryBreakdownModel> byCategory,  List<MemberBalanceModel> memberBalances,  List<SettlementModel> settlements)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummaryModel() when $default != null:
return $default(_that.period,_that.totalAmount,_that.expenseCount,_that.byCategory,_that.memberBalances,_that.settlements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseSummaryModel implements ExpenseSummaryModel {
  const _ExpenseSummaryModel({required this.period, @DecimalConverter() required this.totalAmount, required this.expenseCount, final  List<ExpenseCategoryBreakdownModel> byCategory = const [], final  List<MemberBalanceModel> memberBalances = const [], final  List<SettlementModel> settlements = const []}): _byCategory = byCategory,_memberBalances = memberBalances,_settlements = settlements;
  factory _ExpenseSummaryModel.fromJson(Map<String, dynamic> json) => _$ExpenseSummaryModelFromJson(json);

@override final  ExpensePeriodModel period;
@override@DecimalConverter() final  double totalAmount;
@override final  int expenseCount;
 final  List<ExpenseCategoryBreakdownModel> _byCategory;
@override@JsonKey() List<ExpenseCategoryBreakdownModel> get byCategory {
  if (_byCategory is EqualUnmodifiableListView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byCategory);
}

 final  List<MemberBalanceModel> _memberBalances;
@override@JsonKey() List<MemberBalanceModel> get memberBalances {
  if (_memberBalances is EqualUnmodifiableListView) return _memberBalances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberBalances);
}

 final  List<SettlementModel> _settlements;
@override@JsonKey() List<SettlementModel> get settlements {
  if (_settlements is EqualUnmodifiableListView) return _settlements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_settlements);
}


/// Create a copy of ExpenseSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseSummaryModelCopyWith<_ExpenseSummaryModel> get copyWith => __$ExpenseSummaryModelCopyWithImpl<_ExpenseSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseSummaryModel&&(identical(other.period, period) || other.period == period)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.expenseCount, expenseCount) || other.expenseCount == expenseCount)&&const DeepCollectionEquality().equals(other._byCategory, _byCategory)&&const DeepCollectionEquality().equals(other._memberBalances, _memberBalances)&&const DeepCollectionEquality().equals(other._settlements, _settlements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,totalAmount,expenseCount,const DeepCollectionEquality().hash(_byCategory),const DeepCollectionEquality().hash(_memberBalances),const DeepCollectionEquality().hash(_settlements));

@override
String toString() {
  return 'ExpenseSummaryModel(period: $period, totalAmount: $totalAmount, expenseCount: $expenseCount, byCategory: $byCategory, memberBalances: $memberBalances, settlements: $settlements)';
}


}

/// @nodoc
abstract mixin class _$ExpenseSummaryModelCopyWith<$Res> implements $ExpenseSummaryModelCopyWith<$Res> {
  factory _$ExpenseSummaryModelCopyWith(_ExpenseSummaryModel value, $Res Function(_ExpenseSummaryModel) _then) = __$ExpenseSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 ExpensePeriodModel period,@DecimalConverter() double totalAmount, int expenseCount, List<ExpenseCategoryBreakdownModel> byCategory, List<MemberBalanceModel> memberBalances, List<SettlementModel> settlements
});


@override $ExpensePeriodModelCopyWith<$Res> get period;

}
/// @nodoc
class __$ExpenseSummaryModelCopyWithImpl<$Res>
    implements _$ExpenseSummaryModelCopyWith<$Res> {
  __$ExpenseSummaryModelCopyWithImpl(this._self, this._then);

  final _ExpenseSummaryModel _self;
  final $Res Function(_ExpenseSummaryModel) _then;

/// Create a copy of ExpenseSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? totalAmount = null,Object? expenseCount = null,Object? byCategory = null,Object? memberBalances = null,Object? settlements = null,}) {
  return _then(_ExpenseSummaryModel(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ExpensePeriodModel,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,expenseCount: null == expenseCount ? _self.expenseCount : expenseCount // ignore: cast_nullable_to_non_nullable
as int,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategoryBreakdownModel>,memberBalances: null == memberBalances ? _self._memberBalances : memberBalances // ignore: cast_nullable_to_non_nullable
as List<MemberBalanceModel>,settlements: null == settlements ? _self._settlements : settlements // ignore: cast_nullable_to_non_nullable
as List<SettlementModel>,
  ));
}

/// Create a copy of ExpenseSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpensePeriodModelCopyWith<$Res> get period {
  
  return $ExpensePeriodModelCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}


/// @nodoc
mixin _$SettlePeriodResultModel {

 int get settledCount; int get expensesAffected;
/// Create a copy of SettlePeriodResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlePeriodResultModelCopyWith<SettlePeriodResultModel> get copyWith => _$SettlePeriodResultModelCopyWithImpl<SettlePeriodResultModel>(this as SettlePeriodResultModel, _$identity);

  /// Serializes this SettlePeriodResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlePeriodResultModel&&(identical(other.settledCount, settledCount) || other.settledCount == settledCount)&&(identical(other.expensesAffected, expensesAffected) || other.expensesAffected == expensesAffected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,settledCount,expensesAffected);

@override
String toString() {
  return 'SettlePeriodResultModel(settledCount: $settledCount, expensesAffected: $expensesAffected)';
}


}

/// @nodoc
abstract mixin class $SettlePeriodResultModelCopyWith<$Res>  {
  factory $SettlePeriodResultModelCopyWith(SettlePeriodResultModel value, $Res Function(SettlePeriodResultModel) _then) = _$SettlePeriodResultModelCopyWithImpl;
@useResult
$Res call({
 int settledCount, int expensesAffected
});




}
/// @nodoc
class _$SettlePeriodResultModelCopyWithImpl<$Res>
    implements $SettlePeriodResultModelCopyWith<$Res> {
  _$SettlePeriodResultModelCopyWithImpl(this._self, this._then);

  final SettlePeriodResultModel _self;
  final $Res Function(SettlePeriodResultModel) _then;

/// Create a copy of SettlePeriodResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settledCount = null,Object? expensesAffected = null,}) {
  return _then(_self.copyWith(
settledCount: null == settledCount ? _self.settledCount : settledCount // ignore: cast_nullable_to_non_nullable
as int,expensesAffected: null == expensesAffected ? _self.expensesAffected : expensesAffected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlePeriodResultModel].
extension SettlePeriodResultModelPatterns on SettlePeriodResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlePeriodResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlePeriodResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlePeriodResultModel value)  $default,){
final _that = this;
switch (_that) {
case _SettlePeriodResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlePeriodResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _SettlePeriodResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int settledCount,  int expensesAffected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlePeriodResultModel() when $default != null:
return $default(_that.settledCount,_that.expensesAffected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int settledCount,  int expensesAffected)  $default,) {final _that = this;
switch (_that) {
case _SettlePeriodResultModel():
return $default(_that.settledCount,_that.expensesAffected);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int settledCount,  int expensesAffected)?  $default,) {final _that = this;
switch (_that) {
case _SettlePeriodResultModel() when $default != null:
return $default(_that.settledCount,_that.expensesAffected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlePeriodResultModel implements SettlePeriodResultModel {
  const _SettlePeriodResultModel({required this.settledCount, required this.expensesAffected});
  factory _SettlePeriodResultModel.fromJson(Map<String, dynamic> json) => _$SettlePeriodResultModelFromJson(json);

@override final  int settledCount;
@override final  int expensesAffected;

/// Create a copy of SettlePeriodResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlePeriodResultModelCopyWith<_SettlePeriodResultModel> get copyWith => __$SettlePeriodResultModelCopyWithImpl<_SettlePeriodResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlePeriodResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlePeriodResultModel&&(identical(other.settledCount, settledCount) || other.settledCount == settledCount)&&(identical(other.expensesAffected, expensesAffected) || other.expensesAffected == expensesAffected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,settledCount,expensesAffected);

@override
String toString() {
  return 'SettlePeriodResultModel(settledCount: $settledCount, expensesAffected: $expensesAffected)';
}


}

/// @nodoc
abstract mixin class _$SettlePeriodResultModelCopyWith<$Res> implements $SettlePeriodResultModelCopyWith<$Res> {
  factory _$SettlePeriodResultModelCopyWith(_SettlePeriodResultModel value, $Res Function(_SettlePeriodResultModel) _then) = __$SettlePeriodResultModelCopyWithImpl;
@override @useResult
$Res call({
 int settledCount, int expensesAffected
});




}
/// @nodoc
class __$SettlePeriodResultModelCopyWithImpl<$Res>
    implements _$SettlePeriodResultModelCopyWith<$Res> {
  __$SettlePeriodResultModelCopyWithImpl(this._self, this._then);

  final _SettlePeriodResultModel _self;
  final $Res Function(_SettlePeriodResultModel) _then;

/// Create a copy of SettlePeriodResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settledCount = null,Object? expensesAffected = null,}) {
  return _then(_SettlePeriodResultModel(
settledCount: null == settledCount ? _self.settledCount : settledCount // ignore: cast_nullable_to_non_nullable
as int,expensesAffected: null == expensesAffected ? _self.expensesAffected : expensesAffected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RecalculateSplitsResultModel {

 int get updatedCount; int get skippedCustom; int get total;
/// Create a copy of RecalculateSplitsResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecalculateSplitsResultModelCopyWith<RecalculateSplitsResultModel> get copyWith => _$RecalculateSplitsResultModelCopyWithImpl<RecalculateSplitsResultModel>(this as RecalculateSplitsResultModel, _$identity);

  /// Serializes this RecalculateSplitsResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecalculateSplitsResultModel&&(identical(other.updatedCount, updatedCount) || other.updatedCount == updatedCount)&&(identical(other.skippedCustom, skippedCustom) || other.skippedCustom == skippedCustom)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updatedCount,skippedCustom,total);

@override
String toString() {
  return 'RecalculateSplitsResultModel(updatedCount: $updatedCount, skippedCustom: $skippedCustom, total: $total)';
}


}

/// @nodoc
abstract mixin class $RecalculateSplitsResultModelCopyWith<$Res>  {
  factory $RecalculateSplitsResultModelCopyWith(RecalculateSplitsResultModel value, $Res Function(RecalculateSplitsResultModel) _then) = _$RecalculateSplitsResultModelCopyWithImpl;
@useResult
$Res call({
 int updatedCount, int skippedCustom, int total
});




}
/// @nodoc
class _$RecalculateSplitsResultModelCopyWithImpl<$Res>
    implements $RecalculateSplitsResultModelCopyWith<$Res> {
  _$RecalculateSplitsResultModelCopyWithImpl(this._self, this._then);

  final RecalculateSplitsResultModel _self;
  final $Res Function(RecalculateSplitsResultModel) _then;

/// Create a copy of RecalculateSplitsResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? updatedCount = null,Object? skippedCustom = null,Object? total = null,}) {
  return _then(_self.copyWith(
updatedCount: null == updatedCount ? _self.updatedCount : updatedCount // ignore: cast_nullable_to_non_nullable
as int,skippedCustom: null == skippedCustom ? _self.skippedCustom : skippedCustom // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecalculateSplitsResultModel].
extension RecalculateSplitsResultModelPatterns on RecalculateSplitsResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecalculateSplitsResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecalculateSplitsResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecalculateSplitsResultModel value)  $default,){
final _that = this;
switch (_that) {
case _RecalculateSplitsResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecalculateSplitsResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecalculateSplitsResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int updatedCount,  int skippedCustom,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecalculateSplitsResultModel() when $default != null:
return $default(_that.updatedCount,_that.skippedCustom,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int updatedCount,  int skippedCustom,  int total)  $default,) {final _that = this;
switch (_that) {
case _RecalculateSplitsResultModel():
return $default(_that.updatedCount,_that.skippedCustom,_that.total);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int updatedCount,  int skippedCustom,  int total)?  $default,) {final _that = this;
switch (_that) {
case _RecalculateSplitsResultModel() when $default != null:
return $default(_that.updatedCount,_that.skippedCustom,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecalculateSplitsResultModel implements RecalculateSplitsResultModel {
  const _RecalculateSplitsResultModel({required this.updatedCount, required this.skippedCustom, required this.total});
  factory _RecalculateSplitsResultModel.fromJson(Map<String, dynamic> json) => _$RecalculateSplitsResultModelFromJson(json);

@override final  int updatedCount;
@override final  int skippedCustom;
@override final  int total;

/// Create a copy of RecalculateSplitsResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecalculateSplitsResultModelCopyWith<_RecalculateSplitsResultModel> get copyWith => __$RecalculateSplitsResultModelCopyWithImpl<_RecalculateSplitsResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecalculateSplitsResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecalculateSplitsResultModel&&(identical(other.updatedCount, updatedCount) || other.updatedCount == updatedCount)&&(identical(other.skippedCustom, skippedCustom) || other.skippedCustom == skippedCustom)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updatedCount,skippedCustom,total);

@override
String toString() {
  return 'RecalculateSplitsResultModel(updatedCount: $updatedCount, skippedCustom: $skippedCustom, total: $total)';
}


}

/// @nodoc
abstract mixin class _$RecalculateSplitsResultModelCopyWith<$Res> implements $RecalculateSplitsResultModelCopyWith<$Res> {
  factory _$RecalculateSplitsResultModelCopyWith(_RecalculateSplitsResultModel value, $Res Function(_RecalculateSplitsResultModel) _then) = __$RecalculateSplitsResultModelCopyWithImpl;
@override @useResult
$Res call({
 int updatedCount, int skippedCustom, int total
});




}
/// @nodoc
class __$RecalculateSplitsResultModelCopyWithImpl<$Res>
    implements _$RecalculateSplitsResultModelCopyWith<$Res> {
  __$RecalculateSplitsResultModelCopyWithImpl(this._self, this._then);

  final _RecalculateSplitsResultModel _self;
  final $Res Function(_RecalculateSplitsResultModel) _then;

/// Create a copy of RecalculateSplitsResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? updatedCount = null,Object? skippedCustom = null,Object? total = null,}) {
  return _then(_RecalculateSplitsResultModel(
updatedCount: null == updatedCount ? _self.updatedCount : updatedCount // ignore: cast_nullable_to_non_nullable
as int,skippedCustom: null == skippedCustom ? _self.skippedCustom : skippedCustom // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RecurringExpenseModel {

 String get id; String get householdId; String get description;@DecimalConverter() double get amount; String get currency; String? get categoryId; ExpenseCategoryModel? get category; String get paidById; ExpenseUserModel? get paidBy; String get recurrence; DateTime get nextDueDate; bool get isActive; DateTime get createdAt;
/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringExpenseModelCopyWith<RecurringExpenseModel> get copyWith => _$RecurringExpenseModelCopyWithImpl<RecurringExpenseModel>(this as RecurringExpenseModel, _$identity);

  /// Serializes this RecurringExpenseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.category, category) || other.category == category)&&(identical(other.paidById, paidById) || other.paidById == paidById)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,description,amount,currency,categoryId,category,paidById,paidBy,recurrence,nextDueDate,isActive,createdAt);

@override
String toString() {
  return 'RecurringExpenseModel(id: $id, householdId: $householdId, description: $description, amount: $amount, currency: $currency, categoryId: $categoryId, category: $category, paidById: $paidById, paidBy: $paidBy, recurrence: $recurrence, nextDueDate: $nextDueDate, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RecurringExpenseModelCopyWith<$Res>  {
  factory $RecurringExpenseModelCopyWith(RecurringExpenseModel value, $Res Function(RecurringExpenseModel) _then) = _$RecurringExpenseModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String description,@DecimalConverter() double amount, String currency, String? categoryId, ExpenseCategoryModel? category, String paidById, ExpenseUserModel? paidBy, String recurrence, DateTime nextDueDate, bool isActive, DateTime createdAt
});


$ExpenseCategoryModelCopyWith<$Res>? get category;$ExpenseUserModelCopyWith<$Res>? get paidBy;

}
/// @nodoc
class _$RecurringExpenseModelCopyWithImpl<$Res>
    implements $RecurringExpenseModelCopyWith<$Res> {
  _$RecurringExpenseModelCopyWithImpl(this._self, this._then);

  final RecurringExpenseModel _self;
  final $Res Function(RecurringExpenseModel) _then;

/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? description = null,Object? amount = null,Object? currency = null,Object? categoryId = freezed,Object? category = freezed,Object? paidById = null,Object? paidBy = freezed,Object? recurrence = null,Object? nextDueDate = null,Object? isActive = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategoryModel?,paidById: null == paidById ? _self.paidById : paidById // ignore: cast_nullable_to_non_nullable
as String,paidBy: freezed == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel?,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as String,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ExpenseCategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res>? get paidBy {
    if (_self.paidBy == null) {
    return null;
  }

  return $ExpenseUserModelCopyWith<$Res>(_self.paidBy!, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecurringExpenseModel].
extension RecurringExpenseModelPatterns on RecurringExpenseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringExpenseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringExpenseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringExpenseModel value)  $default,){
final _that = this;
switch (_that) {
case _RecurringExpenseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringExpenseModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringExpenseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String description, @DecimalConverter()  double amount,  String currency,  String? categoryId,  ExpenseCategoryModel? category,  String paidById,  ExpenseUserModel? paidBy,  String recurrence,  DateTime nextDueDate,  bool isActive,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringExpenseModel() when $default != null:
return $default(_that.id,_that.householdId,_that.description,_that.amount,_that.currency,_that.categoryId,_that.category,_that.paidById,_that.paidBy,_that.recurrence,_that.nextDueDate,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String description, @DecimalConverter()  double amount,  String currency,  String? categoryId,  ExpenseCategoryModel? category,  String paidById,  ExpenseUserModel? paidBy,  String recurrence,  DateTime nextDueDate,  bool isActive,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _RecurringExpenseModel():
return $default(_that.id,_that.householdId,_that.description,_that.amount,_that.currency,_that.categoryId,_that.category,_that.paidById,_that.paidBy,_that.recurrence,_that.nextDueDate,_that.isActive,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String description, @DecimalConverter()  double amount,  String currency,  String? categoryId,  ExpenseCategoryModel? category,  String paidById,  ExpenseUserModel? paidBy,  String recurrence,  DateTime nextDueDate,  bool isActive,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RecurringExpenseModel() when $default != null:
return $default(_that.id,_that.householdId,_that.description,_that.amount,_that.currency,_that.categoryId,_that.category,_that.paidById,_that.paidBy,_that.recurrence,_that.nextDueDate,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecurringExpenseModel implements RecurringExpenseModel {
  const _RecurringExpenseModel({required this.id, required this.householdId, required this.description, @DecimalConverter() required this.amount, this.currency = 'ARS', this.categoryId, this.category, required this.paidById, this.paidBy, required this.recurrence, required this.nextDueDate, this.isActive = true, required this.createdAt});
  factory _RecurringExpenseModel.fromJson(Map<String, dynamic> json) => _$RecurringExpenseModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String description;
@override@DecimalConverter() final  double amount;
@override@JsonKey() final  String currency;
@override final  String? categoryId;
@override final  ExpenseCategoryModel? category;
@override final  String paidById;
@override final  ExpenseUserModel? paidBy;
@override final  String recurrence;
@override final  DateTime nextDueDate;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;

/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringExpenseModelCopyWith<_RecurringExpenseModel> get copyWith => __$RecurringExpenseModelCopyWithImpl<_RecurringExpenseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurringExpenseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.category, category) || other.category == category)&&(identical(other.paidById, paidById) || other.paidById == paidById)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,description,amount,currency,categoryId,category,paidById,paidBy,recurrence,nextDueDate,isActive,createdAt);

@override
String toString() {
  return 'RecurringExpenseModel(id: $id, householdId: $householdId, description: $description, amount: $amount, currency: $currency, categoryId: $categoryId, category: $category, paidById: $paidById, paidBy: $paidBy, recurrence: $recurrence, nextDueDate: $nextDueDate, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RecurringExpenseModelCopyWith<$Res> implements $RecurringExpenseModelCopyWith<$Res> {
  factory _$RecurringExpenseModelCopyWith(_RecurringExpenseModel value, $Res Function(_RecurringExpenseModel) _then) = __$RecurringExpenseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String description,@DecimalConverter() double amount, String currency, String? categoryId, ExpenseCategoryModel? category, String paidById, ExpenseUserModel? paidBy, String recurrence, DateTime nextDueDate, bool isActive, DateTime createdAt
});


@override $ExpenseCategoryModelCopyWith<$Res>? get category;@override $ExpenseUserModelCopyWith<$Res>? get paidBy;

}
/// @nodoc
class __$RecurringExpenseModelCopyWithImpl<$Res>
    implements _$RecurringExpenseModelCopyWith<$Res> {
  __$RecurringExpenseModelCopyWithImpl(this._self, this._then);

  final _RecurringExpenseModel _self;
  final $Res Function(_RecurringExpenseModel) _then;

/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? description = null,Object? amount = null,Object? currency = null,Object? categoryId = freezed,Object? category = freezed,Object? paidById = null,Object? paidBy = freezed,Object? recurrence = null,Object? nextDueDate = null,Object? isActive = null,Object? createdAt = null,}) {
  return _then(_RecurringExpenseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategoryModel?,paidById: null == paidById ? _self.paidById : paidById // ignore: cast_nullable_to_non_nullable
as String,paidBy: freezed == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as ExpenseUserModel?,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as String,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ExpenseCategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of RecurringExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseUserModelCopyWith<$Res>? get paidBy {
    if (_self.paidBy == null) {
    return null;
  }

  return $ExpenseUserModelCopyWith<$Res>(_self.paidBy!, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}
}


/// @nodoc
mixin _$ExpenseBudgetModel {

 String get id; String get householdId; String get categoryId; ExpenseCategoryModel? get category;@DecimalConverter() double get monthlyLimit; int get month; int get year; DateTime get createdAt;
/// Create a copy of ExpenseBudgetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseBudgetModelCopyWith<ExpenseBudgetModel> get copyWith => _$ExpenseBudgetModelCopyWithImpl<ExpenseBudgetModel>(this as ExpenseBudgetModel, _$identity);

  /// Serializes this ExpenseBudgetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseBudgetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.category, category) || other.category == category)&&(identical(other.monthlyLimit, monthlyLimit) || other.monthlyLimit == monthlyLimit)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,categoryId,category,monthlyLimit,month,year,createdAt);

@override
String toString() {
  return 'ExpenseBudgetModel(id: $id, householdId: $householdId, categoryId: $categoryId, category: $category, monthlyLimit: $monthlyLimit, month: $month, year: $year, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ExpenseBudgetModelCopyWith<$Res>  {
  factory $ExpenseBudgetModelCopyWith(ExpenseBudgetModel value, $Res Function(ExpenseBudgetModel) _then) = _$ExpenseBudgetModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String categoryId, ExpenseCategoryModel? category,@DecimalConverter() double monthlyLimit, int month, int year, DateTime createdAt
});


$ExpenseCategoryModelCopyWith<$Res>? get category;

}
/// @nodoc
class _$ExpenseBudgetModelCopyWithImpl<$Res>
    implements $ExpenseBudgetModelCopyWith<$Res> {
  _$ExpenseBudgetModelCopyWithImpl(this._self, this._then);

  final ExpenseBudgetModel _self;
  final $Res Function(ExpenseBudgetModel) _then;

/// Create a copy of ExpenseBudgetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? categoryId = null,Object? category = freezed,Object? monthlyLimit = null,Object? month = null,Object? year = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategoryModel?,monthlyLimit: null == monthlyLimit ? _self.monthlyLimit : monthlyLimit // ignore: cast_nullable_to_non_nullable
as double,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ExpenseBudgetModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ExpenseCategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpenseBudgetModel].
extension ExpenseBudgetModelPatterns on ExpenseBudgetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseBudgetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseBudgetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseBudgetModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseBudgetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseBudgetModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseBudgetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String categoryId,  ExpenseCategoryModel? category, @DecimalConverter()  double monthlyLimit,  int month,  int year,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseBudgetModel() when $default != null:
return $default(_that.id,_that.householdId,_that.categoryId,_that.category,_that.monthlyLimit,_that.month,_that.year,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String categoryId,  ExpenseCategoryModel? category, @DecimalConverter()  double monthlyLimit,  int month,  int year,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ExpenseBudgetModel():
return $default(_that.id,_that.householdId,_that.categoryId,_that.category,_that.monthlyLimit,_that.month,_that.year,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String categoryId,  ExpenseCategoryModel? category, @DecimalConverter()  double monthlyLimit,  int month,  int year,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseBudgetModel() when $default != null:
return $default(_that.id,_that.householdId,_that.categoryId,_that.category,_that.monthlyLimit,_that.month,_that.year,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseBudgetModel implements ExpenseBudgetModel {
  const _ExpenseBudgetModel({required this.id, required this.householdId, required this.categoryId, this.category, @DecimalConverter() required this.monthlyLimit, required this.month, required this.year, required this.createdAt});
  factory _ExpenseBudgetModel.fromJson(Map<String, dynamic> json) => _$ExpenseBudgetModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String categoryId;
@override final  ExpenseCategoryModel? category;
@override@DecimalConverter() final  double monthlyLimit;
@override final  int month;
@override final  int year;
@override final  DateTime createdAt;

/// Create a copy of ExpenseBudgetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseBudgetModelCopyWith<_ExpenseBudgetModel> get copyWith => __$ExpenseBudgetModelCopyWithImpl<_ExpenseBudgetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseBudgetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseBudgetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.category, category) || other.category == category)&&(identical(other.monthlyLimit, monthlyLimit) || other.monthlyLimit == monthlyLimit)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,categoryId,category,monthlyLimit,month,year,createdAt);

@override
String toString() {
  return 'ExpenseBudgetModel(id: $id, householdId: $householdId, categoryId: $categoryId, category: $category, monthlyLimit: $monthlyLimit, month: $month, year: $year, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ExpenseBudgetModelCopyWith<$Res> implements $ExpenseBudgetModelCopyWith<$Res> {
  factory _$ExpenseBudgetModelCopyWith(_ExpenseBudgetModel value, $Res Function(_ExpenseBudgetModel) _then) = __$ExpenseBudgetModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String categoryId, ExpenseCategoryModel? category,@DecimalConverter() double monthlyLimit, int month, int year, DateTime createdAt
});


@override $ExpenseCategoryModelCopyWith<$Res>? get category;

}
/// @nodoc
class __$ExpenseBudgetModelCopyWithImpl<$Res>
    implements _$ExpenseBudgetModelCopyWith<$Res> {
  __$ExpenseBudgetModelCopyWithImpl(this._self, this._then);

  final _ExpenseBudgetModel _self;
  final $Res Function(_ExpenseBudgetModel) _then;

/// Create a copy of ExpenseBudgetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? categoryId = null,Object? category = freezed,Object? monthlyLimit = null,Object? month = null,Object? year = null,Object? createdAt = null,}) {
  return _then(_ExpenseBudgetModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategoryModel?,monthlyLimit: null == monthlyLimit ? _self.monthlyLimit : monthlyLimit // ignore: cast_nullable_to_non_nullable
as double,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ExpenseBudgetModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $ExpenseCategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// @nodoc
mixin _$BudgetStatusModel {

 String get categoryId; String get categoryName;@DecimalConverter() double get budgetLimit;@DecimalConverter() double get actualSpent;@DecimalConverter() double get remaining; double get percentUsed;
/// Create a copy of BudgetStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetStatusModelCopyWith<BudgetStatusModel> get copyWith => _$BudgetStatusModelCopyWithImpl<BudgetStatusModel>(this as BudgetStatusModel, _$identity);

  /// Serializes this BudgetStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetStatusModel&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.budgetLimit, budgetLimit) || other.budgetLimit == budgetLimit)&&(identical(other.actualSpent, actualSpent) || other.actualSpent == actualSpent)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.percentUsed, percentUsed) || other.percentUsed == percentUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,budgetLimit,actualSpent,remaining,percentUsed);

@override
String toString() {
  return 'BudgetStatusModel(categoryId: $categoryId, categoryName: $categoryName, budgetLimit: $budgetLimit, actualSpent: $actualSpent, remaining: $remaining, percentUsed: $percentUsed)';
}


}

/// @nodoc
abstract mixin class $BudgetStatusModelCopyWith<$Res>  {
  factory $BudgetStatusModelCopyWith(BudgetStatusModel value, $Res Function(BudgetStatusModel) _then) = _$BudgetStatusModelCopyWithImpl;
@useResult
$Res call({
 String categoryId, String categoryName,@DecimalConverter() double budgetLimit,@DecimalConverter() double actualSpent,@DecimalConverter() double remaining, double percentUsed
});




}
/// @nodoc
class _$BudgetStatusModelCopyWithImpl<$Res>
    implements $BudgetStatusModelCopyWith<$Res> {
  _$BudgetStatusModelCopyWithImpl(this._self, this._then);

  final BudgetStatusModel _self;
  final $Res Function(BudgetStatusModel) _then;

/// Create a copy of BudgetStatusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? categoryName = null,Object? budgetLimit = null,Object? actualSpent = null,Object? remaining = null,Object? percentUsed = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,budgetLimit: null == budgetLimit ? _self.budgetLimit : budgetLimit // ignore: cast_nullable_to_non_nullable
as double,actualSpent: null == actualSpent ? _self.actualSpent : actualSpent // ignore: cast_nullable_to_non_nullable
as double,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as double,percentUsed: null == percentUsed ? _self.percentUsed : percentUsed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetStatusModel].
extension BudgetStatusModelPatterns on BudgetStatusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetStatusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _BudgetStatusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetStatusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  String categoryName, @DecimalConverter()  double budgetLimit, @DecimalConverter()  double actualSpent, @DecimalConverter()  double remaining,  double percentUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetStatusModel() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.budgetLimit,_that.actualSpent,_that.remaining,_that.percentUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  String categoryName, @DecimalConverter()  double budgetLimit, @DecimalConverter()  double actualSpent, @DecimalConverter()  double remaining,  double percentUsed)  $default,) {final _that = this;
switch (_that) {
case _BudgetStatusModel():
return $default(_that.categoryId,_that.categoryName,_that.budgetLimit,_that.actualSpent,_that.remaining,_that.percentUsed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  String categoryName, @DecimalConverter()  double budgetLimit, @DecimalConverter()  double actualSpent, @DecimalConverter()  double remaining,  double percentUsed)?  $default,) {final _that = this;
switch (_that) {
case _BudgetStatusModel() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.budgetLimit,_that.actualSpent,_that.remaining,_that.percentUsed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetStatusModel implements BudgetStatusModel {
  const _BudgetStatusModel({required this.categoryId, required this.categoryName, @DecimalConverter() required this.budgetLimit, @DecimalConverter() required this.actualSpent, @DecimalConverter() required this.remaining, required this.percentUsed});
  factory _BudgetStatusModel.fromJson(Map<String, dynamic> json) => _$BudgetStatusModelFromJson(json);

@override final  String categoryId;
@override final  String categoryName;
@override@DecimalConverter() final  double budgetLimit;
@override@DecimalConverter() final  double actualSpent;
@override@DecimalConverter() final  double remaining;
@override final  double percentUsed;

/// Create a copy of BudgetStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetStatusModelCopyWith<_BudgetStatusModel> get copyWith => __$BudgetStatusModelCopyWithImpl<_BudgetStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetStatusModel&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.budgetLimit, budgetLimit) || other.budgetLimit == budgetLimit)&&(identical(other.actualSpent, actualSpent) || other.actualSpent == actualSpent)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.percentUsed, percentUsed) || other.percentUsed == percentUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,budgetLimit,actualSpent,remaining,percentUsed);

@override
String toString() {
  return 'BudgetStatusModel(categoryId: $categoryId, categoryName: $categoryName, budgetLimit: $budgetLimit, actualSpent: $actualSpent, remaining: $remaining, percentUsed: $percentUsed)';
}


}

/// @nodoc
abstract mixin class _$BudgetStatusModelCopyWith<$Res> implements $BudgetStatusModelCopyWith<$Res> {
  factory _$BudgetStatusModelCopyWith(_BudgetStatusModel value, $Res Function(_BudgetStatusModel) _then) = __$BudgetStatusModelCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String categoryName,@DecimalConverter() double budgetLimit,@DecimalConverter() double actualSpent,@DecimalConverter() double remaining, double percentUsed
});




}
/// @nodoc
class __$BudgetStatusModelCopyWithImpl<$Res>
    implements _$BudgetStatusModelCopyWith<$Res> {
  __$BudgetStatusModelCopyWithImpl(this._self, this._then);

  final _BudgetStatusModel _self;
  final $Res Function(_BudgetStatusModel) _then;

/// Create a copy of BudgetStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? categoryName = null,Object? budgetLimit = null,Object? actualSpent = null,Object? remaining = null,Object? percentUsed = null,}) {
  return _then(_BudgetStatusModel(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,budgetLimit: null == budgetLimit ? _self.budgetLimit : budgetLimit // ignore: cast_nullable_to_non_nullable
as double,actualSpent: null == actualSpent ? _self.actualSpent : actualSpent // ignore: cast_nullable_to_non_nullable
as double,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as double,percentUsed: null == percentUsed ? _self.percentUsed : percentUsed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ExpenseTrendModel {

 int get month; int get year;@DecimalConverter() double get total; List<ExpenseCategoryBreakdownModel> get byCategory;
/// Create a copy of ExpenseTrendModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseTrendModelCopyWith<ExpenseTrendModel> get copyWith => _$ExpenseTrendModelCopyWithImpl<ExpenseTrendModel>(this as ExpenseTrendModel, _$identity);

  /// Serializes this ExpenseTrendModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseTrendModel&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.byCategory, byCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,year,total,const DeepCollectionEquality().hash(byCategory));

@override
String toString() {
  return 'ExpenseTrendModel(month: $month, year: $year, total: $total, byCategory: $byCategory)';
}


}

/// @nodoc
abstract mixin class $ExpenseTrendModelCopyWith<$Res>  {
  factory $ExpenseTrendModelCopyWith(ExpenseTrendModel value, $Res Function(ExpenseTrendModel) _then) = _$ExpenseTrendModelCopyWithImpl;
@useResult
$Res call({
 int month, int year,@DecimalConverter() double total, List<ExpenseCategoryBreakdownModel> byCategory
});




}
/// @nodoc
class _$ExpenseTrendModelCopyWithImpl<$Res>
    implements $ExpenseTrendModelCopyWith<$Res> {
  _$ExpenseTrendModelCopyWithImpl(this._self, this._then);

  final ExpenseTrendModel _self;
  final $Res Function(ExpenseTrendModel) _then;

/// Create a copy of ExpenseTrendModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? year = null,Object? total = null,Object? byCategory = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategoryBreakdownModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseTrendModel].
extension ExpenseTrendModelPatterns on ExpenseTrendModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseTrendModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseTrendModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseTrendModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseTrendModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseTrendModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseTrendModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int month,  int year, @DecimalConverter()  double total,  List<ExpenseCategoryBreakdownModel> byCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseTrendModel() when $default != null:
return $default(_that.month,_that.year,_that.total,_that.byCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int month,  int year, @DecimalConverter()  double total,  List<ExpenseCategoryBreakdownModel> byCategory)  $default,) {final _that = this;
switch (_that) {
case _ExpenseTrendModel():
return $default(_that.month,_that.year,_that.total,_that.byCategory);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int month,  int year, @DecimalConverter()  double total,  List<ExpenseCategoryBreakdownModel> byCategory)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseTrendModel() when $default != null:
return $default(_that.month,_that.year,_that.total,_that.byCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseTrendModel implements ExpenseTrendModel {
  const _ExpenseTrendModel({required this.month, required this.year, @DecimalConverter() required this.total, required final  List<ExpenseCategoryBreakdownModel> byCategory}): _byCategory = byCategory;
  factory _ExpenseTrendModel.fromJson(Map<String, dynamic> json) => _$ExpenseTrendModelFromJson(json);

@override final  int month;
@override final  int year;
@override@DecimalConverter() final  double total;
 final  List<ExpenseCategoryBreakdownModel> _byCategory;
@override List<ExpenseCategoryBreakdownModel> get byCategory {
  if (_byCategory is EqualUnmodifiableListView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byCategory);
}


/// Create a copy of ExpenseTrendModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseTrendModelCopyWith<_ExpenseTrendModel> get copyWith => __$ExpenseTrendModelCopyWithImpl<_ExpenseTrendModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseTrendModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseTrendModel&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._byCategory, _byCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,year,total,const DeepCollectionEquality().hash(_byCategory));

@override
String toString() {
  return 'ExpenseTrendModel(month: $month, year: $year, total: $total, byCategory: $byCategory)';
}


}

/// @nodoc
abstract mixin class _$ExpenseTrendModelCopyWith<$Res> implements $ExpenseTrendModelCopyWith<$Res> {
  factory _$ExpenseTrendModelCopyWith(_ExpenseTrendModel value, $Res Function(_ExpenseTrendModel) _then) = __$ExpenseTrendModelCopyWithImpl;
@override @useResult
$Res call({
 int month, int year,@DecimalConverter() double total, List<ExpenseCategoryBreakdownModel> byCategory
});




}
/// @nodoc
class __$ExpenseTrendModelCopyWithImpl<$Res>
    implements _$ExpenseTrendModelCopyWith<$Res> {
  __$ExpenseTrendModelCopyWithImpl(this._self, this._then);

  final _ExpenseTrendModel _self;
  final $Res Function(_ExpenseTrendModel) _then;

/// Create a copy of ExpenseTrendModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,Object? total = null,Object? byCategory = null,}) {
  return _then(_ExpenseTrendModel(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategoryBreakdownModel>,
  ));
}


}

// dart format on
