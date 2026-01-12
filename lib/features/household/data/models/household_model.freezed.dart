// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HouseholdModel {

 String get id; String get name; String get hemisphere; DateTime get createdAt; List<MemberModel>? get members;
/// Create a copy of HouseholdModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseholdModelCopyWith<HouseholdModel> get copyWith => _$HouseholdModelCopyWithImpl<HouseholdModel>(this as HouseholdModel, _$identity);

  /// Serializes this HouseholdModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.hemisphere, hemisphere) || other.hemisphere == hemisphere)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,hemisphere,createdAt,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'HouseholdModel(id: $id, name: $name, hemisphere: $hemisphere, createdAt: $createdAt, members: $members)';
}


}

/// @nodoc
abstract mixin class $HouseholdModelCopyWith<$Res>  {
  factory $HouseholdModelCopyWith(HouseholdModel value, $Res Function(HouseholdModel) _then) = _$HouseholdModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String hemisphere, DateTime createdAt, List<MemberModel>? members
});




}
/// @nodoc
class _$HouseholdModelCopyWithImpl<$Res>
    implements $HouseholdModelCopyWith<$Res> {
  _$HouseholdModelCopyWithImpl(this._self, this._then);

  final HouseholdModel _self;
  final $Res Function(HouseholdModel) _then;

/// Create a copy of HouseholdModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? hemisphere = null,Object? createdAt = null,Object? members = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hemisphere: null == hemisphere ? _self.hemisphere : hemisphere // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HouseholdModel].
extension HouseholdModelPatterns on HouseholdModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HouseholdModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HouseholdModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HouseholdModel value)  $default,){
final _that = this;
switch (_that) {
case _HouseholdModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HouseholdModel value)?  $default,){
final _that = this;
switch (_that) {
case _HouseholdModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String hemisphere,  DateTime createdAt,  List<MemberModel>? members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HouseholdModel() when $default != null:
return $default(_that.id,_that.name,_that.hemisphere,_that.createdAt,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String hemisphere,  DateTime createdAt,  List<MemberModel>? members)  $default,) {final _that = this;
switch (_that) {
case _HouseholdModel():
return $default(_that.id,_that.name,_that.hemisphere,_that.createdAt,_that.members);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String hemisphere,  DateTime createdAt,  List<MemberModel>? members)?  $default,) {final _that = this;
switch (_that) {
case _HouseholdModel() when $default != null:
return $default(_that.id,_that.name,_that.hemisphere,_that.createdAt,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HouseholdModel implements HouseholdModel {
  const _HouseholdModel({required this.id, required this.name, required this.hemisphere, required this.createdAt, final  List<MemberModel>? members}): _members = members;
  factory _HouseholdModel.fromJson(Map<String, dynamic> json) => _$HouseholdModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String hemisphere;
@override final  DateTime createdAt;
 final  List<MemberModel>? _members;
@override List<MemberModel>? get members {
  final value = _members;
  if (value == null) return null;
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of HouseholdModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseholdModelCopyWith<_HouseholdModel> get copyWith => __$HouseholdModelCopyWithImpl<_HouseholdModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HouseholdModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HouseholdModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.hemisphere, hemisphere) || other.hemisphere == hemisphere)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,hemisphere,createdAt,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'HouseholdModel(id: $id, name: $name, hemisphere: $hemisphere, createdAt: $createdAt, members: $members)';
}


}

/// @nodoc
abstract mixin class _$HouseholdModelCopyWith<$Res> implements $HouseholdModelCopyWith<$Res> {
  factory _$HouseholdModelCopyWith(_HouseholdModel value, $Res Function(_HouseholdModel) _then) = __$HouseholdModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String hemisphere, DateTime createdAt, List<MemberModel>? members
});




}
/// @nodoc
class __$HouseholdModelCopyWithImpl<$Res>
    implements _$HouseholdModelCopyWith<$Res> {
  __$HouseholdModelCopyWithImpl(this._self, this._then);

  final _HouseholdModel _self;
  final $Res Function(_HouseholdModel) _then;

/// Create a copy of HouseholdModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? hemisphere = null,Object? createdAt = null,Object? members = freezed,}) {
  return _then(_HouseholdModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hemisphere: null == hemisphere ? _self.hemisphere : hemisphere // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,members: freezed == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,
  ));
}


}


/// @nodoc
mixin _$MemberModel {

 String get id; String get oderId; String get name; String get email; String? get avatarUrl; String get role; double? get income; DateTime get createdAt;
/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberModelCopyWith<MemberModel> get copyWith => _$MemberModelCopyWithImpl<MemberModel>(this as MemberModel, _$identity);

  /// Serializes this MemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.oderId, oderId) || other.oderId == oderId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.income, income) || other.income == income)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,oderId,name,email,avatarUrl,role,income,createdAt);

@override
String toString() {
  return 'MemberModel(id: $id, oderId: $oderId, name: $name, email: $email, avatarUrl: $avatarUrl, role: $role, income: $income, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MemberModelCopyWith<$Res>  {
  factory $MemberModelCopyWith(MemberModel value, $Res Function(MemberModel) _then) = _$MemberModelCopyWithImpl;
@useResult
$Res call({
 String id, String oderId, String name, String email, String? avatarUrl, String role, double? income, DateTime createdAt
});




}
/// @nodoc
class _$MemberModelCopyWithImpl<$Res>
    implements $MemberModelCopyWith<$Res> {
  _$MemberModelCopyWithImpl(this._self, this._then);

  final MemberModel _self;
  final $Res Function(MemberModel) _then;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? oderId = null,Object? name = null,Object? email = null,Object? avatarUrl = freezed,Object? role = null,Object? income = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,oderId: null == oderId ? _self.oderId : oderId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberModel].
extension MemberModelPatterns on MemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String oderId,  String name,  String email,  String? avatarUrl,  String role,  double? income,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that.id,_that.oderId,_that.name,_that.email,_that.avatarUrl,_that.role,_that.income,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String oderId,  String name,  String email,  String? avatarUrl,  String role,  double? income,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MemberModel():
return $default(_that.id,_that.oderId,_that.name,_that.email,_that.avatarUrl,_that.role,_that.income,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String oderId,  String name,  String email,  String? avatarUrl,  String role,  double? income,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that.id,_that.oderId,_that.name,_that.email,_that.avatarUrl,_that.role,_that.income,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberModel implements MemberModel {
  const _MemberModel({required this.id, required this.oderId, required this.name, required this.email, this.avatarUrl, required this.role, this.income, required this.createdAt});
  factory _MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

@override final  String id;
@override final  String oderId;
@override final  String name;
@override final  String email;
@override final  String? avatarUrl;
@override final  String role;
@override final  double? income;
@override final  DateTime createdAt;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberModelCopyWith<_MemberModel> get copyWith => __$MemberModelCopyWithImpl<_MemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.oderId, oderId) || other.oderId == oderId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.income, income) || other.income == income)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,oderId,name,email,avatarUrl,role,income,createdAt);

@override
String toString() {
  return 'MemberModel(id: $id, oderId: $oderId, name: $name, email: $email, avatarUrl: $avatarUrl, role: $role, income: $income, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MemberModelCopyWith<$Res> implements $MemberModelCopyWith<$Res> {
  factory _$MemberModelCopyWith(_MemberModel value, $Res Function(_MemberModel) _then) = __$MemberModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String oderId, String name, String email, String? avatarUrl, String role, double? income, DateTime createdAt
});




}
/// @nodoc
class __$MemberModelCopyWithImpl<$Res>
    implements _$MemberModelCopyWith<$Res> {
  __$MemberModelCopyWithImpl(this._self, this._then);

  final _MemberModel _self;
  final $Res Function(_MemberModel) _then;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? oderId = null,Object? name = null,Object? email = null,Object? avatarUrl = freezed,Object? role = null,Object? income = freezed,Object? createdAt = null,}) {
  return _then(_MemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,oderId: null == oderId ? _self.oderId : oderId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$HouseholdInviteModel {

 String get id; String get code; DateTime get expiresAt; DateTime get createdAt;
/// Create a copy of HouseholdInviteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseholdInviteModelCopyWith<HouseholdInviteModel> get copyWith => _$HouseholdInviteModelCopyWithImpl<HouseholdInviteModel>(this as HouseholdInviteModel, _$identity);

  /// Serializes this HouseholdInviteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseholdInviteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,expiresAt,createdAt);

@override
String toString() {
  return 'HouseholdInviteModel(id: $id, code: $code, expiresAt: $expiresAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HouseholdInviteModelCopyWith<$Res>  {
  factory $HouseholdInviteModelCopyWith(HouseholdInviteModel value, $Res Function(HouseholdInviteModel) _then) = _$HouseholdInviteModelCopyWithImpl;
@useResult
$Res call({
 String id, String code, DateTime expiresAt, DateTime createdAt
});




}
/// @nodoc
class _$HouseholdInviteModelCopyWithImpl<$Res>
    implements $HouseholdInviteModelCopyWith<$Res> {
  _$HouseholdInviteModelCopyWithImpl(this._self, this._then);

  final HouseholdInviteModel _self;
  final $Res Function(HouseholdInviteModel) _then;

/// Create a copy of HouseholdInviteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? expiresAt = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HouseholdInviteModel].
extension HouseholdInviteModelPatterns on HouseholdInviteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HouseholdInviteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HouseholdInviteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HouseholdInviteModel value)  $default,){
final _that = this;
switch (_that) {
case _HouseholdInviteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HouseholdInviteModel value)?  $default,){
final _that = this;
switch (_that) {
case _HouseholdInviteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  DateTime expiresAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HouseholdInviteModel() when $default != null:
return $default(_that.id,_that.code,_that.expiresAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  DateTime expiresAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _HouseholdInviteModel():
return $default(_that.id,_that.code,_that.expiresAt,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  DateTime expiresAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HouseholdInviteModel() when $default != null:
return $default(_that.id,_that.code,_that.expiresAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HouseholdInviteModel implements HouseholdInviteModel {
  const _HouseholdInviteModel({required this.id, required this.code, required this.expiresAt, required this.createdAt});
  factory _HouseholdInviteModel.fromJson(Map<String, dynamic> json) => _$HouseholdInviteModelFromJson(json);

@override final  String id;
@override final  String code;
@override final  DateTime expiresAt;
@override final  DateTime createdAt;

/// Create a copy of HouseholdInviteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseholdInviteModelCopyWith<_HouseholdInviteModel> get copyWith => __$HouseholdInviteModelCopyWithImpl<_HouseholdInviteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HouseholdInviteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HouseholdInviteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,expiresAt,createdAt);

@override
String toString() {
  return 'HouseholdInviteModel(id: $id, code: $code, expiresAt: $expiresAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HouseholdInviteModelCopyWith<$Res> implements $HouseholdInviteModelCopyWith<$Res> {
  factory _$HouseholdInviteModelCopyWith(_HouseholdInviteModel value, $Res Function(_HouseholdInviteModel) _then) = __$HouseholdInviteModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, DateTime expiresAt, DateTime createdAt
});




}
/// @nodoc
class __$HouseholdInviteModelCopyWithImpl<$Res>
    implements _$HouseholdInviteModelCopyWith<$Res> {
  __$HouseholdInviteModelCopyWithImpl(this._self, this._then);

  final _HouseholdInviteModel _self;
  final $Res Function(_HouseholdInviteModel) _then;

/// Create a copy of HouseholdInviteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? expiresAt = null,Object? createdAt = null,}) {
  return _then(_HouseholdInviteModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
