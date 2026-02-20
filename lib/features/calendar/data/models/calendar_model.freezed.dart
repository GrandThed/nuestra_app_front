// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarUserModel {

 String get id; String get name; String? get avatarUrl;
/// Create a copy of CalendarUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarUserModelCopyWith<CalendarUserModel> get copyWith => _$CalendarUserModelCopyWithImpl<CalendarUserModel>(this as CalendarUserModel, _$identity);

  /// Serializes this CalendarUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'CalendarUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $CalendarUserModelCopyWith<$Res>  {
  factory $CalendarUserModelCopyWith(CalendarUserModel value, $Res Function(CalendarUserModel) _then) = _$CalendarUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class _$CalendarUserModelCopyWithImpl<$Res>
    implements $CalendarUserModelCopyWith<$Res> {
  _$CalendarUserModelCopyWithImpl(this._self, this._then);

  final CalendarUserModel _self;
  final $Res Function(CalendarUserModel) _then;

/// Create a copy of CalendarUserModel
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


/// Adds pattern-matching-related methods to [CalendarUserModel].
extension CalendarUserModelPatterns on CalendarUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarUserModel value)  $default,){
final _that = this;
switch (_that) {
case _CalendarUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarUserModel() when $default != null:
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
case _CalendarUserModel() when $default != null:
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
case _CalendarUserModel():
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
case _CalendarUserModel() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarUserModel implements CalendarUserModel {
  const _CalendarUserModel({required this.id, required this.name, this.avatarUrl});
  factory _CalendarUserModel.fromJson(Map<String, dynamic> json) => _$CalendarUserModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of CalendarUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarUserModelCopyWith<_CalendarUserModel> get copyWith => __$CalendarUserModelCopyWithImpl<_CalendarUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'CalendarUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$CalendarUserModelCopyWith<$Res> implements $CalendarUserModelCopyWith<$Res> {
  factory _$CalendarUserModelCopyWith(_CalendarUserModel value, $Res Function(_CalendarUserModel) _then) = __$CalendarUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class __$CalendarUserModelCopyWithImpl<$Res>
    implements _$CalendarUserModelCopyWith<$Res> {
  __$CalendarUserModelCopyWithImpl(this._self, this._then);

  final _CalendarUserModel _self;
  final $Res Function(_CalendarUserModel) _then;

/// Create a copy of CalendarUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_CalendarUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LinkedBoardModel {

 String get id; String get name;
/// Create a copy of LinkedBoardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkedBoardModelCopyWith<LinkedBoardModel> get copyWith => _$LinkedBoardModelCopyWithImpl<LinkedBoardModel>(this as LinkedBoardModel, _$identity);

  /// Serializes this LinkedBoardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkedBoardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'LinkedBoardModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $LinkedBoardModelCopyWith<$Res>  {
  factory $LinkedBoardModelCopyWith(LinkedBoardModel value, $Res Function(LinkedBoardModel) _then) = _$LinkedBoardModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$LinkedBoardModelCopyWithImpl<$Res>
    implements $LinkedBoardModelCopyWith<$Res> {
  _$LinkedBoardModelCopyWithImpl(this._self, this._then);

  final LinkedBoardModel _self;
  final $Res Function(LinkedBoardModel) _then;

/// Create a copy of LinkedBoardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkedBoardModel].
extension LinkedBoardModelPatterns on LinkedBoardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkedBoardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkedBoardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkedBoardModel value)  $default,){
final _that = this;
switch (_that) {
case _LinkedBoardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkedBoardModel value)?  $default,){
final _that = this;
switch (_that) {
case _LinkedBoardModel() when $default != null:
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
case _LinkedBoardModel() when $default != null:
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
case _LinkedBoardModel():
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
case _LinkedBoardModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkedBoardModel implements LinkedBoardModel {
  const _LinkedBoardModel({required this.id, required this.name});
  factory _LinkedBoardModel.fromJson(Map<String, dynamic> json) => _$LinkedBoardModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of LinkedBoardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkedBoardModelCopyWith<_LinkedBoardModel> get copyWith => __$LinkedBoardModelCopyWithImpl<_LinkedBoardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkedBoardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkedBoardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'LinkedBoardModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$LinkedBoardModelCopyWith<$Res> implements $LinkedBoardModelCopyWith<$Res> {
  factory _$LinkedBoardModelCopyWith(_LinkedBoardModel value, $Res Function(_LinkedBoardModel) _then) = __$LinkedBoardModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$LinkedBoardModelCopyWithImpl<$Res>
    implements _$LinkedBoardModelCopyWith<$Res> {
  __$LinkedBoardModelCopyWithImpl(this._self, this._then);

  final _LinkedBoardModel _self;
  final $Res Function(_LinkedBoardModel) _then;

/// Create a copy of LinkedBoardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_LinkedBoardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LinkedRecipeModel {

 String get id; String get title;
/// Create a copy of LinkedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkedRecipeModelCopyWith<LinkedRecipeModel> get copyWith => _$LinkedRecipeModelCopyWithImpl<LinkedRecipeModel>(this as LinkedRecipeModel, _$identity);

  /// Serializes this LinkedRecipeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkedRecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'LinkedRecipeModel(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $LinkedRecipeModelCopyWith<$Res>  {
  factory $LinkedRecipeModelCopyWith(LinkedRecipeModel value, $Res Function(LinkedRecipeModel) _then) = _$LinkedRecipeModelCopyWithImpl;
@useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class _$LinkedRecipeModelCopyWithImpl<$Res>
    implements $LinkedRecipeModelCopyWith<$Res> {
  _$LinkedRecipeModelCopyWithImpl(this._self, this._then);

  final LinkedRecipeModel _self;
  final $Res Function(LinkedRecipeModel) _then;

/// Create a copy of LinkedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkedRecipeModel].
extension LinkedRecipeModelPatterns on LinkedRecipeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkedRecipeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkedRecipeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkedRecipeModel value)  $default,){
final _that = this;
switch (_that) {
case _LinkedRecipeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkedRecipeModel value)?  $default,){
final _that = this;
switch (_that) {
case _LinkedRecipeModel() when $default != null:
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
case _LinkedRecipeModel() when $default != null:
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
case _LinkedRecipeModel():
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
case _LinkedRecipeModel() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkedRecipeModel implements LinkedRecipeModel {
  const _LinkedRecipeModel({required this.id, required this.title});
  factory _LinkedRecipeModel.fromJson(Map<String, dynamic> json) => _$LinkedRecipeModelFromJson(json);

@override final  String id;
@override final  String title;

/// Create a copy of LinkedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkedRecipeModelCopyWith<_LinkedRecipeModel> get copyWith => __$LinkedRecipeModelCopyWithImpl<_LinkedRecipeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkedRecipeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkedRecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'LinkedRecipeModel(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$LinkedRecipeModelCopyWith<$Res> implements $LinkedRecipeModelCopyWith<$Res> {
  factory _$LinkedRecipeModelCopyWith(_LinkedRecipeModel value, $Res Function(_LinkedRecipeModel) _then) = __$LinkedRecipeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class __$LinkedRecipeModelCopyWithImpl<$Res>
    implements _$LinkedRecipeModelCopyWith<$Res> {
  __$LinkedRecipeModelCopyWithImpl(this._self, this._then);

  final _LinkedRecipeModel _self;
  final $Res Function(_LinkedRecipeModel) _then;

/// Create a copy of LinkedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_LinkedRecipeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LinkedMenuPlanModel {

 String get id; String get name;
/// Create a copy of LinkedMenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkedMenuPlanModelCopyWith<LinkedMenuPlanModel> get copyWith => _$LinkedMenuPlanModelCopyWithImpl<LinkedMenuPlanModel>(this as LinkedMenuPlanModel, _$identity);

  /// Serializes this LinkedMenuPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkedMenuPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'LinkedMenuPlanModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $LinkedMenuPlanModelCopyWith<$Res>  {
  factory $LinkedMenuPlanModelCopyWith(LinkedMenuPlanModel value, $Res Function(LinkedMenuPlanModel) _then) = _$LinkedMenuPlanModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$LinkedMenuPlanModelCopyWithImpl<$Res>
    implements $LinkedMenuPlanModelCopyWith<$Res> {
  _$LinkedMenuPlanModelCopyWithImpl(this._self, this._then);

  final LinkedMenuPlanModel _self;
  final $Res Function(LinkedMenuPlanModel) _then;

/// Create a copy of LinkedMenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkedMenuPlanModel].
extension LinkedMenuPlanModelPatterns on LinkedMenuPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkedMenuPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkedMenuPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkedMenuPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _LinkedMenuPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkedMenuPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _LinkedMenuPlanModel() when $default != null:
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
case _LinkedMenuPlanModel() when $default != null:
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
case _LinkedMenuPlanModel():
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
case _LinkedMenuPlanModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkedMenuPlanModel implements LinkedMenuPlanModel {
  const _LinkedMenuPlanModel({required this.id, required this.name});
  factory _LinkedMenuPlanModel.fromJson(Map<String, dynamic> json) => _$LinkedMenuPlanModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of LinkedMenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkedMenuPlanModelCopyWith<_LinkedMenuPlanModel> get copyWith => __$LinkedMenuPlanModelCopyWithImpl<_LinkedMenuPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkedMenuPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkedMenuPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'LinkedMenuPlanModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$LinkedMenuPlanModelCopyWith<$Res> implements $LinkedMenuPlanModelCopyWith<$Res> {
  factory _$LinkedMenuPlanModelCopyWith(_LinkedMenuPlanModel value, $Res Function(_LinkedMenuPlanModel) _then) = __$LinkedMenuPlanModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$LinkedMenuPlanModelCopyWithImpl<$Res>
    implements _$LinkedMenuPlanModelCopyWith<$Res> {
  __$LinkedMenuPlanModelCopyWithImpl(this._self, this._then);

  final _LinkedMenuPlanModel _self;
  final $Res Function(_LinkedMenuPlanModel) _then;

/// Create a copy of LinkedMenuPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_LinkedMenuPlanModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CalendarEventModel {

 String get id; String get householdId; String get title; String? get description; DateTime get startDate; DateTime? get endDate; bool get allDay; RecurrenceType get recurrence; DateTime? get recurrenceEndDate; LinkedBoardModel? get linkedBoard; LinkedRecipeModel? get linkedRecipe; LinkedMenuPlanModel? get linkedMenuPlan; CalendarUserModel? get createdBy; bool get isOccurrence; DateTime? get occurrenceDate; String? get occurrenceId; String? get colorHex; DateTime? get createdAt;
/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventModelCopyWith<CalendarEventModel> get copyWith => _$CalendarEventModelCopyWithImpl<CalendarEventModel>(this as CalendarEventModel, _$identity);

  /// Serializes this CalendarEventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate)&&(identical(other.linkedBoard, linkedBoard) || other.linkedBoard == linkedBoard)&&(identical(other.linkedRecipe, linkedRecipe) || other.linkedRecipe == linkedRecipe)&&(identical(other.linkedMenuPlan, linkedMenuPlan) || other.linkedMenuPlan == linkedMenuPlan)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.isOccurrence, isOccurrence) || other.isOccurrence == isOccurrence)&&(identical(other.occurrenceDate, occurrenceDate) || other.occurrenceDate == occurrenceDate)&&(identical(other.occurrenceId, occurrenceId) || other.occurrenceId == occurrenceId)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,title,description,startDate,endDate,allDay,recurrence,recurrenceEndDate,linkedBoard,linkedRecipe,linkedMenuPlan,createdBy,isOccurrence,occurrenceDate,occurrenceId,colorHex,createdAt);

@override
String toString() {
  return 'CalendarEventModel(id: $id, householdId: $householdId, title: $title, description: $description, startDate: $startDate, endDate: $endDate, allDay: $allDay, recurrence: $recurrence, recurrenceEndDate: $recurrenceEndDate, linkedBoard: $linkedBoard, linkedRecipe: $linkedRecipe, linkedMenuPlan: $linkedMenuPlan, createdBy: $createdBy, isOccurrence: $isOccurrence, occurrenceDate: $occurrenceDate, occurrenceId: $occurrenceId, colorHex: $colorHex, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CalendarEventModelCopyWith<$Res>  {
  factory $CalendarEventModelCopyWith(CalendarEventModel value, $Res Function(CalendarEventModel) _then) = _$CalendarEventModelCopyWithImpl;
@useResult
$Res call({
 String id, String householdId, String title, String? description, DateTime startDate, DateTime? endDate, bool allDay, RecurrenceType recurrence, DateTime? recurrenceEndDate, LinkedBoardModel? linkedBoard, LinkedRecipeModel? linkedRecipe, LinkedMenuPlanModel? linkedMenuPlan, CalendarUserModel? createdBy, bool isOccurrence, DateTime? occurrenceDate, String? occurrenceId, String? colorHex, DateTime? createdAt
});


$LinkedBoardModelCopyWith<$Res>? get linkedBoard;$LinkedRecipeModelCopyWith<$Res>? get linkedRecipe;$LinkedMenuPlanModelCopyWith<$Res>? get linkedMenuPlan;$CalendarUserModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class _$CalendarEventModelCopyWithImpl<$Res>
    implements $CalendarEventModelCopyWith<$Res> {
  _$CalendarEventModelCopyWithImpl(this._self, this._then);

  final CalendarEventModel _self;
  final $Res Function(CalendarEventModel) _then;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? householdId = null,Object? title = null,Object? description = freezed,Object? startDate = null,Object? endDate = freezed,Object? allDay = null,Object? recurrence = null,Object? recurrenceEndDate = freezed,Object? linkedBoard = freezed,Object? linkedRecipe = freezed,Object? linkedMenuPlan = freezed,Object? createdBy = freezed,Object? isOccurrence = null,Object? occurrenceDate = freezed,Object? occurrenceId = freezed,Object? colorHex = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as RecurrenceType,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,linkedBoard: freezed == linkedBoard ? _self.linkedBoard : linkedBoard // ignore: cast_nullable_to_non_nullable
as LinkedBoardModel?,linkedRecipe: freezed == linkedRecipe ? _self.linkedRecipe : linkedRecipe // ignore: cast_nullable_to_non_nullable
as LinkedRecipeModel?,linkedMenuPlan: freezed == linkedMenuPlan ? _self.linkedMenuPlan : linkedMenuPlan // ignore: cast_nullable_to_non_nullable
as LinkedMenuPlanModel?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CalendarUserModel?,isOccurrence: null == isOccurrence ? _self.isOccurrence : isOccurrence // ignore: cast_nullable_to_non_nullable
as bool,occurrenceDate: freezed == occurrenceDate ? _self.occurrenceDate : occurrenceDate // ignore: cast_nullable_to_non_nullable
as DateTime?,occurrenceId: freezed == occurrenceId ? _self.occurrenceId : occurrenceId // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedBoardModelCopyWith<$Res>? get linkedBoard {
    if (_self.linkedBoard == null) {
    return null;
  }

  return $LinkedBoardModelCopyWith<$Res>(_self.linkedBoard!, (value) {
    return _then(_self.copyWith(linkedBoard: value));
  });
}/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedRecipeModelCopyWith<$Res>? get linkedRecipe {
    if (_self.linkedRecipe == null) {
    return null;
  }

  return $LinkedRecipeModelCopyWith<$Res>(_self.linkedRecipe!, (value) {
    return _then(_self.copyWith(linkedRecipe: value));
  });
}/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedMenuPlanModelCopyWith<$Res>? get linkedMenuPlan {
    if (_self.linkedMenuPlan == null) {
    return null;
  }

  return $LinkedMenuPlanModelCopyWith<$Res>(_self.linkedMenuPlan!, (value) {
    return _then(_self.copyWith(linkedMenuPlan: value));
  });
}/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarUserModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $CalendarUserModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalendarEventModel].
extension CalendarEventModelPatterns on CalendarEventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEventModel value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEventModel value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String householdId,  String title,  String? description,  DateTime startDate,  DateTime? endDate,  bool allDay,  RecurrenceType recurrence,  DateTime? recurrenceEndDate,  LinkedBoardModel? linkedBoard,  LinkedRecipeModel? linkedRecipe,  LinkedMenuPlanModel? linkedMenuPlan,  CalendarUserModel? createdBy,  bool isOccurrence,  DateTime? occurrenceDate,  String? occurrenceId,  String? colorHex,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
return $default(_that.id,_that.householdId,_that.title,_that.description,_that.startDate,_that.endDate,_that.allDay,_that.recurrence,_that.recurrenceEndDate,_that.linkedBoard,_that.linkedRecipe,_that.linkedMenuPlan,_that.createdBy,_that.isOccurrence,_that.occurrenceDate,_that.occurrenceId,_that.colorHex,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String householdId,  String title,  String? description,  DateTime startDate,  DateTime? endDate,  bool allDay,  RecurrenceType recurrence,  DateTime? recurrenceEndDate,  LinkedBoardModel? linkedBoard,  LinkedRecipeModel? linkedRecipe,  LinkedMenuPlanModel? linkedMenuPlan,  CalendarUserModel? createdBy,  bool isOccurrence,  DateTime? occurrenceDate,  String? occurrenceId,  String? colorHex,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CalendarEventModel():
return $default(_that.id,_that.householdId,_that.title,_that.description,_that.startDate,_that.endDate,_that.allDay,_that.recurrence,_that.recurrenceEndDate,_that.linkedBoard,_that.linkedRecipe,_that.linkedMenuPlan,_that.createdBy,_that.isOccurrence,_that.occurrenceDate,_that.occurrenceId,_that.colorHex,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String householdId,  String title,  String? description,  DateTime startDate,  DateTime? endDate,  bool allDay,  RecurrenceType recurrence,  DateTime? recurrenceEndDate,  LinkedBoardModel? linkedBoard,  LinkedRecipeModel? linkedRecipe,  LinkedMenuPlanModel? linkedMenuPlan,  CalendarUserModel? createdBy,  bool isOccurrence,  DateTime? occurrenceDate,  String? occurrenceId,  String? colorHex,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEventModel() when $default != null:
return $default(_that.id,_that.householdId,_that.title,_that.description,_that.startDate,_that.endDate,_that.allDay,_that.recurrence,_that.recurrenceEndDate,_that.linkedBoard,_that.linkedRecipe,_that.linkedMenuPlan,_that.createdBy,_that.isOccurrence,_that.occurrenceDate,_that.occurrenceId,_that.colorHex,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarEventModel implements CalendarEventModel {
  const _CalendarEventModel({required this.id, required this.householdId, required this.title, this.description, required this.startDate, this.endDate, this.allDay = false, this.recurrence = RecurrenceType.none, this.recurrenceEndDate, this.linkedBoard, this.linkedRecipe, this.linkedMenuPlan, this.createdBy, this.isOccurrence = false, this.occurrenceDate, this.occurrenceId, this.colorHex, this.createdAt});
  factory _CalendarEventModel.fromJson(Map<String, dynamic> json) => _$CalendarEventModelFromJson(json);

@override final  String id;
@override final  String householdId;
@override final  String title;
@override final  String? description;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool allDay;
@override@JsonKey() final  RecurrenceType recurrence;
@override final  DateTime? recurrenceEndDate;
@override final  LinkedBoardModel? linkedBoard;
@override final  LinkedRecipeModel? linkedRecipe;
@override final  LinkedMenuPlanModel? linkedMenuPlan;
@override final  CalendarUserModel? createdBy;
@override@JsonKey() final  bool isOccurrence;
@override final  DateTime? occurrenceDate;
@override final  String? occurrenceId;
@override final  String? colorHex;
@override final  DateTime? createdAt;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventModelCopyWith<_CalendarEventModel> get copyWith => __$CalendarEventModelCopyWithImpl<_CalendarEventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarEventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.householdId, householdId) || other.householdId == householdId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate)&&(identical(other.linkedBoard, linkedBoard) || other.linkedBoard == linkedBoard)&&(identical(other.linkedRecipe, linkedRecipe) || other.linkedRecipe == linkedRecipe)&&(identical(other.linkedMenuPlan, linkedMenuPlan) || other.linkedMenuPlan == linkedMenuPlan)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.isOccurrence, isOccurrence) || other.isOccurrence == isOccurrence)&&(identical(other.occurrenceDate, occurrenceDate) || other.occurrenceDate == occurrenceDate)&&(identical(other.occurrenceId, occurrenceId) || other.occurrenceId == occurrenceId)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,householdId,title,description,startDate,endDate,allDay,recurrence,recurrenceEndDate,linkedBoard,linkedRecipe,linkedMenuPlan,createdBy,isOccurrence,occurrenceDate,occurrenceId,colorHex,createdAt);

@override
String toString() {
  return 'CalendarEventModel(id: $id, householdId: $householdId, title: $title, description: $description, startDate: $startDate, endDate: $endDate, allDay: $allDay, recurrence: $recurrence, recurrenceEndDate: $recurrenceEndDate, linkedBoard: $linkedBoard, linkedRecipe: $linkedRecipe, linkedMenuPlan: $linkedMenuPlan, createdBy: $createdBy, isOccurrence: $isOccurrence, occurrenceDate: $occurrenceDate, occurrenceId: $occurrenceId, colorHex: $colorHex, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventModelCopyWith<$Res> implements $CalendarEventModelCopyWith<$Res> {
  factory _$CalendarEventModelCopyWith(_CalendarEventModel value, $Res Function(_CalendarEventModel) _then) = __$CalendarEventModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String householdId, String title, String? description, DateTime startDate, DateTime? endDate, bool allDay, RecurrenceType recurrence, DateTime? recurrenceEndDate, LinkedBoardModel? linkedBoard, LinkedRecipeModel? linkedRecipe, LinkedMenuPlanModel? linkedMenuPlan, CalendarUserModel? createdBy, bool isOccurrence, DateTime? occurrenceDate, String? occurrenceId, String? colorHex, DateTime? createdAt
});


@override $LinkedBoardModelCopyWith<$Res>? get linkedBoard;@override $LinkedRecipeModelCopyWith<$Res>? get linkedRecipe;@override $LinkedMenuPlanModelCopyWith<$Res>? get linkedMenuPlan;@override $CalendarUserModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class __$CalendarEventModelCopyWithImpl<$Res>
    implements _$CalendarEventModelCopyWith<$Res> {
  __$CalendarEventModelCopyWithImpl(this._self, this._then);

  final _CalendarEventModel _self;
  final $Res Function(_CalendarEventModel) _then;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? householdId = null,Object? title = null,Object? description = freezed,Object? startDate = null,Object? endDate = freezed,Object? allDay = null,Object? recurrence = null,Object? recurrenceEndDate = freezed,Object? linkedBoard = freezed,Object? linkedRecipe = freezed,Object? linkedMenuPlan = freezed,Object? createdBy = freezed,Object? isOccurrence = null,Object? occurrenceDate = freezed,Object? occurrenceId = freezed,Object? colorHex = freezed,Object? createdAt = freezed,}) {
  return _then(_CalendarEventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,householdId: null == householdId ? _self.householdId : householdId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as RecurrenceType,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,linkedBoard: freezed == linkedBoard ? _self.linkedBoard : linkedBoard // ignore: cast_nullable_to_non_nullable
as LinkedBoardModel?,linkedRecipe: freezed == linkedRecipe ? _self.linkedRecipe : linkedRecipe // ignore: cast_nullable_to_non_nullable
as LinkedRecipeModel?,linkedMenuPlan: freezed == linkedMenuPlan ? _self.linkedMenuPlan : linkedMenuPlan // ignore: cast_nullable_to_non_nullable
as LinkedMenuPlanModel?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CalendarUserModel?,isOccurrence: null == isOccurrence ? _self.isOccurrence : isOccurrence // ignore: cast_nullable_to_non_nullable
as bool,occurrenceDate: freezed == occurrenceDate ? _self.occurrenceDate : occurrenceDate // ignore: cast_nullable_to_non_nullable
as DateTime?,occurrenceId: freezed == occurrenceId ? _self.occurrenceId : occurrenceId // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedBoardModelCopyWith<$Res>? get linkedBoard {
    if (_self.linkedBoard == null) {
    return null;
  }

  return $LinkedBoardModelCopyWith<$Res>(_self.linkedBoard!, (value) {
    return _then(_self.copyWith(linkedBoard: value));
  });
}/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedRecipeModelCopyWith<$Res>? get linkedRecipe {
    if (_self.linkedRecipe == null) {
    return null;
  }

  return $LinkedRecipeModelCopyWith<$Res>(_self.linkedRecipe!, (value) {
    return _then(_self.copyWith(linkedRecipe: value));
  });
}/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedMenuPlanModelCopyWith<$Res>? get linkedMenuPlan {
    if (_self.linkedMenuPlan == null) {
    return null;
  }

  return $LinkedMenuPlanModelCopyWith<$Res>(_self.linkedMenuPlan!, (value) {
    return _then(_self.copyWith(linkedMenuPlan: value));
  });
}/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarUserModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $CalendarUserModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}

/// @nodoc
mixin _$TimelineItemModel {

 String get id; DateTime get date; String get title;
/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineItemModelCopyWith<TimelineItemModel> get copyWith => _$TimelineItemModelCopyWithImpl<TimelineItemModel>(this as TimelineItemModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,title);

@override
String toString() {
  return 'TimelineItemModel(id: $id, date: $date, title: $title)';
}


}

/// @nodoc
abstract mixin class $TimelineItemModelCopyWith<$Res>  {
  factory $TimelineItemModelCopyWith(TimelineItemModel value, $Res Function(TimelineItemModel) _then) = _$TimelineItemModelCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String title
});




}
/// @nodoc
class _$TimelineItemModelCopyWithImpl<$Res>
    implements $TimelineItemModelCopyWith<$Res> {
  _$TimelineItemModelCopyWithImpl(this._self, this._then);

  final TimelineItemModel _self;
  final $Res Function(TimelineItemModel) _then;

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineItemModel].
extension TimelineItemModelPatterns on TimelineItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TimelineCalendarEvent value)?  calendarEvent,TResult Function( TimelineMenuItem value)?  menuItem,TResult Function( TimelineBoardItem value)?  boardItem,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TimelineCalendarEvent() when calendarEvent != null:
return calendarEvent(_that);case TimelineMenuItem() when menuItem != null:
return menuItem(_that);case TimelineBoardItem() when boardItem != null:
return boardItem(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TimelineCalendarEvent value)  calendarEvent,required TResult Function( TimelineMenuItem value)  menuItem,required TResult Function( TimelineBoardItem value)  boardItem,}){
final _that = this;
switch (_that) {
case TimelineCalendarEvent():
return calendarEvent(_that);case TimelineMenuItem():
return menuItem(_that);case TimelineBoardItem():
return boardItem(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TimelineCalendarEvent value)?  calendarEvent,TResult? Function( TimelineMenuItem value)?  menuItem,TResult? Function( TimelineBoardItem value)?  boardItem,}){
final _that = this;
switch (_that) {
case TimelineCalendarEvent() when calendarEvent != null:
return calendarEvent(_that);case TimelineMenuItem() when menuItem != null:
return menuItem(_that);case TimelineBoardItem() when boardItem != null:
return boardItem(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  DateTime date,  String? masterId,  String title,  String? description,  bool allDay,  bool isOccurrence,  LinkedBoardModel? linkedBoard,  LinkedRecipeModel? linkedRecipe,  LinkedMenuPlanModel? linkedMenuPlan)?  calendarEvent,TResult Function( String id,  DateTime date,  String title,  String mealType,  TimelineRecipeRef? recipe,  TimelineMenuPlanRef? menuPlan)?  menuItem,TResult Function( String id,  DateTime date,  String title,  String itemType,  String? url,  String? thumbnailUrl,  TimelineBoardRef? board,  CalendarUserModel? createdBy)?  boardItem,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TimelineCalendarEvent() when calendarEvent != null:
return calendarEvent(_that.id,_that.date,_that.masterId,_that.title,_that.description,_that.allDay,_that.isOccurrence,_that.linkedBoard,_that.linkedRecipe,_that.linkedMenuPlan);case TimelineMenuItem() when menuItem != null:
return menuItem(_that.id,_that.date,_that.title,_that.mealType,_that.recipe,_that.menuPlan);case TimelineBoardItem() when boardItem != null:
return boardItem(_that.id,_that.date,_that.title,_that.itemType,_that.url,_that.thumbnailUrl,_that.board,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  DateTime date,  String? masterId,  String title,  String? description,  bool allDay,  bool isOccurrence,  LinkedBoardModel? linkedBoard,  LinkedRecipeModel? linkedRecipe,  LinkedMenuPlanModel? linkedMenuPlan)  calendarEvent,required TResult Function( String id,  DateTime date,  String title,  String mealType,  TimelineRecipeRef? recipe,  TimelineMenuPlanRef? menuPlan)  menuItem,required TResult Function( String id,  DateTime date,  String title,  String itemType,  String? url,  String? thumbnailUrl,  TimelineBoardRef? board,  CalendarUserModel? createdBy)  boardItem,}) {final _that = this;
switch (_that) {
case TimelineCalendarEvent():
return calendarEvent(_that.id,_that.date,_that.masterId,_that.title,_that.description,_that.allDay,_that.isOccurrence,_that.linkedBoard,_that.linkedRecipe,_that.linkedMenuPlan);case TimelineMenuItem():
return menuItem(_that.id,_that.date,_that.title,_that.mealType,_that.recipe,_that.menuPlan);case TimelineBoardItem():
return boardItem(_that.id,_that.date,_that.title,_that.itemType,_that.url,_that.thumbnailUrl,_that.board,_that.createdBy);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  DateTime date,  String? masterId,  String title,  String? description,  bool allDay,  bool isOccurrence,  LinkedBoardModel? linkedBoard,  LinkedRecipeModel? linkedRecipe,  LinkedMenuPlanModel? linkedMenuPlan)?  calendarEvent,TResult? Function( String id,  DateTime date,  String title,  String mealType,  TimelineRecipeRef? recipe,  TimelineMenuPlanRef? menuPlan)?  menuItem,TResult? Function( String id,  DateTime date,  String title,  String itemType,  String? url,  String? thumbnailUrl,  TimelineBoardRef? board,  CalendarUserModel? createdBy)?  boardItem,}) {final _that = this;
switch (_that) {
case TimelineCalendarEvent() when calendarEvent != null:
return calendarEvent(_that.id,_that.date,_that.masterId,_that.title,_that.description,_that.allDay,_that.isOccurrence,_that.linkedBoard,_that.linkedRecipe,_that.linkedMenuPlan);case TimelineMenuItem() when menuItem != null:
return menuItem(_that.id,_that.date,_that.title,_that.mealType,_that.recipe,_that.menuPlan);case TimelineBoardItem() when boardItem != null:
return boardItem(_that.id,_that.date,_that.title,_that.itemType,_that.url,_that.thumbnailUrl,_that.board,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc


class TimelineCalendarEvent implements TimelineItemModel {
  const TimelineCalendarEvent({required this.id, required this.date, this.masterId, required this.title, this.description, this.allDay = false, this.isOccurrence = false, this.linkedBoard, this.linkedRecipe, this.linkedMenuPlan});
  

@override final  String id;
@override final  DateTime date;
 final  String? masterId;
@override final  String title;
 final  String? description;
@JsonKey() final  bool allDay;
@JsonKey() final  bool isOccurrence;
 final  LinkedBoardModel? linkedBoard;
 final  LinkedRecipeModel? linkedRecipe;
 final  LinkedMenuPlanModel? linkedMenuPlan;

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineCalendarEventCopyWith<TimelineCalendarEvent> get copyWith => _$TimelineCalendarEventCopyWithImpl<TimelineCalendarEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineCalendarEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.masterId, masterId) || other.masterId == masterId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.isOccurrence, isOccurrence) || other.isOccurrence == isOccurrence)&&(identical(other.linkedBoard, linkedBoard) || other.linkedBoard == linkedBoard)&&(identical(other.linkedRecipe, linkedRecipe) || other.linkedRecipe == linkedRecipe)&&(identical(other.linkedMenuPlan, linkedMenuPlan) || other.linkedMenuPlan == linkedMenuPlan));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,masterId,title,description,allDay,isOccurrence,linkedBoard,linkedRecipe,linkedMenuPlan);

@override
String toString() {
  return 'TimelineItemModel.calendarEvent(id: $id, date: $date, masterId: $masterId, title: $title, description: $description, allDay: $allDay, isOccurrence: $isOccurrence, linkedBoard: $linkedBoard, linkedRecipe: $linkedRecipe, linkedMenuPlan: $linkedMenuPlan)';
}


}

/// @nodoc
abstract mixin class $TimelineCalendarEventCopyWith<$Res> implements $TimelineItemModelCopyWith<$Res> {
  factory $TimelineCalendarEventCopyWith(TimelineCalendarEvent value, $Res Function(TimelineCalendarEvent) _then) = _$TimelineCalendarEventCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String? masterId, String title, String? description, bool allDay, bool isOccurrence, LinkedBoardModel? linkedBoard, LinkedRecipeModel? linkedRecipe, LinkedMenuPlanModel? linkedMenuPlan
});


$LinkedBoardModelCopyWith<$Res>? get linkedBoard;$LinkedRecipeModelCopyWith<$Res>? get linkedRecipe;$LinkedMenuPlanModelCopyWith<$Res>? get linkedMenuPlan;

}
/// @nodoc
class _$TimelineCalendarEventCopyWithImpl<$Res>
    implements $TimelineCalendarEventCopyWith<$Res> {
  _$TimelineCalendarEventCopyWithImpl(this._self, this._then);

  final TimelineCalendarEvent _self;
  final $Res Function(TimelineCalendarEvent) _then;

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? masterId = freezed,Object? title = null,Object? description = freezed,Object? allDay = null,Object? isOccurrence = null,Object? linkedBoard = freezed,Object? linkedRecipe = freezed,Object? linkedMenuPlan = freezed,}) {
  return _then(TimelineCalendarEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,masterId: freezed == masterId ? _self.masterId : masterId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,isOccurrence: null == isOccurrence ? _self.isOccurrence : isOccurrence // ignore: cast_nullable_to_non_nullable
as bool,linkedBoard: freezed == linkedBoard ? _self.linkedBoard : linkedBoard // ignore: cast_nullable_to_non_nullable
as LinkedBoardModel?,linkedRecipe: freezed == linkedRecipe ? _self.linkedRecipe : linkedRecipe // ignore: cast_nullable_to_non_nullable
as LinkedRecipeModel?,linkedMenuPlan: freezed == linkedMenuPlan ? _self.linkedMenuPlan : linkedMenuPlan // ignore: cast_nullable_to_non_nullable
as LinkedMenuPlanModel?,
  ));
}

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedBoardModelCopyWith<$Res>? get linkedBoard {
    if (_self.linkedBoard == null) {
    return null;
  }

  return $LinkedBoardModelCopyWith<$Res>(_self.linkedBoard!, (value) {
    return _then(_self.copyWith(linkedBoard: value));
  });
}/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedRecipeModelCopyWith<$Res>? get linkedRecipe {
    if (_self.linkedRecipe == null) {
    return null;
  }

  return $LinkedRecipeModelCopyWith<$Res>(_self.linkedRecipe!, (value) {
    return _then(_self.copyWith(linkedRecipe: value));
  });
}/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinkedMenuPlanModelCopyWith<$Res>? get linkedMenuPlan {
    if (_self.linkedMenuPlan == null) {
    return null;
  }

  return $LinkedMenuPlanModelCopyWith<$Res>(_self.linkedMenuPlan!, (value) {
    return _then(_self.copyWith(linkedMenuPlan: value));
  });
}
}

/// @nodoc


class TimelineMenuItem implements TimelineItemModel {
  const TimelineMenuItem({required this.id, required this.date, required this.title, required this.mealType, this.recipe, this.menuPlan});
  

@override final  String id;
@override final  DateTime date;
@override final  String title;
 final  String mealType;
 final  TimelineRecipeRef? recipe;
 final  TimelineMenuPlanRef? menuPlan;

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineMenuItemCopyWith<TimelineMenuItem> get copyWith => _$TimelineMenuItemCopyWithImpl<TimelineMenuItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineMenuItem&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.mealType, mealType) || other.mealType == mealType)&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.menuPlan, menuPlan) || other.menuPlan == menuPlan));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,title,mealType,recipe,menuPlan);

@override
String toString() {
  return 'TimelineItemModel.menuItem(id: $id, date: $date, title: $title, mealType: $mealType, recipe: $recipe, menuPlan: $menuPlan)';
}


}

/// @nodoc
abstract mixin class $TimelineMenuItemCopyWith<$Res> implements $TimelineItemModelCopyWith<$Res> {
  factory $TimelineMenuItemCopyWith(TimelineMenuItem value, $Res Function(TimelineMenuItem) _then) = _$TimelineMenuItemCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String title, String mealType, TimelineRecipeRef? recipe, TimelineMenuPlanRef? menuPlan
});


$TimelineRecipeRefCopyWith<$Res>? get recipe;$TimelineMenuPlanRefCopyWith<$Res>? get menuPlan;

}
/// @nodoc
class _$TimelineMenuItemCopyWithImpl<$Res>
    implements $TimelineMenuItemCopyWith<$Res> {
  _$TimelineMenuItemCopyWithImpl(this._self, this._then);

  final TimelineMenuItem _self;
  final $Res Function(TimelineMenuItem) _then;

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? title = null,Object? mealType = null,Object? recipe = freezed,Object? menuPlan = freezed,}) {
  return _then(TimelineMenuItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mealType: null == mealType ? _self.mealType : mealType // ignore: cast_nullable_to_non_nullable
as String,recipe: freezed == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as TimelineRecipeRef?,menuPlan: freezed == menuPlan ? _self.menuPlan : menuPlan // ignore: cast_nullable_to_non_nullable
as TimelineMenuPlanRef?,
  ));
}

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimelineRecipeRefCopyWith<$Res>? get recipe {
    if (_self.recipe == null) {
    return null;
  }

  return $TimelineRecipeRefCopyWith<$Res>(_self.recipe!, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimelineMenuPlanRefCopyWith<$Res>? get menuPlan {
    if (_self.menuPlan == null) {
    return null;
  }

  return $TimelineMenuPlanRefCopyWith<$Res>(_self.menuPlan!, (value) {
    return _then(_self.copyWith(menuPlan: value));
  });
}
}

/// @nodoc


class TimelineBoardItem implements TimelineItemModel {
  const TimelineBoardItem({required this.id, required this.date, required this.title, required this.itemType, this.url, this.thumbnailUrl, this.board, this.createdBy});
  

@override final  String id;
@override final  DateTime date;
@override final  String title;
 final  String itemType;
 final  String? url;
 final  String? thumbnailUrl;
 final  TimelineBoardRef? board;
 final  CalendarUserModel? createdBy;

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineBoardItemCopyWith<TimelineBoardItem> get copyWith => _$TimelineBoardItemCopyWithImpl<TimelineBoardItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineBoardItem&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.board, board) || other.board == board)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,title,itemType,url,thumbnailUrl,board,createdBy);

@override
String toString() {
  return 'TimelineItemModel.boardItem(id: $id, date: $date, title: $title, itemType: $itemType, url: $url, thumbnailUrl: $thumbnailUrl, board: $board, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $TimelineBoardItemCopyWith<$Res> implements $TimelineItemModelCopyWith<$Res> {
  factory $TimelineBoardItemCopyWith(TimelineBoardItem value, $Res Function(TimelineBoardItem) _then) = _$TimelineBoardItemCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String title, String itemType, String? url, String? thumbnailUrl, TimelineBoardRef? board, CalendarUserModel? createdBy
});


$TimelineBoardRefCopyWith<$Res>? get board;$CalendarUserModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class _$TimelineBoardItemCopyWithImpl<$Res>
    implements $TimelineBoardItemCopyWith<$Res> {
  _$TimelineBoardItemCopyWithImpl(this._self, this._then);

  final TimelineBoardItem _self;
  final $Res Function(TimelineBoardItem) _then;

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? title = null,Object? itemType = null,Object? url = freezed,Object? thumbnailUrl = freezed,Object? board = freezed,Object? createdBy = freezed,}) {
  return _then(TimelineBoardItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,board: freezed == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as TimelineBoardRef?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CalendarUserModel?,
  ));
}

/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimelineBoardRefCopyWith<$Res>? get board {
    if (_self.board == null) {
    return null;
  }

  return $TimelineBoardRefCopyWith<$Res>(_self.board!, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of TimelineItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarUserModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $CalendarUserModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// @nodoc
mixin _$TimelineRecipeRef {

 String get id; String get title; String? get imageUrl;
/// Create a copy of TimelineRecipeRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineRecipeRefCopyWith<TimelineRecipeRef> get copyWith => _$TimelineRecipeRefCopyWithImpl<TimelineRecipeRef>(this as TimelineRecipeRef, _$identity);

  /// Serializes this TimelineRecipeRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineRecipeRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl);

@override
String toString() {
  return 'TimelineRecipeRef(id: $id, title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $TimelineRecipeRefCopyWith<$Res>  {
  factory $TimelineRecipeRefCopyWith(TimelineRecipeRef value, $Res Function(TimelineRecipeRef) _then) = _$TimelineRecipeRefCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? imageUrl
});




}
/// @nodoc
class _$TimelineRecipeRefCopyWithImpl<$Res>
    implements $TimelineRecipeRefCopyWith<$Res> {
  _$TimelineRecipeRefCopyWithImpl(this._self, this._then);

  final TimelineRecipeRef _self;
  final $Res Function(TimelineRecipeRef) _then;

/// Create a copy of TimelineRecipeRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineRecipeRef].
extension TimelineRecipeRefPatterns on TimelineRecipeRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineRecipeRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineRecipeRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineRecipeRef value)  $default,){
final _that = this;
switch (_that) {
case _TimelineRecipeRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineRecipeRef value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineRecipeRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineRecipeRef() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _TimelineRecipeRef():
return $default(_that.id,_that.title,_that.imageUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _TimelineRecipeRef() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimelineRecipeRef implements TimelineRecipeRef {
  const _TimelineRecipeRef({required this.id, required this.title, this.imageUrl});
  factory _TimelineRecipeRef.fromJson(Map<String, dynamic> json) => _$TimelineRecipeRefFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? imageUrl;

/// Create a copy of TimelineRecipeRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineRecipeRefCopyWith<_TimelineRecipeRef> get copyWith => __$TimelineRecipeRefCopyWithImpl<_TimelineRecipeRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimelineRecipeRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineRecipeRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl);

@override
String toString() {
  return 'TimelineRecipeRef(id: $id, title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$TimelineRecipeRefCopyWith<$Res> implements $TimelineRecipeRefCopyWith<$Res> {
  factory _$TimelineRecipeRefCopyWith(_TimelineRecipeRef value, $Res Function(_TimelineRecipeRef) _then) = __$TimelineRecipeRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? imageUrl
});




}
/// @nodoc
class __$TimelineRecipeRefCopyWithImpl<$Res>
    implements _$TimelineRecipeRefCopyWith<$Res> {
  __$TimelineRecipeRefCopyWithImpl(this._self, this._then);

  final _TimelineRecipeRef _self;
  final $Res Function(_TimelineRecipeRef) _then;

/// Create a copy of TimelineRecipeRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? imageUrl = freezed,}) {
  return _then(_TimelineRecipeRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TimelineMenuPlanRef {

 String get id; String get name;
/// Create a copy of TimelineMenuPlanRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineMenuPlanRefCopyWith<TimelineMenuPlanRef> get copyWith => _$TimelineMenuPlanRefCopyWithImpl<TimelineMenuPlanRef>(this as TimelineMenuPlanRef, _$identity);

  /// Serializes this TimelineMenuPlanRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineMenuPlanRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TimelineMenuPlanRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $TimelineMenuPlanRefCopyWith<$Res>  {
  factory $TimelineMenuPlanRefCopyWith(TimelineMenuPlanRef value, $Res Function(TimelineMenuPlanRef) _then) = _$TimelineMenuPlanRefCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$TimelineMenuPlanRefCopyWithImpl<$Res>
    implements $TimelineMenuPlanRefCopyWith<$Res> {
  _$TimelineMenuPlanRefCopyWithImpl(this._self, this._then);

  final TimelineMenuPlanRef _self;
  final $Res Function(TimelineMenuPlanRef) _then;

/// Create a copy of TimelineMenuPlanRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineMenuPlanRef].
extension TimelineMenuPlanRefPatterns on TimelineMenuPlanRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineMenuPlanRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineMenuPlanRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineMenuPlanRef value)  $default,){
final _that = this;
switch (_that) {
case _TimelineMenuPlanRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineMenuPlanRef value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineMenuPlanRef() when $default != null:
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
case _TimelineMenuPlanRef() when $default != null:
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
case _TimelineMenuPlanRef():
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
case _TimelineMenuPlanRef() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimelineMenuPlanRef implements TimelineMenuPlanRef {
  const _TimelineMenuPlanRef({required this.id, required this.name});
  factory _TimelineMenuPlanRef.fromJson(Map<String, dynamic> json) => _$TimelineMenuPlanRefFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of TimelineMenuPlanRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineMenuPlanRefCopyWith<_TimelineMenuPlanRef> get copyWith => __$TimelineMenuPlanRefCopyWithImpl<_TimelineMenuPlanRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimelineMenuPlanRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineMenuPlanRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TimelineMenuPlanRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TimelineMenuPlanRefCopyWith<$Res> implements $TimelineMenuPlanRefCopyWith<$Res> {
  factory _$TimelineMenuPlanRefCopyWith(_TimelineMenuPlanRef value, $Res Function(_TimelineMenuPlanRef) _then) = __$TimelineMenuPlanRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$TimelineMenuPlanRefCopyWithImpl<$Res>
    implements _$TimelineMenuPlanRefCopyWith<$Res> {
  __$TimelineMenuPlanRefCopyWithImpl(this._self, this._then);

  final _TimelineMenuPlanRef _self;
  final $Res Function(_TimelineMenuPlanRef) _then;

/// Create a copy of TimelineMenuPlanRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_TimelineMenuPlanRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TimelineBoardRef {

 String get id; String get name;
/// Create a copy of TimelineBoardRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineBoardRefCopyWith<TimelineBoardRef> get copyWith => _$TimelineBoardRefCopyWithImpl<TimelineBoardRef>(this as TimelineBoardRef, _$identity);

  /// Serializes this TimelineBoardRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineBoardRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TimelineBoardRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $TimelineBoardRefCopyWith<$Res>  {
  factory $TimelineBoardRefCopyWith(TimelineBoardRef value, $Res Function(TimelineBoardRef) _then) = _$TimelineBoardRefCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$TimelineBoardRefCopyWithImpl<$Res>
    implements $TimelineBoardRefCopyWith<$Res> {
  _$TimelineBoardRefCopyWithImpl(this._self, this._then);

  final TimelineBoardRef _self;
  final $Res Function(TimelineBoardRef) _then;

/// Create a copy of TimelineBoardRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineBoardRef].
extension TimelineBoardRefPatterns on TimelineBoardRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineBoardRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineBoardRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineBoardRef value)  $default,){
final _that = this;
switch (_that) {
case _TimelineBoardRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineBoardRef value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineBoardRef() when $default != null:
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
case _TimelineBoardRef() when $default != null:
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
case _TimelineBoardRef():
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
case _TimelineBoardRef() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimelineBoardRef implements TimelineBoardRef {
  const _TimelineBoardRef({required this.id, required this.name});
  factory _TimelineBoardRef.fromJson(Map<String, dynamic> json) => _$TimelineBoardRefFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of TimelineBoardRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineBoardRefCopyWith<_TimelineBoardRef> get copyWith => __$TimelineBoardRefCopyWithImpl<_TimelineBoardRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimelineBoardRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineBoardRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TimelineBoardRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TimelineBoardRefCopyWith<$Res> implements $TimelineBoardRefCopyWith<$Res> {
  factory _$TimelineBoardRefCopyWith(_TimelineBoardRef value, $Res Function(_TimelineBoardRef) _then) = __$TimelineBoardRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$TimelineBoardRefCopyWithImpl<$Res>
    implements _$TimelineBoardRefCopyWith<$Res> {
  __$TimelineBoardRefCopyWithImpl(this._self, this._then);

  final _TimelineBoardRef _self;
  final $Res Function(_TimelineBoardRef) _then;

/// Create a copy of TimelineBoardRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_TimelineBoardRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AvailabilityDayModel {

 String get date; List<AvailabilityEventModel> get events; bool get isFree;
/// Create a copy of AvailabilityDayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityDayModelCopyWith<AvailabilityDayModel> get copyWith => _$AvailabilityDayModelCopyWithImpl<AvailabilityDayModel>(this as AvailabilityDayModel, _$identity);

  /// Serializes this AvailabilityDayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityDayModel&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.isFree, isFree) || other.isFree == isFree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(events),isFree);

@override
String toString() {
  return 'AvailabilityDayModel(date: $date, events: $events, isFree: $isFree)';
}


}

/// @nodoc
abstract mixin class $AvailabilityDayModelCopyWith<$Res>  {
  factory $AvailabilityDayModelCopyWith(AvailabilityDayModel value, $Res Function(AvailabilityDayModel) _then) = _$AvailabilityDayModelCopyWithImpl;
@useResult
$Res call({
 String date, List<AvailabilityEventModel> events, bool isFree
});




}
/// @nodoc
class _$AvailabilityDayModelCopyWithImpl<$Res>
    implements $AvailabilityDayModelCopyWith<$Res> {
  _$AvailabilityDayModelCopyWithImpl(this._self, this._then);

  final AvailabilityDayModel _self;
  final $Res Function(AvailabilityDayModel) _then;

/// Create a copy of AvailabilityDayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? events = null,Object? isFree = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<AvailabilityEventModel>,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityDayModel].
extension AvailabilityDayModelPatterns on AvailabilityDayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityDayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityDayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityDayModel value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityDayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityDayModel value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityDayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  List<AvailabilityEventModel> events,  bool isFree)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityDayModel() when $default != null:
return $default(_that.date,_that.events,_that.isFree);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  List<AvailabilityEventModel> events,  bool isFree)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityDayModel():
return $default(_that.date,_that.events,_that.isFree);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  List<AvailabilityEventModel> events,  bool isFree)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityDayModel() when $default != null:
return $default(_that.date,_that.events,_that.isFree);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityDayModel implements AvailabilityDayModel {
  const _AvailabilityDayModel({required this.date, required final  List<AvailabilityEventModel> events, required this.isFree}): _events = events;
  factory _AvailabilityDayModel.fromJson(Map<String, dynamic> json) => _$AvailabilityDayModelFromJson(json);

@override final  String date;
 final  List<AvailabilityEventModel> _events;
@override List<AvailabilityEventModel> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  bool isFree;

/// Create a copy of AvailabilityDayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityDayModelCopyWith<_AvailabilityDayModel> get copyWith => __$AvailabilityDayModelCopyWithImpl<_AvailabilityDayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityDayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityDayModel&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.isFree, isFree) || other.isFree == isFree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_events),isFree);

@override
String toString() {
  return 'AvailabilityDayModel(date: $date, events: $events, isFree: $isFree)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityDayModelCopyWith<$Res> implements $AvailabilityDayModelCopyWith<$Res> {
  factory _$AvailabilityDayModelCopyWith(_AvailabilityDayModel value, $Res Function(_AvailabilityDayModel) _then) = __$AvailabilityDayModelCopyWithImpl;
@override @useResult
$Res call({
 String date, List<AvailabilityEventModel> events, bool isFree
});




}
/// @nodoc
class __$AvailabilityDayModelCopyWithImpl<$Res>
    implements _$AvailabilityDayModelCopyWith<$Res> {
  __$AvailabilityDayModelCopyWithImpl(this._self, this._then);

  final _AvailabilityDayModel _self;
  final $Res Function(_AvailabilityDayModel) _then;

/// Create a copy of AvailabilityDayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? events = null,Object? isFree = null,}) {
  return _then(_AvailabilityDayModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<AvailabilityEventModel>,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AvailabilityEventModel {

 String get id; String get title; String get startDate; String? get endDate; bool get allDay; String get createdById;
/// Create a copy of AvailabilityEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityEventModelCopyWith<AvailabilityEventModel> get copyWith => _$AvailabilityEventModelCopyWithImpl<AvailabilityEventModel>(this as AvailabilityEventModel, _$identity);

  /// Serializes this AvailabilityEventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.createdById, createdById) || other.createdById == createdById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startDate,endDate,allDay,createdById);

@override
String toString() {
  return 'AvailabilityEventModel(id: $id, title: $title, startDate: $startDate, endDate: $endDate, allDay: $allDay, createdById: $createdById)';
}


}

/// @nodoc
abstract mixin class $AvailabilityEventModelCopyWith<$Res>  {
  factory $AvailabilityEventModelCopyWith(AvailabilityEventModel value, $Res Function(AvailabilityEventModel) _then) = _$AvailabilityEventModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String startDate, String? endDate, bool allDay, String createdById
});




}
/// @nodoc
class _$AvailabilityEventModelCopyWithImpl<$Res>
    implements $AvailabilityEventModelCopyWith<$Res> {
  _$AvailabilityEventModelCopyWithImpl(this._self, this._then);

  final AvailabilityEventModel _self;
  final $Res Function(AvailabilityEventModel) _then;

/// Create a copy of AvailabilityEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startDate = null,Object? endDate = freezed,Object? allDay = null,Object? createdById = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityEventModel].
extension AvailabilityEventModelPatterns on AvailabilityEventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityEventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityEventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityEventModel value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityEventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityEventModel value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityEventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String startDate,  String? endDate,  bool allDay,  String createdById)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityEventModel() when $default != null:
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.allDay,_that.createdById);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String startDate,  String? endDate,  bool allDay,  String createdById)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityEventModel():
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.allDay,_that.createdById);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String startDate,  String? endDate,  bool allDay,  String createdById)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityEventModel() when $default != null:
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.allDay,_that.createdById);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityEventModel implements AvailabilityEventModel {
  const _AvailabilityEventModel({required this.id, required this.title, required this.startDate, this.endDate, required this.allDay, required this.createdById});
  factory _AvailabilityEventModel.fromJson(Map<String, dynamic> json) => _$AvailabilityEventModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String startDate;
@override final  String? endDate;
@override final  bool allDay;
@override final  String createdById;

/// Create a copy of AvailabilityEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityEventModelCopyWith<_AvailabilityEventModel> get copyWith => __$AvailabilityEventModelCopyWithImpl<_AvailabilityEventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityEventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.createdById, createdById) || other.createdById == createdById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startDate,endDate,allDay,createdById);

@override
String toString() {
  return 'AvailabilityEventModel(id: $id, title: $title, startDate: $startDate, endDate: $endDate, allDay: $allDay, createdById: $createdById)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityEventModelCopyWith<$Res> implements $AvailabilityEventModelCopyWith<$Res> {
  factory _$AvailabilityEventModelCopyWith(_AvailabilityEventModel value, $Res Function(_AvailabilityEventModel) _then) = __$AvailabilityEventModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String startDate, String? endDate, bool allDay, String createdById
});




}
/// @nodoc
class __$AvailabilityEventModelCopyWithImpl<$Res>
    implements _$AvailabilityEventModelCopyWith<$Res> {
  __$AvailabilityEventModelCopyWithImpl(this._self, this._then);

  final _AvailabilityEventModel _self;
  final $Res Function(_AvailabilityEventModel) _then;

/// Create a copy of AvailabilityEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startDate = null,Object? endDate = freezed,Object? allDay = null,Object? createdById = null,}) {
  return _then(_AvailabilityEventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AvailabilityMemberModel {

 String get userId; String get name; String get colorHex;
/// Create a copy of AvailabilityMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityMemberModelCopyWith<AvailabilityMemberModel> get copyWith => _$AvailabilityMemberModelCopyWithImpl<AvailabilityMemberModel>(this as AvailabilityMemberModel, _$identity);

  /// Serializes this AvailabilityMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityMemberModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,colorHex);

@override
String toString() {
  return 'AvailabilityMemberModel(userId: $userId, name: $name, colorHex: $colorHex)';
}


}

/// @nodoc
abstract mixin class $AvailabilityMemberModelCopyWith<$Res>  {
  factory $AvailabilityMemberModelCopyWith(AvailabilityMemberModel value, $Res Function(AvailabilityMemberModel) _then) = _$AvailabilityMemberModelCopyWithImpl;
@useResult
$Res call({
 String userId, String name, String colorHex
});




}
/// @nodoc
class _$AvailabilityMemberModelCopyWithImpl<$Res>
    implements $AvailabilityMemberModelCopyWith<$Res> {
  _$AvailabilityMemberModelCopyWithImpl(this._self, this._then);

  final AvailabilityMemberModel _self;
  final $Res Function(AvailabilityMemberModel) _then;

/// Create a copy of AvailabilityMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = null,Object? colorHex = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityMemberModel].
extension AvailabilityMemberModelPatterns on AvailabilityMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String name,  String colorHex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityMemberModel() when $default != null:
return $default(_that.userId,_that.name,_that.colorHex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String name,  String colorHex)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityMemberModel():
return $default(_that.userId,_that.name,_that.colorHex);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String name,  String colorHex)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityMemberModel() when $default != null:
return $default(_that.userId,_that.name,_that.colorHex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityMemberModel implements AvailabilityMemberModel {
  const _AvailabilityMemberModel({required this.userId, required this.name, required this.colorHex});
  factory _AvailabilityMemberModel.fromJson(Map<String, dynamic> json) => _$AvailabilityMemberModelFromJson(json);

@override final  String userId;
@override final  String name;
@override final  String colorHex;

/// Create a copy of AvailabilityMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityMemberModelCopyWith<_AvailabilityMemberModel> get copyWith => __$AvailabilityMemberModelCopyWithImpl<_AvailabilityMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityMemberModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,colorHex);

@override
String toString() {
  return 'AvailabilityMemberModel(userId: $userId, name: $name, colorHex: $colorHex)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityMemberModelCopyWith<$Res> implements $AvailabilityMemberModelCopyWith<$Res> {
  factory _$AvailabilityMemberModelCopyWith(_AvailabilityMemberModel value, $Res Function(_AvailabilityMemberModel) _then) = __$AvailabilityMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String name, String colorHex
});




}
/// @nodoc
class __$AvailabilityMemberModelCopyWithImpl<$Res>
    implements _$AvailabilityMemberModelCopyWith<$Res> {
  __$AvailabilityMemberModelCopyWithImpl(this._self, this._then);

  final _AvailabilityMemberModel _self;
  final $Res Function(_AvailabilityMemberModel) _then;

/// Create a copy of AvailabilityMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? colorHex = null,}) {
  return _then(_AvailabilityMemberModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AvailabilityResultModel {

 List<AvailabilityMemberModel> get members; List<AvailabilityDayModel> get days;
/// Create a copy of AvailabilityResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityResultModelCopyWith<AvailabilityResultModel> get copyWith => _$AvailabilityResultModelCopyWithImpl<AvailabilityResultModel>(this as AvailabilityResultModel, _$identity);

  /// Serializes this AvailabilityResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityResultModel&&const DeepCollectionEquality().equals(other.members, members)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(members),const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'AvailabilityResultModel(members: $members, days: $days)';
}


}

/// @nodoc
abstract mixin class $AvailabilityResultModelCopyWith<$Res>  {
  factory $AvailabilityResultModelCopyWith(AvailabilityResultModel value, $Res Function(AvailabilityResultModel) _then) = _$AvailabilityResultModelCopyWithImpl;
@useResult
$Res call({
 List<AvailabilityMemberModel> members, List<AvailabilityDayModel> days
});




}
/// @nodoc
class _$AvailabilityResultModelCopyWithImpl<$Res>
    implements $AvailabilityResultModelCopyWith<$Res> {
  _$AvailabilityResultModelCopyWithImpl(this._self, this._then);

  final AvailabilityResultModel _self;
  final $Res Function(AvailabilityResultModel) _then;

/// Create a copy of AvailabilityResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? members = null,Object? days = null,}) {
  return _then(_self.copyWith(
members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<AvailabilityMemberModel>,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<AvailabilityDayModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityResultModel].
extension AvailabilityResultModelPatterns on AvailabilityResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityResultModel value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AvailabilityMemberModel> members,  List<AvailabilityDayModel> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityResultModel() when $default != null:
return $default(_that.members,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AvailabilityMemberModel> members,  List<AvailabilityDayModel> days)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityResultModel():
return $default(_that.members,_that.days);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AvailabilityMemberModel> members,  List<AvailabilityDayModel> days)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityResultModel() when $default != null:
return $default(_that.members,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityResultModel implements AvailabilityResultModel {
  const _AvailabilityResultModel({required final  List<AvailabilityMemberModel> members, required final  List<AvailabilityDayModel> days}): _members = members,_days = days;
  factory _AvailabilityResultModel.fromJson(Map<String, dynamic> json) => _$AvailabilityResultModelFromJson(json);

 final  List<AvailabilityMemberModel> _members;
@override List<AvailabilityMemberModel> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  List<AvailabilityDayModel> _days;
@override List<AvailabilityDayModel> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of AvailabilityResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityResultModelCopyWith<_AvailabilityResultModel> get copyWith => __$AvailabilityResultModelCopyWithImpl<_AvailabilityResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityResultModel&&const DeepCollectionEquality().equals(other._members, _members)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'AvailabilityResultModel(members: $members, days: $days)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityResultModelCopyWith<$Res> implements $AvailabilityResultModelCopyWith<$Res> {
  factory _$AvailabilityResultModelCopyWith(_AvailabilityResultModel value, $Res Function(_AvailabilityResultModel) _then) = __$AvailabilityResultModelCopyWithImpl;
@override @useResult
$Res call({
 List<AvailabilityMemberModel> members, List<AvailabilityDayModel> days
});




}
/// @nodoc
class __$AvailabilityResultModelCopyWithImpl<$Res>
    implements _$AvailabilityResultModelCopyWith<$Res> {
  __$AvailabilityResultModelCopyWithImpl(this._self, this._then);

  final _AvailabilityResultModel _self;
  final $Res Function(_AvailabilityResultModel) _then;

/// Create a copy of AvailabilityResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? members = null,Object? days = null,}) {
  return _then(_AvailabilityResultModel(
members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<AvailabilityMemberModel>,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<AvailabilityDayModel>,
  ));
}


}

// dart format on
