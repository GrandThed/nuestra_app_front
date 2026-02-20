import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_model.freezed.dart';
part 'wishlist_model.g.dart';

/// Converter for Decimal fields that may come as String or num from Prisma
class DecimalConverter implements JsonConverter<double?, Object?> {
  const DecimalConverter();

  @override
  double? fromJson(Object? json) {
    if (json == null) return null;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json);
    return null;
  }

  @override
  Object? toJson(double? object) => object;
}

/// Model for a wishlist category
@freezed
sealed class WishlistCategoryModel with _$WishlistCategoryModel {
  const factory WishlistCategoryModel({
    required String id,
    required String name,
    required String type, // 'system' | 'custom'
    required int sortOrder,
    @Default(0) int itemCount,
  }) = _WishlistCategoryModel;

  factory WishlistCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistCategoryModelFromJson(json);
}

/// Model for a wishlist item
@freezed
sealed class WishlistItemModel with _$WishlistItemModel {
  const factory WishlistItemModel({
    required String id,
    required String householdId,
    required String categoryId,
    required String name,
    required String ownerType, // 'shared' | 'personal'
    @Default(false) bool checked,
    String? userId,
    WishlistItemUserModel? user,
    String? url,
    @DecimalConverter() double? price,
    String? preferenceEmoji,
    @DecimalConverter() double? quantity,
    String? unit,
    WishlistCategoryRefModel? category,
    WishlistSourceRecipeModel? sourceRecipe,
    DateTime? createdAt,
    @Default(false) bool isSecret,
    String? hiddenFromUserId,
    DateTime? archivedAt,
    @Default([]) List<WishlistVoteModel> votes,
    @DecimalConverter() double? averagePriority,
  }) = _WishlistItemModel;

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemModelFromJson(json);
}

/// Minimal user model for wishlist item owner
@freezed
sealed class WishlistItemUserModel with _$WishlistItemUserModel {
  const factory WishlistItemUserModel({
    required String id,
    required String name,
  }) = _WishlistItemUserModel;

  factory WishlistItemUserModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemUserModelFromJson(json);
}

/// Minimal category reference for wishlist item
@freezed
sealed class WishlistCategoryRefModel with _$WishlistCategoryRefModel {
  const factory WishlistCategoryRefModel({
    required String id,
    required String name,
  }) = _WishlistCategoryRefModel;

  factory WishlistCategoryRefModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistCategoryRefModelFromJson(json);
}

/// Minimal source recipe reference
@freezed
sealed class WishlistSourceRecipeModel with _$WishlistSourceRecipeModel {
  const factory WishlistSourceRecipeModel({
    required String id,
    required String title,
  }) = _WishlistSourceRecipeModel;

  factory WishlistSourceRecipeModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistSourceRecipeModelFromJson(json);
}

/// Model for a vote on a wishlist item
@freezed
sealed class WishlistVoteModel with _$WishlistVoteModel {
  const factory WishlistVoteModel({
    required String id,
    required String wishlistItemId,
    required String userId,
    required int priority,
    required DateTime createdAt,
  }) = _WishlistVoteModel;

  factory WishlistVoteModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistVoteModelFromJson(json);
}

/// Model for purchase history entries
@freezed
sealed class WishlistPurchaseHistoryModel with _$WishlistPurchaseHistoryModel {
  const factory WishlistPurchaseHistoryModel({
    required String id,
    required String householdId,
    required String name,
    @DecimalConverter() double? price,
    required DateTime purchasedAt,
    required String purchasedById,
    WishlistItemUserModel? purchasedBy,
    String? linkedExpenseId,
    String? originalItemId,
  }) = _WishlistPurchaseHistoryModel;

  factory WishlistPurchaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistPurchaseHistoryModelFromJson(json);
}
