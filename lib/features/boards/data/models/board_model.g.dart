// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => _BoardModel(
  id: json['id'] as String,
  name: json['name'] as String,
  coverUrl: json['coverUrl'] as String?,
  compositeThumbnailUrl: json['compositeThumbnailUrl'] as String?,
  itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => BoardItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  previewItems:
      (json['previewItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$BoardModelToJson(_BoardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverUrl': instance.coverUrl,
      'compositeThumbnailUrl': instance.compositeThumbnailUrl,
      'itemCount': instance.itemCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'items': instance.items,
      'previewItems': instance.previewItems,
    };

_BoardItemModel _$BoardItemModelFromJson(
  Map<String, dynamic> json,
) => _BoardItemModel(
  id: json['id'] as String,
  type: json['type'] as String,
  url: json['url'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  linkPreviewImage: json['linkPreviewImage'] as String?,
  photoBack:
      json['photoBack'] == null
          ? null
          : PhotoBackModel.fromJson(json['photoBack'] as Map<String, dynamic>),
  createdBy:
      json['createdBy'] == null
          ? null
          : BoardItemCreatorModel.fromJson(
            json['createdBy'] as Map<String, dynamic>,
          ),
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => BoardItemTagModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map(
            (e) => BoardItemCommentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BoardItemModelToJson(_BoardItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'title': instance.title,
      'description': instance.description,
      'linkPreviewImage': instance.linkPreviewImage,
      'photoBack': instance.photoBack,
      'createdBy': instance.createdBy,
      'sortOrder': instance.sortOrder,
      'tags': instance.tags,
      'comments': instance.comments,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_PhotoBackModel _$PhotoBackModelFromJson(Map<String, dynamic> json) =>
    _PhotoBackModel(
      drawingUrl: json['drawingUrl'] as String?,
      text: json['text'] as String?,
      date: json['date'] as String?,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$PhotoBackModelToJson(_PhotoBackModel instance) =>
    <String, dynamic>{
      'drawingUrl': instance.drawingUrl,
      'text': instance.text,
      'date': instance.date,
      'place': instance.place,
    };

_BoardItemCreatorModel _$BoardItemCreatorModelFromJson(
  Map<String, dynamic> json,
) => _BoardItemCreatorModel(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$BoardItemCreatorModelToJson(
  _BoardItemCreatorModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_BoardItemTagModel _$BoardItemTagModelFromJson(Map<String, dynamic> json) =>
    _BoardItemTagModel(
      id: json['id'] as String,
      tagId: json['tagId'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$BoardItemTagModelToJson(_BoardItemTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagId': instance.tagId,
      'name': instance.name,
      'color': instance.color,
    };

_BoardItemCommentModel _$BoardItemCommentModelFromJson(
  Map<String, dynamic> json,
) => _BoardItemCommentModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  user: BoardItemCreatorModel.fromJson(json['user'] as Map<String, dynamic>),
  content: json['content'] as String?,
  emoji: json['emoji'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BoardItemCommentModelToJson(
  _BoardItemCommentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'user': instance.user,
  'content': instance.content,
  'emoji': instance.emoji,
  'createdAt': instance.createdAt.toIso8601String(),
};

_TagModel _$TagModelFromJson(Map<String, dynamic> json) => _TagModel(
  id: json['id'] as String,
  name: json['name'] as String,
  color: json['color'] as String? ?? '#667eea',
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TagModelToJson(_TagModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'createdAt': instance.createdAt.toIso8601String(),
};

_BoardTemplateModel _$BoardTemplateModelFromJson(Map<String, dynamic> json) =>
    _BoardTemplateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      presetItems:
          (json['presetItems'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
    );

Map<String, dynamic> _$BoardTemplateModelToJson(_BoardTemplateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'presetItems': instance.presetItems,
    };
