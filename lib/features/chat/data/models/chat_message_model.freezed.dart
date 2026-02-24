// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessageModel {

 String get id; String get role;// "user" | "assistant"
 String? get content; List<String> get imageUrls; List<ChatToolCallModel> get toolCalls; ChatUserModel? get user; DateTime get createdAt;
/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<ChatMessageModel> get copyWith => _$ChatMessageModelCopyWithImpl<ChatMessageModel>(this as ChatMessageModel, _$identity);

  /// Serializes this ChatMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&const DeepCollectionEquality().equals(other.toolCalls, toolCalls)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,content,const DeepCollectionEquality().hash(imageUrls),const DeepCollectionEquality().hash(toolCalls),user,createdAt);

@override
String toString() {
  return 'ChatMessageModel(id: $id, role: $role, content: $content, imageUrls: $imageUrls, toolCalls: $toolCalls, user: $user, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ChatMessageModelCopyWith<$Res>  {
  factory $ChatMessageModelCopyWith(ChatMessageModel value, $Res Function(ChatMessageModel) _then) = _$ChatMessageModelCopyWithImpl;
@useResult
$Res call({
 String id, String role, String? content, List<String> imageUrls, List<ChatToolCallModel> toolCalls, ChatUserModel? user, DateTime createdAt
});


$ChatUserModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$ChatMessageModelCopyWithImpl<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  _$ChatMessageModelCopyWithImpl(this._self, this._then);

  final ChatMessageModel _self;
  final $Res Function(ChatMessageModel) _then;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? content = freezed,Object? imageUrls = null,Object? toolCalls = null,Object? user = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,toolCalls: null == toolCalls ? _self.toolCalls : toolCalls // ignore: cast_nullable_to_non_nullable
as List<ChatToolCallModel>,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ChatUserModel?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ChatUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatMessageModel].
extension ChatMessageModelPatterns on ChatMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String role,  String? content,  List<String> imageUrls,  List<ChatToolCallModel> toolCalls,  ChatUserModel? user,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that.id,_that.role,_that.content,_that.imageUrls,_that.toolCalls,_that.user,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String role,  String? content,  List<String> imageUrls,  List<ChatToolCallModel> toolCalls,  ChatUserModel? user,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageModel():
return $default(_that.id,_that.role,_that.content,_that.imageUrls,_that.toolCalls,_that.user,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String role,  String? content,  List<String> imageUrls,  List<ChatToolCallModel> toolCalls,  ChatUserModel? user,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that.id,_that.role,_that.content,_that.imageUrls,_that.toolCalls,_that.user,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageModel implements ChatMessageModel {
  const _ChatMessageModel({required this.id, required this.role, this.content, final  List<String> imageUrls = const [], final  List<ChatToolCallModel> toolCalls = const [], this.user, required this.createdAt}): _imageUrls = imageUrls,_toolCalls = toolCalls;
  factory _ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);

@override final  String id;
@override final  String role;
// "user" | "assistant"
@override final  String? content;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

 final  List<ChatToolCallModel> _toolCalls;
@override@JsonKey() List<ChatToolCallModel> get toolCalls {
  if (_toolCalls is EqualUnmodifiableListView) return _toolCalls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_toolCalls);
}

@override final  ChatUserModel? user;
@override final  DateTime createdAt;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageModelCopyWith<_ChatMessageModel> get copyWith => __$ChatMessageModelCopyWithImpl<_ChatMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&const DeepCollectionEquality().equals(other._toolCalls, _toolCalls)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,content,const DeepCollectionEquality().hash(_imageUrls),const DeepCollectionEquality().hash(_toolCalls),user,createdAt);

@override
String toString() {
  return 'ChatMessageModel(id: $id, role: $role, content: $content, imageUrls: $imageUrls, toolCalls: $toolCalls, user: $user, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageModelCopyWith<$Res> implements $ChatMessageModelCopyWith<$Res> {
  factory _$ChatMessageModelCopyWith(_ChatMessageModel value, $Res Function(_ChatMessageModel) _then) = __$ChatMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String role, String? content, List<String> imageUrls, List<ChatToolCallModel> toolCalls, ChatUserModel? user, DateTime createdAt
});


@override $ChatUserModelCopyWith<$Res>? get user;

}
/// @nodoc
class __$ChatMessageModelCopyWithImpl<$Res>
    implements _$ChatMessageModelCopyWith<$Res> {
  __$ChatMessageModelCopyWithImpl(this._self, this._then);

  final _ChatMessageModel _self;
  final $Res Function(_ChatMessageModel) _then;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? content = freezed,Object? imageUrls = null,Object? toolCalls = null,Object? user = freezed,Object? createdAt = null,}) {
  return _then(_ChatMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,toolCalls: null == toolCalls ? _self._toolCalls : toolCalls // ignore: cast_nullable_to_non_nullable
as List<ChatToolCallModel>,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ChatUserModel?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ChatUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$ChatToolCallModel {

 String get tool; Map<String, dynamic> get params;
/// Create a copy of ChatToolCallModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatToolCallModelCopyWith<ChatToolCallModel> get copyWith => _$ChatToolCallModelCopyWithImpl<ChatToolCallModel>(this as ChatToolCallModel, _$identity);

  /// Serializes this ChatToolCallModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatToolCallModel&&(identical(other.tool, tool) || other.tool == tool)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tool,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'ChatToolCallModel(tool: $tool, params: $params)';
}


}

/// @nodoc
abstract mixin class $ChatToolCallModelCopyWith<$Res>  {
  factory $ChatToolCallModelCopyWith(ChatToolCallModel value, $Res Function(ChatToolCallModel) _then) = _$ChatToolCallModelCopyWithImpl;
@useResult
$Res call({
 String tool, Map<String, dynamic> params
});




}
/// @nodoc
class _$ChatToolCallModelCopyWithImpl<$Res>
    implements $ChatToolCallModelCopyWith<$Res> {
  _$ChatToolCallModelCopyWithImpl(this._self, this._then);

  final ChatToolCallModel _self;
  final $Res Function(ChatToolCallModel) _then;

/// Create a copy of ChatToolCallModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tool = null,Object? params = null,}) {
  return _then(_self.copyWith(
tool: null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatToolCallModel].
extension ChatToolCallModelPatterns on ChatToolCallModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatToolCallModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatToolCallModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatToolCallModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatToolCallModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatToolCallModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatToolCallModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tool,  Map<String, dynamic> params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatToolCallModel() when $default != null:
return $default(_that.tool,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tool,  Map<String, dynamic> params)  $default,) {final _that = this;
switch (_that) {
case _ChatToolCallModel():
return $default(_that.tool,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tool,  Map<String, dynamic> params)?  $default,) {final _that = this;
switch (_that) {
case _ChatToolCallModel() when $default != null:
return $default(_that.tool,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatToolCallModel implements ChatToolCallModel {
  const _ChatToolCallModel({required this.tool, final  Map<String, dynamic> params = const {}}): _params = params;
  factory _ChatToolCallModel.fromJson(Map<String, dynamic> json) => _$ChatToolCallModelFromJson(json);

@override final  String tool;
 final  Map<String, dynamic> _params;
@override@JsonKey() Map<String, dynamic> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}


/// Create a copy of ChatToolCallModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatToolCallModelCopyWith<_ChatToolCallModel> get copyWith => __$ChatToolCallModelCopyWithImpl<_ChatToolCallModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatToolCallModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatToolCallModel&&(identical(other.tool, tool) || other.tool == tool)&&const DeepCollectionEquality().equals(other._params, _params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tool,const DeepCollectionEquality().hash(_params));

@override
String toString() {
  return 'ChatToolCallModel(tool: $tool, params: $params)';
}


}

/// @nodoc
abstract mixin class _$ChatToolCallModelCopyWith<$Res> implements $ChatToolCallModelCopyWith<$Res> {
  factory _$ChatToolCallModelCopyWith(_ChatToolCallModel value, $Res Function(_ChatToolCallModel) _then) = __$ChatToolCallModelCopyWithImpl;
@override @useResult
$Res call({
 String tool, Map<String, dynamic> params
});




}
/// @nodoc
class __$ChatToolCallModelCopyWithImpl<$Res>
    implements _$ChatToolCallModelCopyWith<$Res> {
  __$ChatToolCallModelCopyWithImpl(this._self, this._then);

  final _ChatToolCallModel _self;
  final $Res Function(_ChatToolCallModel) _then;

/// Create a copy of ChatToolCallModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tool = null,Object? params = null,}) {
  return _then(_ChatToolCallModel(
tool: null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$ChatUserModel {

 String get id; String get name; String? get avatarUrl;
/// Create a copy of ChatUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatUserModelCopyWith<ChatUserModel> get copyWith => _$ChatUserModelCopyWithImpl<ChatUserModel>(this as ChatUserModel, _$identity);

  /// Serializes this ChatUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ChatUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $ChatUserModelCopyWith<$Res>  {
  factory $ChatUserModelCopyWith(ChatUserModel value, $Res Function(ChatUserModel) _then) = _$ChatUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class _$ChatUserModelCopyWithImpl<$Res>
    implements $ChatUserModelCopyWith<$Res> {
  _$ChatUserModelCopyWithImpl(this._self, this._then);

  final ChatUserModel _self;
  final $Res Function(ChatUserModel) _then;

/// Create a copy of ChatUserModel
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


/// Adds pattern-matching-related methods to [ChatUserModel].
extension ChatUserModelPatterns on ChatUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatUserModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatUserModel() when $default != null:
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
case _ChatUserModel() when $default != null:
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
case _ChatUserModel():
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
case _ChatUserModel() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatUserModel implements ChatUserModel {
  const _ChatUserModel({required this.id, required this.name, this.avatarUrl});
  factory _ChatUserModel.fromJson(Map<String, dynamic> json) => _$ChatUserModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of ChatUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatUserModelCopyWith<_ChatUserModel> get copyWith => __$ChatUserModelCopyWithImpl<_ChatUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ChatUserModel(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ChatUserModelCopyWith<$Res> implements $ChatUserModelCopyWith<$Res> {
  factory _$ChatUserModelCopyWith(_ChatUserModel value, $Res Function(_ChatUserModel) _then) = __$ChatUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl
});




}
/// @nodoc
class __$ChatUserModelCopyWithImpl<$Res>
    implements _$ChatUserModelCopyWith<$Res> {
  __$ChatUserModelCopyWithImpl(this._self, this._then);

  final _ChatUserModel _self;
  final $Res Function(_ChatUserModel) _then;

/// Create a copy of ChatUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_ChatUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
