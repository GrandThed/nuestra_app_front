// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => _RecipeModel(
  id: json['id'] as String,
  householdId: json['householdId'] as String?,
  title: json['title'] as String,
  ingredients: (json['ingredients'] as List<dynamic>?)
      ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  instructions: (json['instructions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  imageUrl: json['imageUrl'] as String?,
  servings: (json['servings'] as num?)?.toInt(),
  sourceUrl: json['sourceUrl'] as String?,
  prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt(),
  cookTimeMinutes: (json['cookTimeMinutes'] as num?)?.toInt(),
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  isFavorite: json['isFavorite'] as bool? ?? false,
  ratings:
      (json['ratings'] as List<dynamic>?)
          ?.map((e) => RecipeRatingModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdBy: json['createdBy'] == null
      ? null
      : RecipeCreatorModel.fromJson(json['createdBy'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RecipeModelToJson(_RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'title': instance.title,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'imageUrl': instance.imageUrl,
      'servings': instance.servings,
      'sourceUrl': instance.sourceUrl,
      'prepTimeMinutes': instance.prepTimeMinutes,
      'cookTimeMinutes': instance.cookTimeMinutes,
      'averageRating': instance.averageRating,
      'isFavorite': instance.isFavorite,
      'ratings': instance.ratings,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_IngredientModel _$IngredientModelFromJson(Map<String, dynamic> json) =>
    _IngredientModel(
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      alternatives: (json['alternatives'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientModelToJson(_IngredientModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'alternatives': instance.alternatives,
    };

_RecipeCreatorModel _$RecipeCreatorModelFromJson(Map<String, dynamic> json) =>
    _RecipeCreatorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$RecipeCreatorModelToJson(_RecipeCreatorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };

_RecipeRatingModel _$RecipeRatingModelFromJson(Map<String, dynamic> json) =>
    _RecipeRatingModel(
      id: json['id'] as String,
      recipeId: json['recipeId'] as String,
      userId: json['userId'] as String,
      user: RecipeCreatorModel.fromJson(json['user'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toInt(),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RecipeRatingModelToJson(_RecipeRatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'userId': instance.userId,
      'user': instance.user,
      'rating': instance.rating,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_SeasonalVegetableModel _$SeasonalVegetableModelFromJson(
  Map<String, dynamic> json,
) => _SeasonalVegetableModel(
  id: json['id'] as String,
  name: json['name'] as String,
  startWeek: (json['startWeek'] as num).toInt(),
  endWeek: (json['endWeek'] as num).toInt(),
  inSeason: json['inSeason'] as bool? ?? false,
);

Map<String, dynamic> _$SeasonalVegetableModelToJson(
  _SeasonalVegetableModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'startWeek': instance.startWeek,
  'endWeek': instance.endWeek,
  'inSeason': instance.inSeason,
};
