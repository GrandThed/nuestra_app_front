// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoardModel {

 String get id; String get name; String? get coverUrl; int get itemCount; DateTime get createdAt; List<BoardItemModel>? get items; List<String> get previewItems;
/// Create a copy of BoardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardModelCopyWith<BoardModel> get copyWith => _$BoardModelCopyWithImpl<BoardModel>(this as BoardModel, _$identity);

  /// Serializes this BoardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.previewItems, previewItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,coverUrl,itemCount,createdAt,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(previewItems));

@override
String toString() {
  return 'BoardModel(id: $id, name: $name, coverUrl: $coverUrl, itemCount: $itemCount, createdAt: $createdAt, items: $items, previewItems: $previewItems)';
}


}

/// @nodoc
abstract mixin class $BoardModelCopyWith<$Res>  {
  factory $BoardModelCopyWith(BoardModel value, $Res Function(BoardModel) _then) = _$BoardModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? coverUrl, int itemCount, DateTime createdAt, List<BoardItemModel>? items, List<String> previewItems
});




}
/// @nodoc
class _$BoardModelCopyWithImpl<$Res>
    implements $BoardModelCopyWith<$Res> {
  _$BoardModelCopyWithImpl(this._self, this._then);

  final BoardModel _self;
  final $Res Function(BoardModel) _then;

/// Create a copy of BoardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coverUrl = freezed,Object? itemCount = null,Object? createdAt = null,Object? items = freezed,Object? previewItems = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<BoardItemModel>?,previewItems: null == previewItems ? _self.previewItems : previewItems // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardModel].
extension BoardModelPatterns on BoardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? coverUrl,  int itemCount,  DateTime createdAt,  List<BoardItemModel>? items,  List<String> previewItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardModel() when $default != null:
return $default(_that.id,_that.name,_that.coverUrl,_that.itemCount,_that.createdAt,_that.items,_that.previewItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? coverUrl,  int itemCount,  DateTime createdAt,  List<BoardItemModel>? items,  List<String> previewItems)  $default,) {final _that = this;
switch (_that) {
case _BoardModel():
return $default(_that.id,_that.name,_that.coverUrl,_that.itemCount,_that.createdAt,_that.items,_that.previewItems);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? coverUrl,  int itemCount,  DateTime createdAt,  List<BoardItemModel>? items,  List<String> previewItems)?  $default,) {final _that = this;
switch (_that) {
case _BoardModel() when $default != null:
return $default(_that.id,_that.name,_that.coverUrl,_that.itemCount,_that.createdAt,_that.items,_that.previewItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardModel implements BoardModel {
  const _BoardModel({required this.id, required this.name, this.coverUrl, this.itemCount = 0, required this.createdAt, final  List<BoardItemModel>? items, final  List<String> previewItems = const []}): _items = items,_previewItems = previewItems;
  factory _BoardModel.fromJson(Map<String, dynamic> json) => _$BoardModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? coverUrl;
@override@JsonKey() final  int itemCount;
@override final  DateTime createdAt;
 final  List<BoardItemModel>? _items;
@override List<BoardItemModel>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String> _previewItems;
@override@JsonKey() List<String> get previewItems {
  if (_previewItems is EqualUnmodifiableListView) return _previewItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previewItems);
}


/// Create a copy of BoardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardModelCopyWith<_BoardModel> get copyWith => __$BoardModelCopyWithImpl<_BoardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._previewItems, _previewItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,coverUrl,itemCount,createdAt,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_previewItems));

@override
String toString() {
  return 'BoardModel(id: $id, name: $name, coverUrl: $coverUrl, itemCount: $itemCount, createdAt: $createdAt, items: $items, previewItems: $previewItems)';
}


}

/// @nodoc
abstract mixin class _$BoardModelCopyWith<$Res> implements $BoardModelCopyWith<$Res> {
  factory _$BoardModelCopyWith(_BoardModel value, $Res Function(_BoardModel) _then) = __$BoardModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? coverUrl, int itemCount, DateTime createdAt, List<BoardItemModel>? items, List<String> previewItems
});




}
/// @nodoc
class __$BoardModelCopyWithImpl<$Res>
    implements _$BoardModelCopyWith<$Res> {
  __$BoardModelCopyWithImpl(this._self, this._then);

  final _BoardModel _self;
  final $Res Function(_BoardModel) _then;

/// Create a copy of BoardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coverUrl = freezed,Object? itemCount = null,Object? createdAt = null,Object? items = freezed,Object? previewItems = null,}) {
  return _then(_BoardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<BoardItemModel>?,previewItems: null == previewItems ? _self._previewItems : previewItems // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$BoardItemModel {

 String get id; String get type;// 'link' or 'photo'
 String? get url; String? get thumbnailUrl; String? get title; String? get description; String? get linkPreviewImage; PhotoBackModel? get photoBack; BoardItemCreatorModel? get createdBy; DateTime get createdAt;
/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardItemModelCopyWith<BoardItemModel> get copyWith => _$BoardItemModelCopyWithImpl<BoardItemModel>(this as BoardItemModel, _$identity);

  /// Serializes this BoardItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.linkPreviewImage, linkPreviewImage) || other.linkPreviewImage == linkPreviewImage)&&(identical(other.photoBack, photoBack) || other.photoBack == photoBack)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,url,thumbnailUrl,title,description,linkPreviewImage,photoBack,createdBy,createdAt);

@override
String toString() {
  return 'BoardItemModel(id: $id, type: $type, url: $url, thumbnailUrl: $thumbnailUrl, title: $title, description: $description, linkPreviewImage: $linkPreviewImage, photoBack: $photoBack, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BoardItemModelCopyWith<$Res>  {
  factory $BoardItemModelCopyWith(BoardItemModel value, $Res Function(BoardItemModel) _then) = _$BoardItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String? url, String? thumbnailUrl, String? title, String? description, String? linkPreviewImage, PhotoBackModel? photoBack, BoardItemCreatorModel? createdBy, DateTime createdAt
});


$PhotoBackModelCopyWith<$Res>? get photoBack;$BoardItemCreatorModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class _$BoardItemModelCopyWithImpl<$Res>
    implements $BoardItemModelCopyWith<$Res> {
  _$BoardItemModelCopyWithImpl(this._self, this._then);

  final BoardItemModel _self;
  final $Res Function(BoardItemModel) _then;

/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? url = freezed,Object? thumbnailUrl = freezed,Object? title = freezed,Object? description = freezed,Object? linkPreviewImage = freezed,Object? photoBack = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,linkPreviewImage: freezed == linkPreviewImage ? _self.linkPreviewImage : linkPreviewImage // ignore: cast_nullable_to_non_nullable
as String?,photoBack: freezed == photoBack ? _self.photoBack : photoBack // ignore: cast_nullable_to_non_nullable
as PhotoBackModel?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as BoardItemCreatorModel?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoBackModelCopyWith<$Res>? get photoBack {
    if (_self.photoBack == null) {
    return null;
  }

  return $PhotoBackModelCopyWith<$Res>(_self.photoBack!, (value) {
    return _then(_self.copyWith(photoBack: value));
  });
}/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardItemCreatorModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $BoardItemCreatorModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [BoardItemModel].
extension BoardItemModelPatterns on BoardItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardItemModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String? url,  String? thumbnailUrl,  String? title,  String? description,  String? linkPreviewImage,  PhotoBackModel? photoBack,  BoardItemCreatorModel? createdBy,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardItemModel() when $default != null:
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.title,_that.description,_that.linkPreviewImage,_that.photoBack,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String? url,  String? thumbnailUrl,  String? title,  String? description,  String? linkPreviewImage,  PhotoBackModel? photoBack,  BoardItemCreatorModel? createdBy,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BoardItemModel():
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.title,_that.description,_that.linkPreviewImage,_that.photoBack,_that.createdBy,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String? url,  String? thumbnailUrl,  String? title,  String? description,  String? linkPreviewImage,  PhotoBackModel? photoBack,  BoardItemCreatorModel? createdBy,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BoardItemModel() when $default != null:
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.title,_that.description,_that.linkPreviewImage,_that.photoBack,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardItemModel implements BoardItemModel {
  const _BoardItemModel({required this.id, required this.type, this.url, this.thumbnailUrl, this.title, this.description, this.linkPreviewImage, this.photoBack, this.createdBy, required this.createdAt});
  factory _BoardItemModel.fromJson(Map<String, dynamic> json) => _$BoardItemModelFromJson(json);

@override final  String id;
@override final  String type;
// 'link' or 'photo'
@override final  String? url;
@override final  String? thumbnailUrl;
@override final  String? title;
@override final  String? description;
@override final  String? linkPreviewImage;
@override final  PhotoBackModel? photoBack;
@override final  BoardItemCreatorModel? createdBy;
@override final  DateTime createdAt;

/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardItemModelCopyWith<_BoardItemModel> get copyWith => __$BoardItemModelCopyWithImpl<_BoardItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.linkPreviewImage, linkPreviewImage) || other.linkPreviewImage == linkPreviewImage)&&(identical(other.photoBack, photoBack) || other.photoBack == photoBack)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,url,thumbnailUrl,title,description,linkPreviewImage,photoBack,createdBy,createdAt);

@override
String toString() {
  return 'BoardItemModel(id: $id, type: $type, url: $url, thumbnailUrl: $thumbnailUrl, title: $title, description: $description, linkPreviewImage: $linkPreviewImage, photoBack: $photoBack, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BoardItemModelCopyWith<$Res> implements $BoardItemModelCopyWith<$Res> {
  factory _$BoardItemModelCopyWith(_BoardItemModel value, $Res Function(_BoardItemModel) _then) = __$BoardItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String? url, String? thumbnailUrl, String? title, String? description, String? linkPreviewImage, PhotoBackModel? photoBack, BoardItemCreatorModel? createdBy, DateTime createdAt
});


@override $PhotoBackModelCopyWith<$Res>? get photoBack;@override $BoardItemCreatorModelCopyWith<$Res>? get createdBy;

}
/// @nodoc
class __$BoardItemModelCopyWithImpl<$Res>
    implements _$BoardItemModelCopyWith<$Res> {
  __$BoardItemModelCopyWithImpl(this._self, this._then);

  final _BoardItemModel _self;
  final $Res Function(_BoardItemModel) _then;

/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? url = freezed,Object? thumbnailUrl = freezed,Object? title = freezed,Object? description = freezed,Object? linkPreviewImage = freezed,Object? photoBack = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_BoardItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,linkPreviewImage: freezed == linkPreviewImage ? _self.linkPreviewImage : linkPreviewImage // ignore: cast_nullable_to_non_nullable
as String?,photoBack: freezed == photoBack ? _self.photoBack : photoBack // ignore: cast_nullable_to_non_nullable
as PhotoBackModel?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as BoardItemCreatorModel?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoBackModelCopyWith<$Res>? get photoBack {
    if (_self.photoBack == null) {
    return null;
  }

  return $PhotoBackModelCopyWith<$Res>(_self.photoBack!, (value) {
    return _then(_self.copyWith(photoBack: value));
  });
}/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardItemCreatorModelCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $BoardItemCreatorModelCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// @nodoc
mixin _$PhotoBackModel {

 String? get drawingUrl; String? get text; String? get date; String? get place;
/// Create a copy of PhotoBackModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoBackModelCopyWith<PhotoBackModel> get copyWith => _$PhotoBackModelCopyWithImpl<PhotoBackModel>(this as PhotoBackModel, _$identity);

  /// Serializes this PhotoBackModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoBackModel&&(identical(other.drawingUrl, drawingUrl) || other.drawingUrl == drawingUrl)&&(identical(other.text, text) || other.text == text)&&(identical(other.date, date) || other.date == date)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,drawingUrl,text,date,place);

@override
String toString() {
  return 'PhotoBackModel(drawingUrl: $drawingUrl, text: $text, date: $date, place: $place)';
}


}

/// @nodoc
abstract mixin class $PhotoBackModelCopyWith<$Res>  {
  factory $PhotoBackModelCopyWith(PhotoBackModel value, $Res Function(PhotoBackModel) _then) = _$PhotoBackModelCopyWithImpl;
@useResult
$Res call({
 String? drawingUrl, String? text, String? date, String? place
});




}
/// @nodoc
class _$PhotoBackModelCopyWithImpl<$Res>
    implements $PhotoBackModelCopyWith<$Res> {
  _$PhotoBackModelCopyWithImpl(this._self, this._then);

  final PhotoBackModel _self;
  final $Res Function(PhotoBackModel) _then;

/// Create a copy of PhotoBackModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? drawingUrl = freezed,Object? text = freezed,Object? date = freezed,Object? place = freezed,}) {
  return _then(_self.copyWith(
drawingUrl: freezed == drawingUrl ? _self.drawingUrl : drawingUrl // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoBackModel].
extension PhotoBackModelPatterns on PhotoBackModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoBackModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoBackModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoBackModel value)  $default,){
final _that = this;
switch (_that) {
case _PhotoBackModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoBackModel value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoBackModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? drawingUrl,  String? text,  String? date,  String? place)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoBackModel() when $default != null:
return $default(_that.drawingUrl,_that.text,_that.date,_that.place);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? drawingUrl,  String? text,  String? date,  String? place)  $default,) {final _that = this;
switch (_that) {
case _PhotoBackModel():
return $default(_that.drawingUrl,_that.text,_that.date,_that.place);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? drawingUrl,  String? text,  String? date,  String? place)?  $default,) {final _that = this;
switch (_that) {
case _PhotoBackModel() when $default != null:
return $default(_that.drawingUrl,_that.text,_that.date,_that.place);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoBackModel implements PhotoBackModel {
  const _PhotoBackModel({this.drawingUrl, this.text, this.date, this.place});
  factory _PhotoBackModel.fromJson(Map<String, dynamic> json) => _$PhotoBackModelFromJson(json);

@override final  String? drawingUrl;
@override final  String? text;
@override final  String? date;
@override final  String? place;

/// Create a copy of PhotoBackModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoBackModelCopyWith<_PhotoBackModel> get copyWith => __$PhotoBackModelCopyWithImpl<_PhotoBackModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoBackModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoBackModel&&(identical(other.drawingUrl, drawingUrl) || other.drawingUrl == drawingUrl)&&(identical(other.text, text) || other.text == text)&&(identical(other.date, date) || other.date == date)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,drawingUrl,text,date,place);

@override
String toString() {
  return 'PhotoBackModel(drawingUrl: $drawingUrl, text: $text, date: $date, place: $place)';
}


}

/// @nodoc
abstract mixin class _$PhotoBackModelCopyWith<$Res> implements $PhotoBackModelCopyWith<$Res> {
  factory _$PhotoBackModelCopyWith(_PhotoBackModel value, $Res Function(_PhotoBackModel) _then) = __$PhotoBackModelCopyWithImpl;
@override @useResult
$Res call({
 String? drawingUrl, String? text, String? date, String? place
});




}
/// @nodoc
class __$PhotoBackModelCopyWithImpl<$Res>
    implements _$PhotoBackModelCopyWith<$Res> {
  __$PhotoBackModelCopyWithImpl(this._self, this._then);

  final _PhotoBackModel _self;
  final $Res Function(_PhotoBackModel) _then;

/// Create a copy of PhotoBackModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? drawingUrl = freezed,Object? text = freezed,Object? date = freezed,Object? place = freezed,}) {
  return _then(_PhotoBackModel(
drawingUrl: freezed == drawingUrl ? _self.drawingUrl : drawingUrl // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BoardItemCreatorModel {

 String get id; String get name;
/// Create a copy of BoardItemCreatorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardItemCreatorModelCopyWith<BoardItemCreatorModel> get copyWith => _$BoardItemCreatorModelCopyWithImpl<BoardItemCreatorModel>(this as BoardItemCreatorModel, _$identity);

  /// Serializes this BoardItemCreatorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardItemCreatorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'BoardItemCreatorModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $BoardItemCreatorModelCopyWith<$Res>  {
  factory $BoardItemCreatorModelCopyWith(BoardItemCreatorModel value, $Res Function(BoardItemCreatorModel) _then) = _$BoardItemCreatorModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$BoardItemCreatorModelCopyWithImpl<$Res>
    implements $BoardItemCreatorModelCopyWith<$Res> {
  _$BoardItemCreatorModelCopyWithImpl(this._self, this._then);

  final BoardItemCreatorModel _self;
  final $Res Function(BoardItemCreatorModel) _then;

/// Create a copy of BoardItemCreatorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardItemCreatorModel].
extension BoardItemCreatorModelPatterns on BoardItemCreatorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardItemCreatorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardItemCreatorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardItemCreatorModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardItemCreatorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardItemCreatorModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardItemCreatorModel() when $default != null:
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
case _BoardItemCreatorModel() when $default != null:
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
case _BoardItemCreatorModel():
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
case _BoardItemCreatorModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardItemCreatorModel implements BoardItemCreatorModel {
  const _BoardItemCreatorModel({required this.id, required this.name});
  factory _BoardItemCreatorModel.fromJson(Map<String, dynamic> json) => _$BoardItemCreatorModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of BoardItemCreatorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardItemCreatorModelCopyWith<_BoardItemCreatorModel> get copyWith => __$BoardItemCreatorModelCopyWithImpl<_BoardItemCreatorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardItemCreatorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardItemCreatorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'BoardItemCreatorModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$BoardItemCreatorModelCopyWith<$Res> implements $BoardItemCreatorModelCopyWith<$Res> {
  factory _$BoardItemCreatorModelCopyWith(_BoardItemCreatorModel value, $Res Function(_BoardItemCreatorModel) _then) = __$BoardItemCreatorModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$BoardItemCreatorModelCopyWithImpl<$Res>
    implements _$BoardItemCreatorModelCopyWith<$Res> {
  __$BoardItemCreatorModelCopyWithImpl(this._self, this._then);

  final _BoardItemCreatorModel _self;
  final $Res Function(_BoardItemCreatorModel) _then;

/// Create a copy of BoardItemCreatorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_BoardItemCreatorModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
