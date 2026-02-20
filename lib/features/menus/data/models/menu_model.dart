import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';

part 'menu_model.freezed.dart';
part 'menu_model.g.dart';

/// Model for a menu plan
@freezed
sealed class MenuPlanModel with _$MenuPlanModel {
  const factory MenuPlanModel({
    required String id,
    required String householdId,
    String? name,
    List<MenuItemModel>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MenuPlanModel;

  factory MenuPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MenuPlanModelFromJson(json);
}

/// Model for a menu item (meal)
@freezed
sealed class MenuItemModel with _$MenuItemModel {
  const factory MenuItemModel({
    required String id,
    required DateTime date,
    required String mealType, // 'breakfast' | 'lunch' | 'dinner' | 'snack'
    RecipeModel? recipe,
    String? recipeId,
    Map<String, dynamic>? substitutions,
    @Default(false) bool isLeftover,
    String? originalMenuItemId,
    MenuItemCreatorModel? createdBy,
    DateTime? createdAt,
  }) = _MenuItemModel;

  factory MenuItemModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemModelFromJson(json);
}

/// Model for menu item creator info
@freezed
sealed class MenuItemCreatorModel with _$MenuItemCreatorModel {
  const factory MenuItemCreatorModel({
    required String id,
    required String name,
    String? avatarUrl,
  }) = _MenuItemCreatorModel;

  factory MenuItemCreatorModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemCreatorModelFromJson(json);
}

/// Model for shopping list generation response
@freezed
sealed class ShoppingListResultModel with _$ShoppingListResultModel {
  const factory ShoppingListResultModel({
    required String menuPlanId,
    String? menuName,
    required double servingsMultiplier,
    required int itemsCreated,
    List<ShoppingItemModel>? shoppingList,
  }) = _ShoppingListResultModel;

  factory ShoppingListResultModel.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListResultModelFromJson(json);
}

/// Model for a shopping item
@freezed
sealed class ShoppingItemModel with _$ShoppingItemModel {
  const factory ShoppingItemModel({
    required String name,
    double? quantity,
    String? unit,
    String? sourceRecipeId,
    String? sourceRecipeName,
  }) = _ShoppingItemModel;

  factory ShoppingItemModel.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemModelFromJson(json);
}

/// Model for upcoming meals response
@freezed
sealed class UpcomingMealsModel with _$UpcomingMealsModel {
  const factory UpcomingMealsModel({
    required List<MenuItemModel> items,
    required DateTime from,
    required DateTime to,
  }) = _UpcomingMealsModel;

  factory UpcomingMealsModel.fromJson(Map<String, dynamic> json) =>
      _$UpcomingMealsModelFromJson(json);
}

/// Model for meal history (how often a recipe has been cooked)
@freezed
sealed class MealHistoryModel with _$MealHistoryModel {
  const factory MealHistoryModel({
    required String recipeId,
    required String title,
    String? imageUrl,
    required int timesCooked,
    required DateTime lastCooked,
    required int daysSinceLastCooked,
  }) = _MealHistoryModel;

  factory MealHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$MealHistoryModelFromJson(json);
}

/// Extension for meal type display
extension MealTypeExtension on String {
  String get mealTypeDisplay {
    switch (this) {
      case 'breakfast':
        return 'Desayuno';
      case 'lunch':
        return 'Almuerzo';
      case 'dinner':
        return 'Cena';
      case 'snack':
        return 'Snack';
      default:
        return this;
    }
  }

  String get mealTypeIcon {
    switch (this) {
      case 'breakfast':
        return '🌅';
      case 'lunch':
        return '☀️';
      case 'dinner':
        return '🌙';
      case 'snack':
        return '🍎';
      default:
        return '🍽️';
    }
  }
}
