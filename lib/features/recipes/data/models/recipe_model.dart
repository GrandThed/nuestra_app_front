import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

/// Model for a recipe
@freezed
sealed class RecipeModel with _$RecipeModel {
  const factory RecipeModel({
    required String id,
    String? householdId,
    required String title,
    List<IngredientModel>? ingredients,
    List<String>? instructions,
    String? imageUrl,
    int? servings,
    String? sourceUrl,
    RecipeCreatorModel? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
}

/// Model for an ingredient with optional alternatives
@freezed
sealed class IngredientModel with _$IngredientModel {
  const factory IngredientModel({
    required String name,
    double? quantity,
    String? unit,
    List<IngredientModel>? alternatives,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);
}

/// Model for recipe creator info
@freezed
sealed class RecipeCreatorModel with _$RecipeCreatorModel {
  const factory RecipeCreatorModel({
    required String id,
    required String name,
    String? avatarUrl,
  }) = _RecipeCreatorModel;

  factory RecipeCreatorModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeCreatorModelFromJson(json);
}

/// Model for seasonal vegetables
@freezed
sealed class SeasonalVegetableModel with _$SeasonalVegetableModel {
  const factory SeasonalVegetableModel({
    required String id,
    required String name,
    required int startWeek,
    required int endWeek,
    @Default(false) bool inSeason,
  }) = _SeasonalVegetableModel;

  factory SeasonalVegetableModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonalVegetableModelFromJson(json);
}
