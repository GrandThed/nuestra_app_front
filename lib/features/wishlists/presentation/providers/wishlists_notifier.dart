import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/wishlists/data/models/wishlist_model.dart';
import 'package:nuestra_app/features/wishlists/data/repositories/wishlist_repository.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_state.dart';

part 'wishlists_notifier.g.dart';

/// Notifier for wishlists operations (categories + items combined)
@Riverpod(keepAlive: true)
class WishlistsNotifier extends _$WishlistsNotifier {
  late final WishlistRepository _repository;

  @override
  WishlistsState build() {
    _repository = ref.watch(wishlistRepositoryProvider);
    return const WishlistsState.initial();
  }

  /// Load wishlists only if not already loaded (for screen init)
  Future<void> loadWishlistsIfNeeded() async {
    if (state is WishlistsStateInitial || state is WishlistsStateError) {
      await loadWishlists();
    }
  }

  /// Load all categories and items for current household
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadWishlists({bool forceLoading = false}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const WishlistsState.error('No hay hogar seleccionado');
      return;
    }

    final hasData = state is WishlistsStateLoaded;
    if (!hasData || forceLoading) {
      state = const WishlistsState.loading();
    }

    try {
      final results = await Future.wait([
        _repository.getCategories(householdId),
        _repository.getItems(householdId),
      ]);

      final categories = results[0] as List<WishlistCategoryModel>;
      final items = results[1] as List<WishlistItemModel>;

      state = WishlistsState.loaded(
        categories: categories,
        items: items,
      );
    } on AppException catch (e) {
      if (!hasData) {
        state = WishlistsState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = WishlistsState.error('Error al cargar listas: $e');
      }
    }
  }

  // ==================== CATEGORY OPERATIONS ====================

  /// Create a new category
  Future<WishlistCategoryModel?> createCategory({
    required String name,
    int? sortOrder,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final category = await _repository.createCategory(
        householdId: householdId,
        name: name,
        sortOrder: sortOrder,
      );

      // Add to current list
      final currentState = state;
      if (currentState is WishlistsStateLoaded) {
        state = WishlistsState.loaded(
          categories: [...currentState.categories, category],
          items: currentState.items,
        );
      }

      return category;
    } on AppException catch (e) {
      debugPrint('Error creating category: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating category: $e');
      return null;
    }
  }

  /// Update a category
  Future<WishlistCategoryModel?> updateCategory({
    required String id,
    String? name,
    int? sortOrder,
  }) async {
    try {
      final category = await _repository.updateCategory(
        id: id,
        name: name,
        sortOrder: sortOrder,
      );

      // Update in current list
      final currentState = state;
      if (currentState is WishlistsStateLoaded) {
        final updatedCategories = currentState.categories.map((c) {
          return c.id == id ? category : c;
        }).toList();
        state = WishlistsState.loaded(
          categories: updatedCategories,
          items: currentState.items,
        );
      }

      return category;
    } on AppException catch (e) {
      debugPrint('Error updating category: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating category: $e');
      return null;
    }
  }

  /// Delete a category
  Future<bool> deleteCategory(String id) async {
    try {
      await _repository.deleteCategory(id);

      // Remove from current list and remove items in that category
      final currentState = state;
      if (currentState is WishlistsStateLoaded) {
        final updatedCategories =
            currentState.categories.where((c) => c.id != id).toList();
        final updatedItems =
            currentState.items.where((i) => i.category?.id != id).toList();
        state = WishlistsState.loaded(
          categories: updatedCategories,
          items: updatedItems,
        );
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting category: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting category: $e');
      return false;
    }
  }

  // ==================== ITEM OPERATIONS ====================

  /// Create a new item
  Future<WishlistItemModel?> createItem({
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
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final item = await _repository.createItem(
        householdId: householdId,
        categoryId: categoryId,
        name: name,
        ownerType: ownerType,
        userId: userId,
        url: url,
        price: price,
        preferenceEmoji: preferenceEmoji,
        quantity: quantity,
        unit: unit,
        sourceRecipeId: sourceRecipeId,
      );

      // Add to current list
      final currentState = state;
      if (currentState is WishlistsStateLoaded) {
        state = WishlistsState.loaded(
          categories: currentState.categories,
          items: [...currentState.items, item],
        );
      }

      return item;
    } on AppException catch (e) {
      debugPrint('Error creating item: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating item: $e');
      return null;
    }
  }

  /// Update an item
  Future<WishlistItemModel?> updateItem({
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
    try {
      final item = await _repository.updateItem(
        id: id,
        name: name,
        checked: checked,
        quantity: quantity,
        unit: unit,
        price: price,
        url: url,
        preferenceEmoji: preferenceEmoji,
        categoryId: categoryId,
      );

      // Update in current list
      final currentState = state;
      if (currentState is WishlistsStateLoaded) {
        final updatedItems = currentState.items.map((i) {
          return i.id == id ? item : i;
        }).toList();
        state = WishlistsState.loaded(
          categories: currentState.categories,
          items: updatedItems,
        );
      }

      return item;
    } on AppException catch (e) {
      debugPrint('Error updating item: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating item: $e');
      return null;
    }
  }

  /// Toggle item checked status
  Future<WishlistItemModel?> toggleItemChecked(String id, bool checked) async {
    return updateItem(id: id, checked: checked);
  }

  /// Delete an item
  Future<bool> deleteItem(String id) async {
    try {
      await _repository.deleteItem(id);

      // Remove from current list
      final currentState = state;
      if (currentState is WishlistsStateLoaded) {
        final updatedItems =
            currentState.items.where((i) => i.id != id).toList();
        state = WishlistsState.loaded(
          categories: currentState.categories,
          items: updatedItems,
        );
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting item: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting item: $e');
      return false;
    }
  }

  /// Clear all checked items
  Future<int> clearCheckedItems({String? categoryId}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return 0;

    try {
      final deletedCount = await _repository.clearChecked(
        householdId,
        categoryId: categoryId,
      );

      // Remove checked items from current list
      final currentState = state;
      if (currentState is WishlistsStateLoaded) {
        final updatedItems = currentState.items.where((i) {
          if (categoryId != null) {
            return !(i.checked && i.category?.id == categoryId);
          }
          return !i.checked;
        }).toList();
        state = WishlistsState.loaded(
          categories: currentState.categories,
          items: updatedItems,
        );
      }

      return deletedCount;
    } on AppException catch (e) {
      debugPrint('Error clearing checked items: ${e.message}');
      return 0;
    } catch (e) {
      debugPrint('Error clearing checked items: $e');
      return 0;
    }
  }
}

/// Provider for unchecked items count (for home dashboard)
@riverpod
int uncheckedWishlistItemsCount(Ref ref) {
  final state = ref.watch(wishlistsNotifierProvider);
  if (state is WishlistsStateLoaded) {
    return state.items.where((i) => !i.checked).length;
  }
  return 0;
}

/// Provider for items filtered by category
@riverpod
List<WishlistItemModel> wishlistItemsByCategory(
  Ref ref,
  String? categoryId,
) {
  final state = ref.watch(wishlistsNotifierProvider);
  if (state is WishlistsStateLoaded) {
    if (categoryId == null) {
      return state.items;
    }
    return state.items.where((i) => i.category?.id == categoryId).toList();
  }
  return [];
}

/// Provider for checked items count in a category
@riverpod
int checkedItemsCount(Ref ref, String? categoryId) {
  final items = ref.watch(wishlistItemsByCategoryProvider(categoryId));
  return items.where((i) => i.checked).length;
}

/// Provider for unchecked items count in a category
@riverpod
int uncheckedItemsCount(Ref ref, String? categoryId) {
  final items = ref.watch(wishlistItemsByCategoryProvider(categoryId));
  return items.where((i) => !i.checked).length;
}
