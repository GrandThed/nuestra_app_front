import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return FoodRepository(ref.watch(dioClientProvider));
});

/// YYYY-MM-DD for a calendar day (local date, no timezone).
String isoDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Recipes, household food preferences, food profile and weekly menus.
class FoodRepository {
  final DioClient _dio;

  FoodRepository(this._dio);

  Map<String, dynamic> _data(Map<String, dynamic> response) =>
      response['data'] as Map<String, dynamic>;

  // ---------- Recipes ----------

  Future<RecipeSearchResult> searchRecipes(
    String householdId, {
    String? query,
    String? country,
    String? ingredient,
    String? mealType,
    int? maxMinutes,
    int limit = 10,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.recipeSearch,
      queryParameters: {
        'householdId': householdId,
        if (query != null && query.trim().isNotEmpty) 'q': query.trim(),
        if (country != null && country.isNotEmpty) 'country': country,
        if (ingredient != null && ingredient.isNotEmpty) 'ingredient': ingredient,
        if (mealType != null) 'mealType': mealType,
        if (maxMinutes != null) 'maxMinutes': '$maxMinutes',
        'limit': '$limit',
      },
    );
    final data = _data(res);
    return RecipeSearchResult(
      (data['recipes'] as List<dynamic>? ?? [])
          .map((e) => RecipeSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      (data['excluded'] as num?)?.toInt() ?? 0,
    );
  }

  Future<RecipeDetail> recipe(String householdId, String slug, {int? servings}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.recipe(slug),
      queryParameters: {
        'householdId': householdId,
        if (servings != null) 'servings': '$servings',
      },
    );
    return RecipeDetail.fromJson(_data(res)['recipe'] as Map<String, dynamic>);
  }

  /// Save a household recipe (from a form or a photo). Returns the new slug
  /// and the ingredient names that are not in the catalog.
  Future<({String slug, List<String> unmatched})> createRecipe(
    String householdId,
    Map<String, dynamic> recipe,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiConstants.recipes,
      data: {'householdId': householdId, ...recipe},
    );
    final data = _data(res);
    return (
      slug: (data['recipe'] as Map<String, dynamic>)['slug'] as String,
      unmatched: (data['unmatched'] as List<dynamic>? ?? []).map((e) => '$e').toList(),
    );
  }

  Future<void> deleteRecipe(String householdId, String slug) async {
    await _dio.delete<Map<String, dynamic>>(
      ApiConstants.recipe(slug),
      queryParameters: {'householdId': householdId},
    );
  }

  /// Produce in season this month (or [month]): id -> name.
  Future<Map<String, String>> seasonIngredients(String householdId, {int? month}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.seasonIngredients,
      queryParameters: {'householdId': householdId, if (month != null) 'month': '$month'},
    );
    return {
      for (final i in _data(res)['ingredients'] as List<dynamic>? ?? [])
        (i as Map<String, dynamic>)['id'] as String: i['name'] as String,
    };
  }

  // ---------- Preferences ----------

  Future<List<FoodPreference>> preferences(String householdId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.foodPreferences,
      queryParameters: {'householdId': householdId},
    );
    return (_data(res)['preferences'] as List<dynamic>? ?? [])
        .map((e) => FoodPreference.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// kind: dislike, allergy, like, diet. Give one of ingredient (any name or
  /// alias), category, allergen or dietTag.
  Future<FoodPreference> savePreference(
    String householdId, {
    required String kind,
    String? ingredient,
    String? category,
    String? allergen,
    String? dietTag,
    String? memberUserId,
    String? note,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiConstants.foodPreferences,
      data: {
        'householdId': householdId,
        'kind': kind,
        if (ingredient != null) 'ingredient': ingredient,
        if (category != null) 'category': category,
        if (allergen != null) 'allergen': allergen,
        if (dietTag != null) 'dietTag': dietTag,
        if (memberUserId != null) 'memberUserId': memberUserId,
        if (note != null) 'note': note,
      },
    );
    return FoodPreference.fromJson(_data(res)['preference'] as Map<String, dynamic>);
  }

  Future<void> deletePreference(String id) async {
    await _dio.delete<Map<String, dynamic>>(ApiConstants.foodPreference(id));
  }

  // ---------- Profile ----------

  Future<FoodProfile> profile(String householdId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.foodProfile,
      queryParameters: {'householdId': householdId},
    );
    return FoodProfile.fromJson(_data(res)['profile'] as Map<String, dynamic>);
  }

  /// Only the given fields change; `onboarded: true` marks the first-time
  /// questions as answered.
  Future<FoodProfile> updateProfile(String householdId, Map<String, dynamic> fields) async {
    final res = await _dio.put<Map<String, dynamic>>(
      ApiConstants.foodProfile,
      data: {'householdId': householdId, ...fields},
    );
    return FoodProfile.fromJson(_data(res)['profile'] as Map<String, dynamic>);
  }

  // ---------- Menu ----------

  Future<MenuWeekData> week(String householdId, DateTime day) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.menuWeek,
      queryParameters: {'householdId': householdId, 'date': isoDate(day)},
    );
    return MenuWeekData.fromJson(_data(res));
  }

  /// Recipes that fit one slot (household rules already applied), best first.
  Future<List<RecipeSummary>> candidates(
    String householdId,
    DateTime day,
    String meal, {
    int limit = 5,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.menuCandidates,
      queryParameters: {
        'householdId': householdId,
        'date': isoDate(day),
        'meal': meal,
        'limit': '$limit',
      },
    );
    return (_data(res)['candidates'] as List<dynamic>? ?? [])
        .map((e) => RecipeSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Set one slot. Throws (409) with the reasons when the recipe breaks a
  /// household rule, unless [force] (a person choosing it on purpose).
  Future<MenuEntry> setEntry(
    String householdId,
    DateTime day,
    String meal, {
    String? recipeSlug,
    String? freeText,
    String? leftoverOf,
    int? servings,
    bool force = false,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      ApiConstants.menuEntry,
      data: {
        'householdId': householdId,
        'date': isoDate(day),
        'meal': meal,
        if (recipeSlug != null) 'recipe': recipeSlug,
        if (freeText != null) 'freeText': freeText,
        if (leftoverOf != null) 'leftoverOf': leftoverOf,
        if (servings != null) 'servings': servings,
        if (force) 'force': true,
      },
    );
    return MenuEntry.fromJson(_data(res)['entry'] as Map<String, dynamic>);
  }

  Future<MenuEntry> updateEntry(String id, Map<String, dynamic> fields) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      ApiConstants.menuEntryById(id),
      data: fields,
    );
    return MenuEntry.fromJson(_data(res)['entry'] as Map<String, dynamic>);
  }

  Future<void> deleteEntry(String id) async {
    await _dio.delete<Map<String, dynamic>>(ApiConstants.menuEntryById(id));
  }

  Future<void> clearWeek(String householdId, DateTime day) async {
    await _dio.delete<Map<String, dynamic>>(
      ApiConstants.menuWeek,
      queryParameters: {'householdId': householdId, 'date': isoDate(day)},
    );
  }

  Future<int> copyPreviousWeek(String householdId, DateTime day) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiConstants.menuCopyPrevious,
      data: {'householdId': householdId, 'date': isoDate(day)},
    );
    return (_data(res)['copied'] as num?)?.toInt() ?? 0;
  }

  // ---------- Shopping list ----------

  Future<List<ShoppingGroup>> shopping(String householdId, DateTime day) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.menuShopping,
      queryParameters: {'householdId': householdId, 'date': isoDate(day)},
    );
    return (_data(res)['groups'] as List<dynamic>? ?? [])
        .map((e) => ShoppingGroup.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> checkShoppingItem(
    String householdId,
    DateTime day,
    String key,
    bool checked,
  ) async {
    await _dio.put<Map<String, dynamic>>(
      ApiConstants.menuShoppingCheck,
      data: {'householdId': householdId, 'date': isoDate(day), 'key': key, 'checked': checked},
    );
  }
}
