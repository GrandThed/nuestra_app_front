/// Plain models for the food feature (recipes, preferences, menus).
/// Parsed by hand from the backend JSON: no code generation.
library;

List<String> _strings(Object? v) =>
    (v as List<dynamic>? ?? const []).map((e) => '$e').toList();

int? _int(Object? v) => v is num ? v.toInt() : int.tryParse('${v ?? ''}');

double? _double(Object? v) =>
    v is num ? v.toDouble() : double.tryParse('${v ?? ''}');

const mealLabels = {
  'desayuno': 'Desayuno',
  'almuerzo': 'Almuerzo',
  'merienda': 'Merienda',
  'cena': 'Cena',
  'postre': 'Postre',
  'entrada': 'Entrada',
  'acompanamiento': 'Acompañamiento',
  'snack': 'Para picar',
};

const dietLabels = {
  'vegetariana': 'Vegetariana',
  'vegana': 'Vegana',
  'sin_tacc': 'Sin TACC',
  'sin_lactosa': 'Sin lactosa',
  'sin_huevo': 'Sin huevo',
};

const allergenLabels = {
  'gluten': 'Gluten (TACC)',
  'huevo': 'Huevo',
  'leche': 'Leche',
  'pescado': 'Pescado',
  'crustaceos': 'Crustáceos',
  'moluscos': 'Moluscos',
  'mani': 'Maní',
  'soja': 'Soja',
  'frutos_secos': 'Frutos secos',
  'apio': 'Apio',
  'mostaza': 'Mostaza',
  'sesamo': 'Sésamo',
  'sulfitos': 'Sulfitos',
};

/// A recipe in search results, menu candidates or a menu entry.
class RecipeSummary {
  final String slug;
  final String title;
  final String summary;
  final String country;
  final String countryName;
  final List<String> mealTypes;
  final int servings;
  final int totalMinutes;
  final int difficulty;
  final List<String> dietTags;
  final List<String> mainIngredients;
  final List<String> omit;
  final List<String> liked;
  final List<String> why;
  final bool reviewed;
  final bool householdRecipe;

  const RecipeSummary({
    required this.slug,
    required this.title,
    this.summary = '',
    this.country = '',
    this.countryName = '',
    this.mealTypes = const [],
    this.servings = 4,
    this.totalMinutes = 0,
    this.difficulty = 1,
    this.dietTags = const [],
    this.mainIngredients = const [],
    this.omit = const [],
    this.liked = const [],
    this.why = const [],
    this.reviewed = false,
    this.householdRecipe = false,
  });

  factory RecipeSummary.fromJson(Map<String, dynamic> j) => RecipeSummary(
        slug: j['slug'] as String,
        title: j['title'] as String,
        summary: j['summary'] as String? ?? '',
        country: j['country'] as String? ?? '',
        countryName: j['countryName'] as String? ?? '',
        mealTypes: _strings(j['mealTypes']),
        servings: _int(j['servings']) ?? 4,
        totalMinutes: _int(j['totalMinutes']) ?? 0,
        difficulty: _int(j['difficulty']) ?? 1,
        dietTags: _strings(j['dietTags']),
        mainIngredients: _strings(j['mainIngredients']),
        omit: _strings(j['omit']),
        liked: _strings(j['liked']),
        why: _strings(j['why']),
        reviewed: j['reviewed'] == true,
        householdRecipe: j['householdRecipe'] == true,
      );
}

class RecipeLine {
  final String? ingredientId;
  final String name;
  final String? group;
  final double? quantity;
  final String unit;
  final String display;
  final String? preparation;
  final bool optional;
  final bool omit;

  const RecipeLine({
    required this.name,
    required this.unit,
    required this.display,
    this.ingredientId,
    this.group,
    this.quantity,
    this.preparation,
    this.optional = false,
    this.omit = false,
  });

  factory RecipeLine.fromJson(Map<String, dynamic> j) {
    final ing = j['ingredient'] as Map<String, dynamic>? ?? const {};
    return RecipeLine(
      ingredientId: ing['id'] as String?,
      name: '${ing['name'] ?? ''}',
      group: j['group'] as String?,
      quantity: _double(j['quantity']),
      unit: j['unit'] as String? ?? 'unidad',
      display: j['display'] as String? ?? '',
      preparation: j['preparation'] as String?,
      optional: j['optional'] == true,
      omit: j['omit'] == true,
    );
  }
}

class RecipeStepItem {
  final int position;
  final String text;
  final int? timerSeconds;

  const RecipeStepItem(this.position, this.text, this.timerSeconds);

  factory RecipeStepItem.fromJson(Map<String, dynamic> j) =>
      RecipeStepItem(_int(j['position']) ?? 0, '${j['text']}', _int(j['timerSeconds']));
}

class RecipeDetail {
  final String slug;
  final String title;
  final String summary;
  final String country;
  final String countryName;
  final List<String> mealTypes;
  final int servings;
  final int baseServings;
  final int prepMinutes;
  final int cookMinutes;
  final int difficulty;
  final List<String> dietTags;
  final List<String> allergens;
  final List<RecipeLine> ingredients;
  final List<RecipeStepItem> steps;
  final List<String> tips;
  final List<String> warnings;
  final bool reviewed;
  final bool householdRecipe;
  final String? origin;

  const RecipeDetail({
    required this.slug,
    required this.title,
    required this.summary,
    required this.country,
    required this.countryName,
    required this.mealTypes,
    required this.servings,
    required this.baseServings,
    required this.prepMinutes,
    required this.cookMinutes,
    required this.difficulty,
    required this.dietTags,
    required this.allergens,
    required this.ingredients,
    required this.steps,
    required this.tips,
    required this.warnings,
    required this.reviewed,
    required this.householdRecipe,
    this.origin,
  });

  int get totalMinutes => prepMinutes + cookMinutes;

  factory RecipeDetail.fromJson(Map<String, dynamic> j) => RecipeDetail(
        slug: j['slug'] as String,
        title: j['title'] as String,
        summary: j['summary'] as String? ?? '',
        country: j['country'] as String? ?? '',
        countryName: j['countryName'] as String? ?? '',
        mealTypes: _strings(j['mealTypes']),
        servings: _int(j['servings']) ?? 4,
        baseServings: _int(j['baseServings']) ?? 4,
        prepMinutes: _int(j['prepMinutes']) ?? 0,
        cookMinutes: _int(j['cookMinutes']) ?? 0,
        difficulty: _int(j['difficulty']) ?? 1,
        dietTags: _strings(j['dietTags']),
        allergens: _strings(j['allergens']),
        ingredients: (j['ingredients'] as List<dynamic>? ?? [])
            .map((e) => RecipeLine.fromJson(e as Map<String, dynamic>))
            .toList(),
        steps: (j['steps'] as List<dynamic>? ?? [])
            .map((e) => RecipeStepItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        tips: _strings(j['tips']),
        warnings: _strings(j['warnings']),
        reviewed: j['reviewed'] == true,
        householdRecipe: j['householdRecipe'] == true,
        origin: j['origin'] as String?,
      );
}

/// What the household likes or can't eat. Exactly one target is set.
class FoodPreference {
  final String id;
  final String kind; // dislike, allergy, like, diet
  final String? ingredientId;
  final String? ingredientName;
  final String? category;
  final String? allergen;
  final String? dietTag;
  final String? memberId;
  final String? memberName;
  final String? note;

  const FoodPreference({
    required this.id,
    required this.kind,
    this.ingredientId,
    this.ingredientName,
    this.category,
    this.allergen,
    this.dietTag,
    this.memberId,
    this.memberName,
    this.note,
  });

  /// "remolacha", "Gluten (TACC)", "Vegetariana", "pescado".
  String get label =>
      ingredientName ??
      (allergen != null ? allergenLabels[allergen] ?? allergen! : null) ??
      (dietTag != null ? dietLabels[dietTag] ?? dietTag! : null) ??
      category ??
      '';

  factory FoodPreference.fromJson(Map<String, dynamic> j) {
    final ing = j['ingredient'] as Map<String, dynamic>?;
    final member = j['member'] as Map<String, dynamic>?;
    return FoodPreference(
      id: j['id'] as String,
      kind: j['kind'] as String,
      ingredientId: ing?['id'] as String?,
      ingredientName: ing?['name'] as String?,
      category: j['category'] as String?,
      allergen: j['allergen'] as String?,
      dietTag: j['dietTag'] as String?,
      memberId: member?['id'] as String?,
      memberName: member?['name'] as String?,
      note: j['note'] as String?,
    );
  }
}

class FoodProfile {
  final int servings;
  final int? weekdayMaxMinutes;
  final int? weekendMaxMinutes;
  final int skill;
  final int budget;
  final List<String> cuisines;
  final List<String> meals;
  final bool onboarded;

  const FoodProfile({
    this.servings = 2,
    this.weekdayMaxMinutes,
    this.weekendMaxMinutes,
    this.skill = 2,
    this.budget = 2,
    this.cuisines = const [],
    this.meals = const ['almuerzo', 'cena'],
    this.onboarded = false,
  });

  factory FoodProfile.fromJson(Map<String, dynamic> j) => FoodProfile(
        servings: _int(j['servings']) ?? 2,
        weekdayMaxMinutes: _int(j['weekdayMaxMinutes']),
        weekendMaxMinutes: _int(j['weekendMaxMinutes']),
        skill: _int(j['skill']) ?? 2,
        budget: _int(j['budget']) ?? 2,
        cuisines: _strings(j['cuisines']),
        meals: _strings(j['meals']),
        onboarded: j['onboarded'] == true,
      );
}

class MenuEntry {
  final String id;
  final String date; // YYYY-MM-DD
  final String meal;
  final RecipeSummary? recipe;
  final int? servings;
  final String? freeText;
  final String? leftoverOfId;
  final String status; // planned, cooked, skipped
  final int? rating; // 1 no repetir, 2 bien, 3 repetir
  final String? note;

  const MenuEntry({
    required this.id,
    required this.date,
    required this.meal,
    this.recipe,
    this.servings,
    this.freeText,
    this.leftoverOfId,
    this.status = 'planned',
    this.rating,
    this.note,
  });

  bool get isLeftovers => leftoverOfId != null;

  String get title =>
      freeText ?? (isLeftovers ? 'Sobras: ${recipe?.title ?? ''}' : recipe?.title ?? '');

  factory MenuEntry.fromJson(Map<String, dynamic> j) => MenuEntry(
        id: j['id'] as String,
        date: j['date'] as String,
        meal: j['meal'] as String,
        recipe: j['recipe'] == null
            ? null
            : RecipeSummary.fromJson(j['recipe'] as Map<String, dynamic>),
        servings: _int(j['servings']),
        freeText: j['freeText'] as String?,
        leftoverOfId: j['leftoverOfId'] as String?,
        status: j['status'] as String? ?? 'planned',
        rating: _int(j['rating']),
        note: j['note'] as String?,
      );
}

class MenuWeekData {
  final String weekStart;
  final List<String> days;
  final List<MenuEntry> entries;

  const MenuWeekData(this.weekStart, this.days, this.entries);

  MenuEntry? entryFor(String day, String meal) =>
      entries.where((e) => e.date == day && e.meal == meal).firstOrNull;

  factory MenuWeekData.fromJson(Map<String, dynamic> j) => MenuWeekData(
        j['weekStart'] as String,
        _strings(j['days']),
        (j['entries'] as List<dynamic>? ?? [])
            .map((e) => MenuEntry.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class ShoppingItem {
  final String key;
  final String name;
  final String display;
  final bool pantry;
  final bool optional;
  final bool checked;

  const ShoppingItem({
    required this.key,
    required this.name,
    required this.display,
    this.pantry = false,
    this.optional = false,
    this.checked = false,
  });

  ShoppingItem withChecked(bool value) => ShoppingItem(
        key: key,
        name: name,
        display: display,
        pantry: pantry,
        optional: optional,
        checked: value,
      );

  factory ShoppingItem.fromJson(Map<String, dynamic> j) => ShoppingItem(
        key: j['key'] as String,
        name: j['name'] as String,
        display: j['display'] as String? ?? '',
        pantry: j['pantry'] == true,
        optional: j['optional'] == true,
        checked: j['checked'] == true,
      );
}

class ShoppingGroup {
  final String category;
  final List<ShoppingItem> items;

  const ShoppingGroup(this.category, this.items);

  static const labels = {
    'verdura': 'Verdulería',
    'fruta': 'Frutas',
    'hierba': 'Hierbas',
    'carne': 'Carnicería',
    'pescado': 'Pescadería',
    'huevo': 'Huevos',
    'lacteo': 'Lácteos',
    'legumbre': 'Legumbres',
    'cereal': 'Harinas, pastas y arroz',
    'conserva': 'Conservas',
    'condimento': 'Condimentos',
    'especia': 'Especias',
    'almacen': 'Almacén',
    'liquido': 'Bebidas y líquidos',
    'otros': 'Otros',
    'tenes_en_casa': '¿Lo tienes en casa?',
  };

  String get label => labels[category] ?? category;

  factory ShoppingGroup.fromJson(Map<String, dynamic> j) => ShoppingGroup(
        j['category'] as String,
        (j['items'] as List<dynamic>? ?? [])
            .map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

/// Search results with how many recipes the household's rules hid.
class RecipeSearchResult {
  final List<RecipeSummary> recipes;
  final int excluded;

  const RecipeSearchResult(this.recipes, this.excluded);
}
