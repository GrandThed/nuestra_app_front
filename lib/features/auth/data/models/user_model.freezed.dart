// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String get email; String get name; String? get avatarUrl; String get provider; DateTime get createdAt; List<HouseholdMembershipModel>? get householdMembers;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.householdMembers, householdMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name,avatarUrl,provider,createdAt,const DeepCollectionEquality().hash(householdMembers));

@override
String toString() {
  return 'UserModel(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, provider: $provider, createdAt: $createdAt, householdMembers: $householdMembers)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String email, String name, String? avatarUrl, String provider, DateTime createdAt, List<HouseholdMembershipModel>? householdMembers
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? name = null,Object? avatarUrl = freezed,Object? provider = null,Object? createdAt = null,Object? householdMembers = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,householdMembers: freezed == householdMembers ? _self.householdMembers : householdMembers // ignore: cast_nullable_to_non_nullable
as List<HouseholdMembershipModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String name,  String? avatarUrl,  String provider,  DateTime createdAt,  List<HouseholdMembershipModel>? householdMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.provider,_that.createdAt,_that.householdMembers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String name,  String? avatarUrl,  String provider,  DateTime createdAt,  List<HouseholdMembershipModel>? householdMembers)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.provider,_that.createdAt,_that.householdMembers);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String name,  String? avatarUrl,  String provider,  DateTime createdAt,  List<HouseholdMembershipModel>? householdMembers)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.provider,_that.createdAt,_that.householdMembers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.email, required this.name, this.avatarUrl, required this.provider, required this.createdAt, final  List<HouseholdMembershipModel>? householdMembers}): _householdMembers = householdMembers;
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String email;
@override final  String name;
@override final  String? avatarUrl;
@override final  String provider;
@override final  DateTime createdAt;
 final  List<HouseholdMembershipModel>? _householdMembers;
@override List<HouseholdMembershipModel>? get householdMembers {
  final value = _householdMembers;
  if (value == null) return null;
  if (_householdMembers is EqualUnmodifiableListView) return _householdMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._householdMembers, _householdMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name,avatarUrl,provider,createdAt,const DeepCollectionEquality().hash(_householdMembers));

@override
String toString() {
  return 'UserModel(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, provider: $provider, createdAt: $createdAt, householdMembers: $householdMembers)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String name, String? avatarUrl, String provider, DateTime createdAt, List<HouseholdMembershipModel>? householdMembers
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? name = null,Object? avatarUrl = freezed,Object? provider = null,Object? createdAt = null,Object? householdMembers = freezed,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,householdMembers: freezed == householdMembers ? _self._householdMembers : householdMembers // ignore: cast_nullable_to_non_nullable
as List<HouseholdMembershipModel>?,
  ));
}


}


/// @nodoc
mixin _$HouseholdMembershipModel {

 String get oderId; String get odehouseholdId; String get role; double? get monthlyIncome; DateTime get joinedAt; HouseholdBasicModel? get household;
/// Create a copy of HouseholdMembershipModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseholdMembershipModelCopyWith<HouseholdMembershipModel> get copyWith => _$HouseholdMembershipModelCopyWithImpl<HouseholdMembershipModel>(this as HouseholdMembershipModel, _$identity);

  /// Serializes this HouseholdMembershipModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdMembershipModel&&(identical(other.oderId, oderId) || other.oderId == oderId)&&(identical(other.odehouseholdId, odehouseholdId) || other.odehouseholdId == odehouseholdId)&&(identical(other.role, role) || other.role == role)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.household, household) || other.household == household));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oderId,odehouseholdId,role,monthlyIncome,joinedAt,household);

@override
String toString() {
  return 'HouseholdMembershipModel(oderId: $oderId, odehouseholdId: $odehouseholdId, role: $role, monthlyIncome: $monthlyIncome, joinedAt: $joinedAt, household: $household)';
}


}

/// @nodoc
abstract mixin class $HouseholdMembershipModelCopyWith<$Res>  {
  factory $HouseholdMembershipModelCopyWith(HouseholdMembershipModel value, $Res Function(HouseholdMembershipModel) _then) = _$HouseholdMembershipModelCopyWithImpl;
@useResult
$Res call({
 String oderId, String odehouseholdId, String role, double? monthlyIncome, DateTime joinedAt, HouseholdBasicModel? household
});


$HouseholdBasicModelCopyWith<$Res>? get household;

}
/// @nodoc
class _$HouseholdMembershipModelCopyWithImpl<$Res>
    implements $HouseholdMembershipModelCopyWith<$Res> {
  _$HouseholdMembershipModelCopyWithImpl(this._self, this._then);

  final HouseholdMembershipModel _self;
  final $Res Function(HouseholdMembershipModel) _then;

/// Create a copy of HouseholdMembershipModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oderId = null,Object? odehouseholdId = null,Object? role = null,Object? monthlyIncome = freezed,Object? joinedAt = null,Object? household = freezed,}) {
  return _then(_self.copyWith(
oderId: null == oderId ? _self.oderId : oderId // ignore: cast_nullable_to_non_nullable
as String,odehouseholdId: null == odehouseholdId ? _self.odehouseholdId : odehouseholdId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,monthlyIncome: freezed == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,household: freezed == household ? _self.household : household // ignore: cast_nullable_to_non_nullable
as HouseholdBasicModel?,
  ));
}
/// Create a copy of HouseholdMembershipModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HouseholdBasicModelCopyWith<$Res>? get household {
    if (_self.household == null) {
    return null;
  }

  return $HouseholdBasicModelCopyWith<$Res>(_self.household!, (value) {
    return _then(_self.copyWith(household: value));
  });
}
}


/// Adds pattern-matching-related methods to [HouseholdMembershipModel].
extension HouseholdMembershipModelPatterns on HouseholdMembershipModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HouseholdMembershipModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HouseholdMembershipModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HouseholdMembershipModel value)  $default,){
final _that = this;
switch (_that) {
case _HouseholdMembershipModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HouseholdMembershipModel value)?  $default,){
final _that = this;
switch (_that) {
case _HouseholdMembershipModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String oderId,  String odehouseholdId,  String role,  double? monthlyIncome,  DateTime joinedAt,  HouseholdBasicModel? household)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HouseholdMembershipModel() when $default != null:
return $default(_that.oderId,_that.odehouseholdId,_that.role,_that.monthlyIncome,_that.joinedAt,_that.household);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String oderId,  String odehouseholdId,  String role,  double? monthlyIncome,  DateTime joinedAt,  HouseholdBasicModel? household)  $default,) {final _that = this;
switch (_that) {
case _HouseholdMembershipModel():
return $default(_that.oderId,_that.odehouseholdId,_that.role,_that.monthlyIncome,_that.joinedAt,_that.household);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String oderId,  String odehouseholdId,  String role,  double? monthlyIncome,  DateTime joinedAt,  HouseholdBasicModel? household)?  $default,) {final _that = this;
switch (_that) {
case _HouseholdMembershipModel() when $default != null:
return $default(_that.oderId,_that.odehouseholdId,_that.role,_that.monthlyIncome,_that.joinedAt,_that.household);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HouseholdMembershipModel implements HouseholdMembershipModel {
  const _HouseholdMembershipModel({required this.oderId, required this.odehouseholdId, required this.role, this.monthlyIncome, required this.joinedAt, this.household});
  factory _HouseholdMembershipModel.fromJson(Map<String, dynamic> json) => _$HouseholdMembershipModelFromJson(json);

@override final  String oderId;
@override final  String odehouseholdId;
@override final  String role;
@override final  double? monthlyIncome;
@override final  DateTime joinedAt;
@override final  HouseholdBasicModel? household;

/// Create a copy of HouseholdMembershipModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseholdMembershipModelCopyWith<_HouseholdMembershipModel> get copyWith => __$HouseholdMembershipModelCopyWithImpl<_HouseholdMembershipModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HouseholdMembershipModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HouseholdMembershipModel&&(identical(other.oderId, oderId) || other.oderId == oderId)&&(identical(other.odehouseholdId, odehouseholdId) || other.odehouseholdId == odehouseholdId)&&(identical(other.role, role) || other.role == role)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.household, household) || other.household == household));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oderId,odehouseholdId,role,monthlyIncome,joinedAt,household);

@override
String toString() {
  return 'HouseholdMembershipModel(oderId: $oderId, odehouseholdId: $odehouseholdId, role: $role, monthlyIncome: $monthlyIncome, joinedAt: $joinedAt, household: $household)';
}


}

/// @nodoc
abstract mixin class _$HouseholdMembershipModelCopyWith<$Res> implements $HouseholdMembershipModelCopyWith<$Res> {
  factory _$HouseholdMembershipModelCopyWith(_HouseholdMembershipModel value, $Res Function(_HouseholdMembershipModel) _then) = __$HouseholdMembershipModelCopyWithImpl;
@override @useResult
$Res call({
 String oderId, String odehouseholdId, String role, double? monthlyIncome, DateTime joinedAt, HouseholdBasicModel? household
});


@override $HouseholdBasicModelCopyWith<$Res>? get household;

}
/// @nodoc
class __$HouseholdMembershipModelCopyWithImpl<$Res>
    implements _$HouseholdMembershipModelCopyWith<$Res> {
  __$HouseholdMembershipModelCopyWithImpl(this._self, this._then);

  final _HouseholdMembershipModel _self;
  final $Res Function(_HouseholdMembershipModel) _then;

/// Create a copy of HouseholdMembershipModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oderId = null,Object? odehouseholdId = null,Object? role = null,Object? monthlyIncome = freezed,Object? joinedAt = null,Object? household = freezed,}) {
  return _then(_HouseholdMembershipModel(
oderId: null == oderId ? _self.oderId : oderId // ignore: cast_nullable_to_non_nullable
as String,odehouseholdId: null == odehouseholdId ? _self.odehouseholdId : odehouseholdId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,monthlyIncome: freezed == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,household: freezed == household ? _self.household : household // ignore: cast_nullable_to_non_nullable
as HouseholdBasicModel?,
  ));
}

/// Create a copy of HouseholdMembershipModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HouseholdBasicModelCopyWith<$Res>? get household {
    if (_self.household == null) {
    return null;
  }

  return $HouseholdBasicModelCopyWith<$Res>(_self.household!, (value) {
    return _then(_self.copyWith(household: value));
  });
}
}


/// @nodoc
mixin _$HouseholdBasicModel {

 String get id; String get name;
/// Create a copy of HouseholdBasicModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseholdBasicModelCopyWith<HouseholdBasicModel> get copyWith => _$HouseholdBasicModelCopyWithImpl<HouseholdBasicModel>(this as HouseholdBasicModel, _$identity);

  /// Serializes this HouseholdBasicModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdBasicModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'HouseholdBasicModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $HouseholdBasicModelCopyWith<$Res>  {
  factory $HouseholdBasicModelCopyWith(HouseholdBasicModel value, $Res Function(HouseholdBasicModel) _then) = _$HouseholdBasicModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$HouseholdBasicModelCopyWithImpl<$Res>
    implements $HouseholdBasicModelCopyWith<$Res> {
  _$HouseholdBasicModelCopyWithImpl(this._self, this._then);

  final HouseholdBasicModel _self;
  final $Res Function(HouseholdBasicModel) _then;

/// Create a copy of HouseholdBasicModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HouseholdBasicModel].
extension HouseholdBasicModelPatterns on HouseholdBasicModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HouseholdBasicModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HouseholdBasicModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HouseholdBasicModel value)  $default,){
final _that = this;
switch (_that) {
case _HouseholdBasicModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HouseholdBasicModel value)?  $default,){
final _that = this;
switch (_that) {
case _HouseholdBasicModel() when $default != null:
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
case _HouseholdBasicModel() when $default != null:
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
case _HouseholdBasicModel():
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
case _HouseholdBasicModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HouseholdBasicModel implements HouseholdBasicModel {
  const _HouseholdBasicModel({required this.id, required this.name});
  factory _HouseholdBasicModel.fromJson(Map<String, dynamic> json) => _$HouseholdBasicModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of HouseholdBasicModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseholdBasicModelCopyWith<_HouseholdBasicModel> get copyWith => __$HouseholdBasicModelCopyWithImpl<_HouseholdBasicModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HouseholdBasicModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HouseholdBasicModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'HouseholdBasicModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HouseholdBasicModelCopyWith<$Res> implements $HouseholdBasicModelCopyWith<$Res> {
  factory _$HouseholdBasicModelCopyWith(_HouseholdBasicModel value, $Res Function(_HouseholdBasicModel) _then) = __$HouseholdBasicModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$HouseholdBasicModelCopyWithImpl<$Res>
    implements _$HouseholdBasicModelCopyWith<$Res> {
  __$HouseholdBasicModelCopyWithImpl(this._self, this._then);

  final _HouseholdBasicModel _self;
  final $Res Function(_HouseholdBasicModel) _then;

/// Create a copy of HouseholdBasicModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_HouseholdBasicModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
