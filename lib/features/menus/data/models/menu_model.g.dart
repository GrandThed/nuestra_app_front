// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuPlanModel _$MenuPlanModelFromJson(Map<String, dynamic> json) =>
    _MenuPlanModel(
      id: json['id'] as String,
      householdId: json['householdId'] as String,
      name: json['name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MenuPlanModelToJson(_MenuPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'name': instance.name,
      'items': instance.items,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_MenuItemModel _$MenuItemModelFromJson(Map<String, dynamic> json) =>
    _MenuItemModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      mealType: json['mealType'] as String,
      recipe: json['recipe'] == null
          ? null
          : RecipeModel.fromJson(json['recipe'] as Map<String, dynamic>),
      recipeId: json['recipeId'] as String?,
      substitutions: json['substitutions'] as Map<String, dynamic>?,
      isLeftover: json['isLeftover'] as bool? ?? false,
      originalMenuItemId: json['originalMenuItemId'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : MenuItemCreatorModel.fromJson(
              json['createdBy'] as Map<String, dynamic>,
            ),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MenuItemModelToJson(_MenuItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'mealType': instance.mealType,
      'recipe': instance.recipe,
      'recipeId': instance.recipeId,
      'substitutions': instance.substitutions,
      'isLeftover': instance.isLeftover,
      'originalMenuItemId': instance.originalMenuItemId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_MenuItemCreatorModel _$MenuItemCreatorModelFromJson(
  Map<String, dynamic> json,
) => _MenuItemCreatorModel(
  id: json['id'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$MenuItemCreatorModelToJson(
  _MenuItemCreatorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'avatarUrl': instance.avatarUrl,
};

_ShoppingListResultModel _$ShoppingListResultModelFromJson(
  Map<String, dynamic> json,
) => _ShoppingListResultModel(
  menuPlanId: json['menuPlanId'] as String,
  menuName: json['menuName'] as String?,
  servingsMultiplier: (json['servingsMultiplier'] as num).toDouble(),
  itemsCreated: (json['itemsCreated'] as num).toInt(),
  shoppingList: (json['shoppingList'] as List<dynamic>?)
      ?.map((e) => ShoppingItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ShoppingListResultModelToJson(
  _ShoppingListResultModel instance,
) => <String, dynamic>{
  'menuPlanId': instance.menuPlanId,
  'menuName': instance.menuName,
  'servingsMultiplier': instance.servingsMultiplier,
  'itemsCreated': instance.itemsCreated,
  'shoppingList': instance.shoppingList,
};

_ShoppingItemModel _$ShoppingItemModelFromJson(Map<String, dynamic> json) =>
    _ShoppingItemModel(
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      sourceRecipeId: json['sourceRecipeId'] as String?,
      sourceRecipeName: json['sourceRecipeName'] as String?,
    );

Map<String, dynamic> _$ShoppingItemModelToJson(_ShoppingItemModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'sourceRecipeId': instance.sourceRecipeId,
      'sourceRecipeName': instance.sourceRecipeName,
    };

_UpcomingMealsModel _$UpcomingMealsModelFromJson(Map<String, dynamic> json) =>
    _UpcomingMealsModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      from: DateTime.parse(json['from'] as String),
      to: DateTime.parse(json['to'] as String),
    );

Map<String, dynamic> _$UpcomingMealsModelToJson(_UpcomingMealsModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'from': instance.from.toIso8601String(),
      'to': instance.to.toIso8601String(),
    };

_MealHistoryModel _$MealHistoryModelFromJson(Map<String, dynamic> json) =>
    _MealHistoryModel(
      recipeId: json['recipeId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      timesCooked: (json['timesCooked'] as num).toInt(),
      lastCooked: DateTime.parse(json['lastCooked'] as String),
      daysSinceLastCooked: (json['daysSinceLastCooked'] as num).toInt(),
    );

Map<String, dynamic> _$MealHistoryModelToJson(_MealHistoryModel instance) =>
    <String, dynamic>{
      'recipeId': instance.recipeId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'timesCooked': instance.timesCooked,
      'lastCooked': instance.lastCooked.toIso8601String(),
      'daysSinceLastCooked': instance.daysSinceLastCooked,
    };
