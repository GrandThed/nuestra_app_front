import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';

part 'menu_repository.g.dart';

@riverpod
MenuRepository menuRepository(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MenuRepository(dioClient);
}

class MenuRepository {
  final DioClient _dioClient;

  MenuRepository(this._dioClient);

  /// Get all menu plans for a household
  Future<List<MenuPlanModel>> getMenuPlans(String householdId) async {
    final response = await _dioClient.get(
      ApiConstants.menus,
      queryParameters: {'householdId': householdId},
    );
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => MenuPlanModel.fromJson(json)).toList();
  }

  /// Get upcoming meals for a date range
  Future<List<MenuItemModel>> getUpcomingMeals(
    String householdId, {
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _dioClient.get(
      ApiConstants.menusUpcoming,
      queryParameters: {
        'householdId': householdId,
        'from': from.toIso8601String().split('T')[0],
        'to': to.toIso8601String().split('T')[0],
      },
    );
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => MenuItemModel.fromJson(json)).toList();
  }

  /// Create a new menu plan
  Future<MenuPlanModel> createMenuPlan({
    required String householdId,
    String? name,
  }) async {
    final response = await _dioClient.post(
      ApiConstants.menus,
      data: {
        'householdId': householdId,
        if (name != null) 'name': name,
      },
    );
    return MenuPlanModel.fromJson(response.data['data']);
  }

  /// Get a single menu plan with items
  Future<MenuPlanModel> getMenuPlan(String id) async {
    final response = await _dioClient.get(ApiConstants.menu(id));
    return MenuPlanModel.fromJson(response.data['data']);
  }

  /// Delete a menu plan
  Future<void> deleteMenuPlan(String id) async {
    await _dioClient.delete(ApiConstants.menu(id));
  }

  /// Add a menu item (meal) to a plan
  Future<MenuItemModel> addMenuItem({
    required String menuId,
    required String recipeId,
    required DateTime date,
    required String mealType,
    Map<String, dynamic>? substitutions,
  }) async {
    final response = await _dioClient.post(
      ApiConstants.menuItems(menuId),
      data: {
        'recipeId': recipeId,
        'date': date.toIso8601String().split('T')[0],
        'mealType': mealType,
        if (substitutions != null) 'substitutions': substitutions,
      },
    );
    return MenuItemModel.fromJson(response.data['data']);
  }

  /// Update a menu item
  Future<MenuItemModel> updateMenuItem({
    required String menuId,
    required String itemId,
    DateTime? date,
    String? mealType,
    String? recipeId,
    Map<String, dynamic>? substitutions,
  }) async {
    final response = await _dioClient.patch(
      ApiConstants.menuItem(menuId, itemId),
      data: {
        if (date != null) 'date': date.toIso8601String().split('T')[0],
        if (mealType != null) 'mealType': mealType,
        if (recipeId != null) 'recipeId': recipeId,
        if (substitutions != null) 'substitutions': substitutions,
      },
    );
    return MenuItemModel.fromJson(response.data['data']);
  }

  /// Delete a menu item
  Future<void> deleteMenuItem({
    required String menuId,
    required String itemId,
  }) async {
    await _dioClient.delete(ApiConstants.menuItem(menuId, itemId));
  }

  /// Generate shopping list from menu plan
  Future<ShoppingListResultModel> generateShoppingList({
    required String menuId,
    double servingsMultiplier = 1.0,
  }) async {
    final response = await _dioClient.post(
      ApiConstants.menuGenerateShopping(menuId),
      data: {
        'servingsMultiplier': servingsMultiplier,
      },
    );
    return ShoppingListResultModel.fromJson(response.data['data']);
  }
}
