import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/wishlists/data/models/wishlist_model.dart';

/// Provider for WishlistRepository
final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return WishlistRepository(dioClient: ref.watch(dioClientProvider));
});

/// Repository for wishlist operations
class WishlistRepository {
  final DioClient _dioClient;

  WishlistRepository({required DioClient dioClient}) : _dioClient = dioClient;

  // ==================== CATEGORIES ====================

  /// Get all categories for a household
  Future<List<WishlistCategoryModel>> getCategories(String householdId) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.wishlistCategories,
      queryParameters: {'householdId': householdId},
    );

    final categories = response['data']['categories'] as List<dynamic>? ?? [];
    return categories
        .map((c) => WishlistCategoryModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  /// Create a new category
  Future<WishlistCategoryModel> createCategory({
    required String householdId,
    required String name,
    int? sortOrder,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.wishlistCategories,
      data: {
        'householdId': householdId,
        'name': name,
        if (sortOrder != null) 'sortOrder': sortOrder,
      },
    );

    return WishlistCategoryModel.fromJson(
        response['data']['category'] as Map<String, dynamic>);
  }

  /// Update a category
  Future<WishlistCategoryModel> updateCategory({
    required String id,
    String? name,
    int? sortOrder,
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.wishlistCategory(id),
      data: {
        if (name != null) 'name': name,
        if (sortOrder != null) 'sortOrder': sortOrder,
      },
    );

    return WishlistCategoryModel.fromJson(
        response['data']['category'] as Map<String, dynamic>);
  }

  /// Delete a category
  Future<void> deleteCategory(String id) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.wishlistCategory(id),
    );
  }

  // ==================== ITEMS ====================

  /// Get all items for a household
  Future<List<WishlistItemModel>> getItems(
    String householdId, {
    String? categoryId,
    bool? checked,
    String? ownerType,
  }) async {
    final queryParams = <String, dynamic>{
      'householdId': householdId,
    };
    if (categoryId != null) queryParams['categoryId'] = categoryId;
    if (checked != null) queryParams['checked'] = checked.toString();
    if (ownerType != null) queryParams['ownerType'] = ownerType;

    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.wishlists,
      queryParameters: queryParams,
    );

    final items = response['data']['items'] as List<dynamic>? ?? [];
    return items
        .map((i) => WishlistItemModel.fromJson(i as Map<String, dynamic>))
        .toList();
  }

  /// Create a new item
  Future<WishlistItemModel> createItem({
    required String householdId,
    required String categoryId,
    required String name,
    String ownerType = 'shared',
    String? userId,
    String? url,
    double? price,
    String? preferenceEmoji,
    double? quantity,
    String? unit,
    String? sourceRecipeId,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.wishlists,
      data: {
        'householdId': householdId,
        'categoryId': categoryId,
        'name': name,
        'ownerType': ownerType,
        if (userId != null) 'userId': userId,
        if (url != null) 'url': url,
        if (price != null) 'price': price,
        if (preferenceEmoji != null) 'preferenceEmoji': preferenceEmoji,
        if (quantity != null) 'quantity': quantity,
        if (unit != null) 'unit': unit,
        if (sourceRecipeId != null) 'sourceRecipeId': sourceRecipeId,
      },
    );

    return WishlistItemModel.fromJson(
        response['data']['item'] as Map<String, dynamic>);
  }

  /// Update an item
  Future<WishlistItemModel> updateItem({
    required String id,
    String? name,
    bool? checked,
    double? quantity,
    String? unit,
    double? price,
    String? url,
    String? preferenceEmoji,
    String? categoryId,
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.wishlistItem(id),
      data: {
        if (name != null) 'name': name,
        if (checked != null) 'checked': checked,
        if (quantity != null) 'quantity': quantity,
        if (unit != null) 'unit': unit,
        if (price != null) 'price': price,
        if (url != null) 'url': url,
        if (preferenceEmoji != null) 'preferenceEmoji': preferenceEmoji,
        if (categoryId != null) 'categoryId': categoryId,
      },
    );

    return WishlistItemModel.fromJson(
        response['data']['item'] as Map<String, dynamic>);
  }

  /// Toggle item checked status
  Future<WishlistItemModel> toggleChecked(String id, bool checked) async {
    return updateItem(id: id, checked: checked);
  }

  /// Delete an item
  Future<void> deleteItem(String id) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.wishlistItem(id),
    );
  }

  /// Bulk create items (for shopping list generation)
  Future<List<WishlistItemModel>> createBulkItems({
    required String householdId,
    required String categoryId,
    required List<Map<String, dynamic>> items,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.wishlistBulk,
      data: {
        'householdId': householdId,
        'categoryId': categoryId,
        'items': items,
      },
    );

    final createdItems = response['data']['items'] as List<dynamic>? ?? [];
    return createdItems
        .map((i) => WishlistItemModel.fromJson(i as Map<String, dynamic>))
        .toList();
  }

  /// Clear all checked items
  Future<int> clearChecked(String householdId, {String? categoryId}) async {
    final queryParams = <String, dynamic>{
      'householdId': householdId,
    };
    if (categoryId != null) queryParams['categoryId'] = categoryId;

    final response = await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.wishlistClearChecked,
      queryParameters: queryParams,
    );

    return response?['data']?['deletedCount'] as int? ?? 0;
  }
}
