import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/core/utils/file_utils.dart';
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
  Future<BoardModel> getBoard(String id, {String? tagId}) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.board(id),
      queryParameters: tagId != null ? {'tagId': tagId} : null,
    );

    return BoardModel.fromJson(response['data']['board']);
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

    return BoardModel.fromJson(response['data']['board']);
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

    return BoardModel.fromJson(response['data']['board']);
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

    return BoardItemModel.fromJson(response['data']['item']);
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

    return BoardItemModel.fromJson(response.data!['data']['item']);
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

    return BoardItemModel.fromJson(response['data']['item']);
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

    return BoardItemModel.fromJson(response.data!['data']['item']);
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

  // --- Tags ---

  /// Get all tags for a household
  Future<List<TagModel>> getTags(String householdId) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.boardTags,
      queryParameters: {'householdId': householdId},
    );

    final tags = response['data']['tags'] as List<dynamic>;
    return tags.map((t) => TagModel.fromJson(t as Map<String, dynamic>)).toList();
  }

  /// Create a new tag
  Future<TagModel> createTag(String householdId, String name, String color) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.boardTags,
      data: {
        'householdId': householdId,
        'name': name,
        'color': color,
      },
    );

    return TagModel.fromJson(response['data']['tag']);
  }

  /// Delete a tag
  Future<void> deleteTag(String tagId) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.boardTag(tagId),
    );
  }

  // --- Item Tags ---

  /// Add a tag to a board item
  Future<void> addTagToItem(String boardId, String itemId, String tagId) async {
    await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.boardItemTags(boardId, itemId),
      data: {'tagId': tagId},
    );
  }

  /// Remove a tag from a board item
  Future<void> removeTagFromItem(String boardId, String itemId, String tagId) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.boardItemTag(boardId, itemId, tagId),
    );
  }

  // --- Comments ---

  /// Get comments for a board item
  Future<List<BoardItemCommentModel>> getComments(String boardId, String itemId) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.boardItemComments(boardId, itemId),
    );

    final comments = response['data']['comments'] as List<dynamic>;
    return comments
        .map((c) => BoardItemCommentModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  /// Add a comment to a board item
  Future<BoardItemCommentModel> addComment(
    String boardId,
    String itemId, {
    String? content,
    String? emoji,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.boardItemComments(boardId, itemId),
      data: {
        if (content != null) 'content': content,
        if (emoji != null) 'emoji': emoji,
      },
    );

    return BoardItemCommentModel.fromJson(response['data']['comment']);
  }

  /// Delete a comment from a board item
  Future<void> deleteComment(String boardId, String itemId, String commentId) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.boardItemComment(boardId, itemId, commentId),
    );
  }

  // --- Reorder ---

  /// Reorder items in a board
  Future<void> reorderItems(String boardId, List<Map<String, dynamic>> items) async {
    await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.boardItemReorder(boardId),
      data: {'items': items},
    );
  }

  // --- Templates ---

  /// Get available board templates
  Future<List<BoardTemplateModel>> getTemplates() async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.boardTemplates,
    );

    final templates = response['data']['templates'] as List<dynamic>;
    return templates
        .map((t) => BoardTemplateModel.fromJson(t as Map<String, dynamic>))
        .toList();
  }
}
