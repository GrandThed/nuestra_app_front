import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/wishlists/data/models/wishlist_model.dart';

part 'wishlists_state.freezed.dart';

/// State for wishlist categories list
@freezed
sealed class WishlistCategoriesState with _$WishlistCategoriesState {
  const factory WishlistCategoriesState.initial() = WishlistCategoriesStateInitial;
  const factory WishlistCategoriesState.loading() = WishlistCategoriesStateLoading;
  const factory WishlistCategoriesState.loaded(List<WishlistCategoryModel> categories) = WishlistCategoriesStateLoaded;
  const factory WishlistCategoriesState.error(String message) = WishlistCategoriesStateError;
}

/// State for wishlist items list
@freezed
sealed class WishlistItemsState with _$WishlistItemsState {
  const factory WishlistItemsState.initial() = WishlistItemsStateInitial;
  const factory WishlistItemsState.loading() = WishlistItemsStateLoading;
  const factory WishlistItemsState.loaded(List<WishlistItemModel> items) = WishlistItemsStateLoaded;
  const factory WishlistItemsState.error(String message) = WishlistItemsStateError;
}

/// Combined state for wishlists screen (categories + items)
@freezed
sealed class WishlistsState with _$WishlistsState {
  const factory WishlistsState.initial() = WishlistsStateInitial;
  const factory WishlistsState.loading() = WishlistsStateLoading;
  const factory WishlistsState.loaded({
    required List<WishlistCategoryModel> categories,
    required List<WishlistItemModel> items,
  }) = WishlistsStateLoaded;
  const factory WishlistsState.error(String message) = WishlistsStateError;
}
