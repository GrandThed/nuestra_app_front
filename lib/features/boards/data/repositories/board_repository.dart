import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/boards/data/models/board_model.dart';

/// Provider for board repository
final boardRepositoryProvider = Provider<BoardRepository>((ref) {
  return BoardRepository(
    dioClient: ref.watch(dioClientProvider),
  );
});

/// Repository for board operations
class BoardRepository {
  final DioClient _dioClient;

  BoardRepository({required DioClient dioClient}) : _dioClient = dioClient;

  /// Get all boards for a household
  Future<List<BoardModel>> getBoards(String householdId) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.boards,
      queryParameters: {'householdId': householdId},
    );

    final boards = response['data']['boards'] as List<dynamic>;
    return boards
        .map((b) => BoardModel.fromJson(b as Map<String, dynamic>))
        .toList();
  }

  /// Get a board by ID with all items
  Future<BoardModel> getBoard(String id) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.board(id),
    );

    return BoardModel.fromJson(response['data']);
  }

  /// Create a new board
  Future<BoardModel> createBoard({
    required String householdId,
    required String name,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.boards,
      data: {
        'householdId': householdId,
        'name': name,
      },
    );

    return BoardModel.fromJson(response['data']);
  }

  /// Update a board
  Future<BoardModel> updateBoard({
    required String id,
    String? name,
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.board(id),
      data: {
        if (name != null) 'name': name,
      },
    );

    return BoardModel.fromJson(response['data']);
  }

  /// Delete a board
  Future<void> deleteBoard(String id) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.board(id),
    );
  }

  /// Add a link item to a board
  Future<BoardItemModel> addLinkItem({
    required String boardId,
    required String url,
    String? title,
    String? description,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.boardItemLink(boardId),
      data: {
        'url': url,
        if (title != null) 'title': title,
        if (description != null) 'description': description,
      },
    );

    return BoardItemModel.fromJson(response['data']);
  }

  /// Add a photo item to a board
  Future<BoardItemModel> addPhotoItem({
    required String boardId,
    required File photo,
    String? title,
    String? description,
  }) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        photo.path,
        filename: photo.path.split('/').last,
      ),
      if (title != null) 'title': title,
      if (description != null) 'description': description,
    });

    final response = await _dioClient.dio.post<Map<String, dynamic>>(
      ApiConstants.boardItemPhoto(boardId),
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return BoardItemModel.fromJson(response.data!['data']);
  }

  /// Update a board item
  Future<BoardItemModel> updateItem({
    required String boardId,
    required String itemId,
    String? title,
    String? description,
    PhotoBackModel? photoBack,
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.boardItem(boardId, itemId),
      data: {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (photoBack != null)
          'photoBack': {
            if (photoBack.text != null) 'text': photoBack.text,
            if (photoBack.date != null) 'date': photoBack.date,
            if (photoBack.place != null) 'place': photoBack.place,
          },
      },
    );

    return BoardItemModel.fromJson(response['data']);
  }

  /// Update a photo item's back drawing
  Future<BoardItemModel> updateItemDrawing({
    required String boardId,
    required String itemId,
    required File drawing,
  }) async {
    final formData = FormData.fromMap({
      'drawing': await MultipartFile.fromFile(
        drawing.path,
        filename: drawing.path.split('/').last,
      ),
    });

    final response = await _dioClient.dio.patch<Map<String, dynamic>>(
      ApiConstants.boardItem(boardId, itemId),
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return BoardItemModel.fromJson(response.data!['data']);
  }

  /// Delete a board item
  Future<void> deleteItem({
    required String boardId,
    required String itemId,
  }) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.boardItem(boardId, itemId),
    );
  }
}
