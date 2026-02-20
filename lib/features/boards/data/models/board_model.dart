import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

@freezed
sealed class BoardModel with _$BoardModel {
  const factory BoardModel({
    required String id,
    required String name,
    String? coverUrl,
    String? compositeThumbnailUrl,
    @Default(0) int itemCount,
    required DateTime createdAt,
    List<BoardItemModel>? items,
    @Default([]) List<String> previewItems,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);
}

@freezed
sealed class BoardItemModel with _$BoardItemModel {
  const factory BoardItemModel({
    required String id,
    required String type, // 'link' or 'photo'
    String? url,
    String? thumbnailUrl,
    String? title,
    String? description,
    String? linkPreviewImage,
    PhotoBackModel? photoBack,
    BoardItemCreatorModel? createdBy,
    @Default(0) int sortOrder,
    @Default([]) List<BoardItemTagModel> tags,
    @Default([]) List<BoardItemCommentModel> comments,
    required DateTime createdAt,
  }) = _BoardItemModel;

  factory BoardItemModel.fromJson(Map<String, dynamic> json) =>
      _$BoardItemModelFromJson(json);
}

@freezed
sealed class PhotoBackModel with _$PhotoBackModel {
  const factory PhotoBackModel({
    String? drawingUrl,
    String? text,
    String? date,
    String? place,
  }) = _PhotoBackModel;

  factory PhotoBackModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoBackModelFromJson(json);
}

@freezed
sealed class BoardItemCreatorModel with _$BoardItemCreatorModel {
  const factory BoardItemCreatorModel({
    required String id,
    required String name,
  }) = _BoardItemCreatorModel;

  factory BoardItemCreatorModel.fromJson(Map<String, dynamic> json) =>
      _$BoardItemCreatorModelFromJson(json);
}

@freezed
sealed class BoardItemTagModel with _$BoardItemTagModel {
  const factory BoardItemTagModel({
    required String id,
    required String tagId,
    required String name,
    required String color,
  }) = _BoardItemTagModel;

  factory BoardItemTagModel.fromJson(Map<String, dynamic> json) =>
      _$BoardItemTagModelFromJson(json);
}

@freezed
sealed class BoardItemCommentModel with _$BoardItemCommentModel {
  const factory BoardItemCommentModel({
    required String id,
    required String userId,
    required BoardItemCreatorModel user,
    String? content,
    String? emoji,
    required DateTime createdAt,
  }) = _BoardItemCommentModel;

  factory BoardItemCommentModel.fromJson(Map<String, dynamic> json) =>
      _$BoardItemCommentModelFromJson(json);
}

@freezed
sealed class TagModel with _$TagModel {
  const factory TagModel({
    required String id,
    required String name,
    @Default('#667eea') String color,
    required DateTime createdAt,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}

@freezed
sealed class BoardTemplateModel with _$BoardTemplateModel {
  const factory BoardTemplateModel({
    required String id,
    required String name,
    required String description,
    required List<Map<String, dynamic>> presetItems,
  }) = _BoardTemplateModel;

  factory BoardTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$BoardTemplateModelFromJson(json);
}
