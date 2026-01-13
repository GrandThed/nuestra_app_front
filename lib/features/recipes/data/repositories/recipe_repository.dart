import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';

/// Provider for RecipeRepository
final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepository(dioClient: ref.watch(dioClientProvider));
});

/// Repository for recipe operations
class RecipeRepository {
  final DioClient _dioClient;

  RecipeRepository({required DioClient dioClient}) : _dioClient = dioClient;

  /// Get all recipes for a household
  /// Supports optional search and season filter
  Future<List<RecipeModel>> getRecipes(
    String householdId, {
    String? search,
    String? season,
  }) async {
    final queryParams = <String, dynamic>{
      'householdId': householdId,
    };
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    if (season != null && season.isNotEmpty) {
      queryParams['season'] = season;
    }

    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.recipes,
      queryParameters: queryParams,
    );

    final recipes = response['data']['recipes'] as List<dynamic>? ?? [];
    return recipes
        .map((r) => RecipeModel.fromJson(r as Map<String, dynamic>))
        .toList();
  }

  /// Get a single recipe by ID
  Future<RecipeModel> getRecipe(String id) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.recipe(id),
    );

    return RecipeModel.fromJson(response['data']['recipe']);
  }

  /// Create a new recipe
  Future<RecipeModel> createRecipe({
    required String householdId,
    required String title,
    List<IngredientModel>? ingredients,
    List<String>? instructions,
    int? servings,
    String? sourceUrl,
    File? image,
  }) async {
    if (image != null) {
      // Use multipart form data for image upload
      final formData = FormData.fromMap({
        'householdId': householdId,
        'title': title,
        if (ingredients != null)
          'ingredients': ingredients.map((i) => i.toJson()).toList(),
        if (instructions != null) 'instructions': instructions,
        if (servings != null) 'servings': servings,
        if (sourceUrl != null) 'sourceUrl': sourceUrl,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await _dioClient.post<Map<String, dynamic>>(
        ApiConstants.recipes,
        data: formData,
      );
      return RecipeModel.fromJson(response['data']['recipe']);
    } else {
      // JSON request without image
      final response = await _dioClient.post<Map<String, dynamic>>(
        ApiConstants.recipes,
        data: {
          'householdId': householdId,
          'title': title,
          if (ingredients != null)
            'ingredients': ingredients.map((i) => i.toJson()).toList(),
          if (instructions != null) 'instructions': instructions,
          if (servings != null) 'servings': servings,
          if (sourceUrl != null) 'sourceUrl': sourceUrl,
        },
      );
      return RecipeModel.fromJson(response['data']['recipe']);
    }
  }

  /// Update an existing recipe
  Future<RecipeModel> updateRecipe({
    required String id,
    String? title,
    List<IngredientModel>? ingredients,
    List<String>? instructions,
    int? servings,
    String? sourceUrl,
    File? image,
  }) async {
    if (image != null) {
      final formData = FormData.fromMap({
        if (title != null) 'title': title,
        if (ingredients != null)
          'ingredients': ingredients.map((i) => i.toJson()).toList(),
        if (instructions != null) 'instructions': instructions,
        if (servings != null) 'servings': servings,
        if (sourceUrl != null) 'sourceUrl': sourceUrl,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await _dioClient.patch<Map<String, dynamic>>(
        ApiConstants.recipe(id),
        data: formData,
      );
      return RecipeModel.fromJson(response['data']['recipe']);
    } else {
      final response = await _dioClient.patch<Map<String, dynamic>>(
        ApiConstants.recipe(id),
        data: {
          if (title != null) 'title': title,
          if (ingredients != null)
            'ingredients': ingredients.map((i) => i.toJson()).toList(),
          if (instructions != null) 'instructions': instructions,
          if (servings != null) 'servings': servings,
          if (sourceUrl != null) 'sourceUrl': sourceUrl,
        },
      );
      return RecipeModel.fromJson(response['data']['recipe']);
    }
  }

  /// Delete a recipe
  Future<void> deleteRecipe(String id) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.recipe(id),
    );
  }

  /// Get seasonal vegetables for a household
  Future<List<SeasonalVegetableModel>> getSeasonalVegetables(
    String householdId,
  ) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.seasonalVegetables,
      queryParameters: {'householdId': householdId},
    );

    final vegetables = response['data']['vegetables'] as List<dynamic>? ?? [];
    return vegetables
        .map((v) => SeasonalVegetableModel.fromJson(v as Map<String, dynamic>))
        .toList();
  }
}
