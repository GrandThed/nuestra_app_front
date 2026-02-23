import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';

/// Card showing today's meals on the home dashboard
class TodaysMenuCard extends ConsumerWidget {
  const TodaysMenuCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(upcomingMealsProvider);
    final today = DateTime.now();
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () => context.go(AppRoutes.menus),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Icon(
                      Icons.restaurant_menu,
                      color: colorScheme.primary,
                      size: AppSizes.iconMd,
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: Text(
                      'Menu de hoy',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),

              // Content based on state
              switch (state) {
                UpcomingMealsStateInitial() => const _LoadingContent(),
                UpcomingMealsStateLoading() => const _LoadingContent(),
                UpcomingMealsStateError(:final message) =>
                  _ErrorContent(message: message),
                UpcomingMealsStateLoaded(:final items) =>
                  _MealsContent(meals: _getTodaysMeals(items, today)),
              },
            ],
          ),
        ),
      ),
    );
  }

  List<MenuItemModel> _getTodaysMeals(List<MenuItemModel> items, DateTime today) {
    return items.where((item) {
      return item.date.year == today.year &&
          item.date.month == today.month &&
          item.date.day == today.day;
    }).toList();
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.md),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String message;

  const _ErrorContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: AppSizes.iconSm,
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.red,
                fontSize: AppSizes.fontSm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealsContent extends StatelessWidget {
  final List<MenuItemModel> meals;

  const _MealsContent({required this.meals});

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      final colorScheme = Theme.of(context).colorScheme;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.no_meals_outlined,
                size: 40,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                'Sin comidas planificadas',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: AppSizes.fontSm,
                ),
              ),
              const SizedBox(height: AppSizes.xs),
              Text(
                'Toca para planificar',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Sort by meal type order
    const mealTypeOrder = ['breakfast', 'lunch', 'dinner', 'snack'];
    final sortedMeals = [...meals]..sort((a, b) {
        return mealTypeOrder
            .indexOf(a.mealType)
            .compareTo(mealTypeOrder.indexOf(b.mealType));
      });

    return Column(
      children: sortedMeals.map((meal) => _MealRow(meal: meal)).toList(),
    );
  }
}

class _MealRow extends StatelessWidget {
  final MenuItemModel meal;

  const _MealRow({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
      child: Row(
        children: [
          Text(
            meal.mealType.mealTypeIcon,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.mealType.mealTypeDisplay,
                  style: TextStyle(
                    fontSize: AppSizes.fontXs,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  meal.recipe?.title ?? 'Sin receta',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
