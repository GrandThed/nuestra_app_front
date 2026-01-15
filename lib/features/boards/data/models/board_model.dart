import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

@freezed
sealed class BoardModel with _$BoardModel {
  const factory BoardModel({
    required String id,
    required String name,
    String? coverUrl,
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
