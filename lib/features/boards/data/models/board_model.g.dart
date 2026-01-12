// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => _BoardModel(
  id: json['id'] as String,
  name: json['name'] as String,
  coverUrl: json['coverUrl'] as String?,
  itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => BoardItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$BoardModelToJson(_BoardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverUrl': instance.coverUrl,
      'itemCount': instance.itemCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'items': instance.items,
    };

_BoardItemModel _$BoardItemModelFromJson(Map<String, dynamic> json) =>
    _BoardItemModel(
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
              : PhotoBackModel.fromJson(
                json['photoBack'] as Map<String, dynamic>,
              ),
      createdBy:
          json['createdBy'] == null
              ? null
              : BoardItemCreatorModel.fromJson(
                json['createdBy'] as Map<String, dynamic>,
              ),
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
