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
 String? get url; String? get thumbnailUrl; String? get title; String? get description; String? get linkPreviewImage; PhotoBackModel? get photoBack; BoardItemCreatorModel? get createdBy; int get sortOrder; List<BoardItemTagModel> get tags; List<BoardItemCommentModel> get comments; DateTime get createdAt;
/// Create a copy of BoardItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardItemModelCopyWith<BoardItemModel> get copyWith => _$BoardItemModelCopyWithImpl<BoardItemModel>(this as BoardItemModel, _$identity);

  /// Serializes this BoardItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.linkPreviewImage, linkPreviewImage) || other.linkPreviewImage == linkPreviewImage)&&(identical(other.photoBack, photoBack) || other.photoBack == photoBack)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,url,thumbnailUrl,title,description,linkPreviewImage,photoBack,createdBy,sortOrder,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(comments),createdAt);

@override
String toString() {
  return 'BoardItemModel(id: $id, type: $type, url: $url, thumbnailUrl: $thumbnailUrl, title: $title, description: $description, linkPreviewImage: $linkPreviewImage, photoBack: $photoBack, createdBy: $createdBy, sortOrder: $sortOrder, tags: $tags, comments: $comments, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BoardItemModelCopyWith<$Res>  {
  factory $BoardItemModelCopyWith(BoardItemModel value, $Res Function(BoardItemModel) _then) = _$BoardItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String? url, String? thumbnailUrl, String? title, String? description, String? linkPreviewImage, PhotoBackModel? photoBack, BoardItemCreatorModel? createdBy, int sortOrder, List<BoardItemTagModel> tags, List<BoardItemCommentModel> comments, DateTime createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? url = freezed,Object? thumbnailUrl = freezed,Object? title = freezed,Object? description = freezed,Object? linkPreviewImage = freezed,Object? photoBack = freezed,Object? createdBy = freezed,Object? sortOrder = null,Object? tags = null,Object? comments = null,Object? createdAt = null,}) {
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
as BoardItemCreatorModel?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<BoardItemTagModel>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<BoardItemCommentModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String? url,  String? thumbnailUrl,  String? title,  String? description,  String? linkPreviewImage,  PhotoBackModel? photoBack,  BoardItemCreatorModel? createdBy,  int sortOrder,  List<BoardItemTagModel> tags,  List<BoardItemCommentModel> comments,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardItemModel() when $default != null:
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.title,_that.description,_that.linkPreviewImage,_that.photoBack,_that.createdBy,_that.sortOrder,_that.tags,_that.comments,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String? url,  String? thumbnailUrl,  String? title,  String? description,  String? linkPreviewImage,  PhotoBackModel? photoBack,  BoardItemCreatorModel? createdBy,  int sortOrder,  List<BoardItemTagModel> tags,  List<BoardItemCommentModel> comments,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BoardItemModel():
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.title,_that.description,_that.linkPreviewImage,_that.photoBack,_that.createdBy,_that.sortOrder,_that.tags,_that.comments,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String? url,  String? thumbnailUrl,  String? title,  String? description,  String? linkPreviewImage,  PhotoBackModel? photoBack,  BoardItemCreatorModel? createdBy,  int sortOrder,  List<BoardItemTagModel> tags,  List<BoardItemCommentModel> comments,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BoardItemModel() when $default != null:
return $default(_that.id,_that.type,_that.url,_that.thumbnailUrl,_that.title,_that.description,_that.linkPreviewImage,_that.photoBack,_that.createdBy,_that.sortOrder,_that.tags,_that.comments,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardItemModel implements BoardItemModel {
  const _BoardItemModel({required this.id, required this.type, this.url, this.thumbnailUrl, this.title, this.description, this.linkPreviewImage, this.photoBack, this.createdBy, this.sortOrder = 0, final  List<BoardItemTagModel> tags = const [], final  List<BoardItemCommentModel> comments = const [], required this.createdAt}): _tags = tags,_comments = comments;
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
@override@JsonKey() final  int sortOrder;
 final  List<BoardItemTagModel> _tags;
@override@JsonKey() List<BoardItemTagModel> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<BoardItemCommentModel> _comments;
@override@JsonKey() List<BoardItemCommentModel> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.linkPreviewImage, linkPreviewImage) || other.linkPreviewImage == linkPreviewImage)&&(identical(other.photoBack, photoBack) || other.photoBack == photoBack)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,url,thumbnailUrl,title,description,linkPreviewImage,photoBack,createdBy,sortOrder,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_comments),createdAt);

@override
String toString() {
  return 'BoardItemModel(id: $id, type: $type, url: $url, thumbnailUrl: $thumbnailUrl, title: $title, description: $description, linkPreviewImage: $linkPreviewImage, photoBack: $photoBack, createdBy: $createdBy, sortOrder: $sortOrder, tags: $tags, comments: $comments, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BoardItemModelCopyWith<$Res> implements $BoardItemModelCopyWith<$Res> {
  factory _$BoardItemModelCopyWith(_BoardItemModel value, $Res Function(_BoardItemModel) _then) = __$BoardItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String? url, String? thumbnailUrl, String? title, String? description, String? linkPreviewImage, PhotoBackModel? photoBack, BoardItemCreatorModel? createdBy, int sortOrder, List<BoardItemTagModel> tags, List<BoardItemCommentModel> comments, DateTime createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? url = freezed,Object? thumbnailUrl = freezed,Object? title = freezed,Object? description = freezed,Object? linkPreviewImage = freezed,Object? photoBack = freezed,Object? createdBy = freezed,Object? sortOrder = null,Object? tags = null,Object? comments = null,Object? createdAt = null,}) {
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
as BoardItemCreatorModel?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<BoardItemTagModel>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<BoardItemCommentModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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


/// @nodoc
mixin _$BoardItemTagModel {

 String get id; String get tagId; String get name; String get color;
/// Create a copy of BoardItemTagModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardItemTagModelCopyWith<BoardItemTagModel> get copyWith => _$BoardItemTagModelCopyWithImpl<BoardItemTagModel>(this as BoardItemTagModel, _$identity);

  /// Serializes this BoardItemTagModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardItemTagModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tagId, tagId) || other.tagId == tagId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tagId,name,color);

@override
String toString() {
  return 'BoardItemTagModel(id: $id, tagId: $tagId, name: $name, color: $color)';
}


}

/// @nodoc
abstract mixin class $BoardItemTagModelCopyWith<$Res>  {
  factory $BoardItemTagModelCopyWith(BoardItemTagModel value, $Res Function(BoardItemTagModel) _then) = _$BoardItemTagModelCopyWithImpl;
@useResult
$Res call({
 String id, String tagId, String name, String color
});




}
/// @nodoc
class _$BoardItemTagModelCopyWithImpl<$Res>
    implements $BoardItemTagModelCopyWith<$Res> {
  _$BoardItemTagModelCopyWithImpl(this._self, this._then);

  final BoardItemTagModel _self;
  final $Res Function(BoardItemTagModel) _then;

/// Create a copy of BoardItemTagModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tagId = null,Object? name = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tagId: null == tagId ? _self.tagId : tagId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardItemTagModel].
extension BoardItemTagModelPatterns on BoardItemTagModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardItemTagModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardItemTagModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardItemTagModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardItemTagModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardItemTagModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardItemTagModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tagId,  String name,  String color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardItemTagModel() when $default != null:
return $default(_that.id,_that.tagId,_that.name,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tagId,  String name,  String color)  $default,) {final _that = this;
switch (_that) {
case _BoardItemTagModel():
return $default(_that.id,_that.tagId,_that.name,_that.color);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tagId,  String name,  String color)?  $default,) {final _that = this;
switch (_that) {
case _BoardItemTagModel() when $default != null:
return $default(_that.id,_that.tagId,_that.name,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardItemTagModel implements BoardItemTagModel {
  const _BoardItemTagModel({required this.id, required this.tagId, required this.name, required this.color});
  factory _BoardItemTagModel.fromJson(Map<String, dynamic> json) => _$BoardItemTagModelFromJson(json);

@override final  String id;
@override final  String tagId;
@override final  String name;
@override final  String color;

/// Create a copy of BoardItemTagModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardItemTagModelCopyWith<_BoardItemTagModel> get copyWith => __$BoardItemTagModelCopyWithImpl<_BoardItemTagModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardItemTagModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardItemTagModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tagId, tagId) || other.tagId == tagId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tagId,name,color);

@override
String toString() {
  return 'BoardItemTagModel(id: $id, tagId: $tagId, name: $name, color: $color)';
}


}

/// @nodoc
abstract mixin class _$BoardItemTagModelCopyWith<$Res> implements $BoardItemTagModelCopyWith<$Res> {
  factory _$BoardItemTagModelCopyWith(_BoardItemTagModel value, $Res Function(_BoardItemTagModel) _then) = __$BoardItemTagModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tagId, String name, String color
});




}
/// @nodoc
class __$BoardItemTagModelCopyWithImpl<$Res>
    implements _$BoardItemTagModelCopyWith<$Res> {
  __$BoardItemTagModelCopyWithImpl(this._self, this._then);

  final _BoardItemTagModel _self;
  final $Res Function(_BoardItemTagModel) _then;

/// Create a copy of BoardItemTagModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tagId = null,Object? name = null,Object? color = null,}) {
  return _then(_BoardItemTagModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tagId: null == tagId ? _self.tagId : tagId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BoardItemCommentModel {

 String get id; String get userId; BoardItemCreatorModel get user; String? get content; String? get emoji; DateTime get createdAt;
/// Create a copy of BoardItemCommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardItemCommentModelCopyWith<BoardItemCommentModel> get copyWith => _$BoardItemCommentModelCopyWithImpl<BoardItemCommentModel>(this as BoardItemCommentModel, _$identity);

  /// Serializes this BoardItemCommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardItemCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.content, content) || other.content == content)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,user,content,emoji,createdAt);

@override
String toString() {
  return 'BoardItemCommentModel(id: $id, userId: $userId, user: $user, content: $content, emoji: $emoji, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BoardItemCommentModelCopyWith<$Res>  {
  factory $BoardItemCommentModelCopyWith(BoardItemCommentModel value, $Res Function(BoardItemCommentModel) _then) = _$BoardItemCommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, BoardItemCreatorModel user, String? content, String? emoji, DateTime createdAt
});


$BoardItemCreatorModelCopyWith<$Res> get user;

}
/// @nodoc
class _$BoardItemCommentModelCopyWithImpl<$Res>
    implements $BoardItemCommentModelCopyWith<$Res> {
  _$BoardItemCommentModelCopyWithImpl(this._self, this._then);

  final BoardItemCommentModel _self;
  final $Res Function(BoardItemCommentModel) _then;

/// Create a copy of BoardItemCommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? user = null,Object? content = freezed,Object? emoji = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as BoardItemCreatorModel,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of BoardItemCommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardItemCreatorModelCopyWith<$Res> get user {
  
  return $BoardItemCreatorModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [BoardItemCommentModel].
extension BoardItemCommentModelPatterns on BoardItemCommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardItemCommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardItemCommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardItemCommentModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardItemCommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardItemCommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardItemCommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  BoardItemCreatorModel user,  String? content,  String? emoji,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardItemCommentModel() when $default != null:
return $default(_that.id,_that.userId,_that.user,_that.content,_that.emoji,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  BoardItemCreatorModel user,  String? content,  String? emoji,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BoardItemCommentModel():
return $default(_that.id,_that.userId,_that.user,_that.content,_that.emoji,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  BoardItemCreatorModel user,  String? content,  String? emoji,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BoardItemCommentModel() when $default != null:
return $default(_that.id,_that.userId,_that.user,_that.content,_that.emoji,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardItemCommentModel implements BoardItemCommentModel {
  const _BoardItemCommentModel({required this.id, required this.userId, required this.user, this.content, this.emoji, required this.createdAt});
  factory _BoardItemCommentModel.fromJson(Map<String, dynamic> json) => _$BoardItemCommentModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  BoardItemCreatorModel user;
@override final  String? content;
@override final  String? emoji;
@override final  DateTime createdAt;

/// Create a copy of BoardItemCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardItemCommentModelCopyWith<_BoardItemCommentModel> get copyWith => __$BoardItemCommentModelCopyWithImpl<_BoardItemCommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardItemCommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardItemCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.user, user) || other.user == user)&&(identical(other.content, content) || other.content == content)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,user,content,emoji,createdAt);

@override
String toString() {
  return 'BoardItemCommentModel(id: $id, userId: $userId, user: $user, content: $content, emoji: $emoji, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BoardItemCommentModelCopyWith<$Res> implements $BoardItemCommentModelCopyWith<$Res> {
  factory _$BoardItemCommentModelCopyWith(_BoardItemCommentModel value, $Res Function(_BoardItemCommentModel) _then) = __$BoardItemCommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, BoardItemCreatorModel user, String? content, String? emoji, DateTime createdAt
});


@override $BoardItemCreatorModelCopyWith<$Res> get user;

}
/// @nodoc
class __$BoardItemCommentModelCopyWithImpl<$Res>
    implements _$BoardItemCommentModelCopyWith<$Res> {
  __$BoardItemCommentModelCopyWithImpl(this._self, this._then);

  final _BoardItemCommentModel _self;
  final $Res Function(_BoardItemCommentModel) _then;

/// Create a copy of BoardItemCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? user = null,Object? content = freezed,Object? emoji = freezed,Object? createdAt = null,}) {
  return _then(_BoardItemCommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as BoardItemCreatorModel,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of BoardItemCommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardItemCreatorModelCopyWith<$Res> get user {
  
  return $BoardItemCreatorModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$TagModel {

 String get id; String get name; String get color; DateTime get createdAt;
/// Create a copy of TagModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagModelCopyWith<TagModel> get copyWith => _$TagModelCopyWithImpl<TagModel>(this as TagModel, _$identity);

  /// Serializes this TagModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,createdAt);

@override
String toString() {
  return 'TagModel(id: $id, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TagModelCopyWith<$Res>  {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) _then) = _$TagModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String color, DateTime createdAt
});




}
/// @nodoc
class _$TagModelCopyWithImpl<$Res>
    implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._self, this._then);

  final TagModel _self;
  final $Res Function(TagModel) _then;

/// Create a copy of TagModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TagModel].
extension TagModelPatterns on TagModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagModel value)  $default,){
final _that = this;
switch (_that) {
case _TagModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagModel value)?  $default,){
final _that = this;
switch (_that) {
case _TagModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String color,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagModel() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String color,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TagModel():
return $default(_that.id,_that.name,_that.color,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String color,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TagModel() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TagModel implements TagModel {
  const _TagModel({required this.id, required this.name, this.color = '#667eea', required this.createdAt});
  factory _TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String color;
@override final  DateTime createdAt;

/// Create a copy of TagModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagModelCopyWith<_TagModel> get copyWith => __$TagModelCopyWithImpl<_TagModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,createdAt);

@override
String toString() {
  return 'TagModel(id: $id, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TagModelCopyWith<$Res> implements $TagModelCopyWith<$Res> {
  factory _$TagModelCopyWith(_TagModel value, $Res Function(_TagModel) _then) = __$TagModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String color, DateTime createdAt
});




}
/// @nodoc
class __$TagModelCopyWithImpl<$Res>
    implements _$TagModelCopyWith<$Res> {
  __$TagModelCopyWithImpl(this._self, this._then);

  final _TagModel _self;
  final $Res Function(_TagModel) _then;

/// Create a copy of TagModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = null,Object? createdAt = null,}) {
  return _then(_TagModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$BoardTemplateModel {

 String get id; String get name; String get description; List<Map<String, dynamic>> get presetItems;
/// Create a copy of BoardTemplateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardTemplateModelCopyWith<BoardTemplateModel> get copyWith => _$BoardTemplateModelCopyWithImpl<BoardTemplateModel>(this as BoardTemplateModel, _$identity);

  /// Serializes this BoardTemplateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardTemplateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.presetItems, presetItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(presetItems));

@override
String toString() {
  return 'BoardTemplateModel(id: $id, name: $name, description: $description, presetItems: $presetItems)';
}


}

/// @nodoc
abstract mixin class $BoardTemplateModelCopyWith<$Res>  {
  factory $BoardTemplateModelCopyWith(BoardTemplateModel value, $Res Function(BoardTemplateModel) _then) = _$BoardTemplateModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, List<Map<String, dynamic>> presetItems
});




}
/// @nodoc
class _$BoardTemplateModelCopyWithImpl<$Res>
    implements $BoardTemplateModelCopyWith<$Res> {
  _$BoardTemplateModelCopyWithImpl(this._self, this._then);

  final BoardTemplateModel _self;
  final $Res Function(BoardTemplateModel) _then;

/// Create a copy of BoardTemplateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? presetItems = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,presetItems: null == presetItems ? _self.presetItems : presetItems // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardTemplateModel].
extension BoardTemplateModelPatterns on BoardTemplateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardTemplateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardTemplateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardTemplateModel value)  $default,){
final _that = this;
switch (_that) {
case _BoardTemplateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardTemplateModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoardTemplateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  List<Map<String, dynamic>> presetItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardTemplateModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.presetItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  List<Map<String, dynamic>> presetItems)  $default,) {final _that = this;
switch (_that) {
case _BoardTemplateModel():
return $default(_that.id,_that.name,_that.description,_that.presetItems);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  List<Map<String, dynamic>> presetItems)?  $default,) {final _that = this;
switch (_that) {
case _BoardTemplateModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.presetItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoardTemplateModel implements BoardTemplateModel {
  const _BoardTemplateModel({required this.id, required this.name, required this.description, required final  List<Map<String, dynamic>> presetItems}): _presetItems = presetItems;
  factory _BoardTemplateModel.fromJson(Map<String, dynamic> json) => _$BoardTemplateModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
 final  List<Map<String, dynamic>> _presetItems;
@override List<Map<String, dynamic>> get presetItems {
  if (_presetItems is EqualUnmodifiableListView) return _presetItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_presetItems);
}


/// Create a copy of BoardTemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardTemplateModelCopyWith<_BoardTemplateModel> get copyWith => __$BoardTemplateModelCopyWithImpl<_BoardTemplateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoardTemplateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardTemplateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._presetItems, _presetItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_presetItems));

@override
String toString() {
  return 'BoardTemplateModel(id: $id, name: $name, description: $description, presetItems: $presetItems)';
}


}

/// @nodoc
abstract mixin class _$BoardTemplateModelCopyWith<$Res> implements $BoardTemplateModelCopyWith<$Res> {
  factory _$BoardTemplateModelCopyWith(_BoardTemplateModel value, $Res Function(_BoardTemplateModel) _then) = __$BoardTemplateModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, List<Map<String, dynamic>> presetItems
});




}
/// @nodoc
class __$BoardTemplateModelCopyWithImpl<$Res>
    implements _$BoardTemplateModelCopyWith<$Res> {
  __$BoardTemplateModelCopyWithImpl(this._self, this._then);

  final _BoardTemplateModel _self;
  final $Res Function(_BoardTemplateModel) _then;

/// Create a copy of BoardTemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? presetItems = null,}) {
  return _then(_BoardTemplateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,presetItems: null == presetItems ? _self._presetItems : presetItems // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
