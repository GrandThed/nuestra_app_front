// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WishlistCategoryModel _$WishlistCategoryModelFromJson(
  Map<String, dynamic> json,
) => _WishlistCategoryModel(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  sortOrder: (json['sortOrder'] as num).toInt(),
  itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$WishlistCategoryModelToJson(
  _WishlistCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': instance.type,
  'sortOrder': instance.sortOrder,
  'itemCount': instance.itemCount,
};

_WishlistItemModel _$WishlistItemModelFromJson(Map<String, dynamic> json) =>
    _WishlistItemModel(
      id: json['id'] as String,
      householdId: json['householdId'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      ownerType: json['ownerType'] as String,
      checked: json['checked'] as bool? ?? false,
      userId: json['userId'] as String?,
      user:
          json['user'] == null
              ? null
              : WishlistItemUserModel.fromJson(
                json['user'] as Map<String, dynamic>,
              ),
      url: json['url'] as String?,
      price: const DecimalConverter().fromJson(json['price']),
      preferenceEmoji: json['preferenceEmoji'] as String?,
      quantity: const DecimalConverter().fromJson(json['quantity']),
      unit: json['unit'] as String?,
      category:
          json['category'] == null
              ? null
              : WishlistCategoryRefModel.fromJson(
                json['category'] as Map<String, dynamic>,
              ),
      sourceRecipe:
          json['sourceRecipe'] == null
              ? null
              : WishlistSourceRecipeModel.fromJson(
                json['sourceRecipe'] as Map<String, dynamic>,
              ),
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$WishlistItemModelToJson(_WishlistItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'ownerType': instance.ownerType,
      'checked': instance.checked,
      'userId': instance.userId,
      'user': instance.user,
      'url': instance.url,
      'price': const DecimalConverter().toJson(instance.price),
      'preferenceEmoji': instance.preferenceEmoji,
      'quantity': const DecimalConverter().toJson(instance.quantity),
      'unit': instance.unit,
      'category': instance.category,
      'sourceRecipe': instance.sourceRecipe,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_WishlistItemUserModel _$WishlistItemUserModelFromJson(
  Map<String, dynamic> json,
) => _WishlistItemUserModel(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$WishlistItemUserModelToJson(
  _WishlistItemUserModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_WishlistCategoryRefModel _$WishlistCategoryRefModelFromJson(
  Map<String, dynamic> json,
) => _WishlistCategoryRefModel(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$WishlistCategoryRefModelToJson(
  _WishlistCategoryRefModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_WishlistSourceRecipeModel _$WishlistSourceRecipeModelFromJson(
  Map<String, dynamic> json,
) => _WishlistSourceRecipeModel(
  id: json['id'] as String,
  title: json['title'] as String,
);

Map<String, dynamic> _$WishlistSourceRecipeModelToJson(
  _WishlistSourceRecipeModel instance,
) => <String, dynamic>{'id': instance.id, 'title': instance.title};
