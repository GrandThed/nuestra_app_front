import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';

/// Wishlists screen - Shopping lists and wishlists
class WishlistsScreen extends ConsumerWidget {
  const WishlistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wishlists),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            onPressed: () {
              // TODO: Clear checked items
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.checklist_outlined,
              size: 64,
              color: AppColors.wishlists,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.emptyWishlists,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Agrega items a tu lista'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add wishlist item
        },
        backgroundColor: AppColors.wishlists,
        child: const Icon(Icons.add),
      ),
    );
  }
}
