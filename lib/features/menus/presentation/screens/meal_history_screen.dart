import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';
import 'package:nuestra_app/shared/widgets/app_network_image.dart';

enum _SortMode { mostCooked, mostRecent }

class MealHistoryScreen extends ConsumerStatefulWidget {
  const MealHistoryScreen({super.key});

  @override
  ConsumerState<MealHistoryScreen> createState() => _MealHistoryScreenState();
}

class _MealHistoryScreenState extends ConsumerState<MealHistoryScreen> {
  _SortMode _sortMode = _SortMode.mostCooked;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final householdId = ref.read(currentHouseholdIdProvider);
      if (householdId != null) {
        ref.read(mealHistoryProvider.notifier).loadIfNeeded(householdId);
      }
    });
  }

  List<MealHistoryModel> _sortedHistory(List<MealHistoryModel> history) {
    final sorted = [...history];
    switch (_sortMode) {
      case _SortMode.mostCooked:
        sorted.sort((a, b) => b.timesCooked.compareTo(a.timesCooked));
      case _SortMode.mostRecent:
        sorted.sort((a, b) => b.lastCooked.compareTo(a.lastCooked));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mealHistoryProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de comidas'),
        backgroundColor: AppColors.menusDark,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<_SortMode>(
            icon: const Icon(Icons.sort),
            tooltip: 'Ordenar',
            onSelected: (mode) {
              setState(() {
                _sortMode = mode;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _SortMode.mostCooked,
                child: Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      color: _sortMode == _SortMode.mostCooked
                          ? AppColors.menus
                          : colorScheme.onSurface,
                      size: AppSizes.iconSm,
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Text(
                      'Mas cocinadas',
                      style: TextStyle(
                        color: _sortMode == _SortMode.mostCooked
                            ? AppColors.menus
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: _SortMode.mostRecent,
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: _sortMode == _SortMode.mostRecent
                          ? AppColors.menus
                          : colorScheme.onSurface,
                      size: AppSizes.iconSm,
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Text(
                      'Mas recientes',
                      style: TextStyle(
                        color: _sortMode == _SortMode.mostRecent
                            ? AppColors.menus
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: switch (state) {
        MealHistoryStateInitial() => const Center(
            child: Text('Cargando historial...'),
          ),
        MealHistoryStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.menus),
          ),
        MealHistoryStateError(:final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: AppSizes.iconXl,
                  color: AppColors.error,
                ),
                const SizedBox(height: AppSizes.md),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: AppSizes.md),
                ElevatedButton(
                  onPressed: () {
                    final householdId = ref.read(currentHouseholdIdProvider);
                    if (householdId != null) {
                      ref
                          .read(mealHistoryProvider.notifier)
                          .load(householdId, forceLoading: true);
                    }
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        MealHistoryStateLoaded(:final history) => _buildLoadedContent(history),
      },
    );
  }

  Widget _buildLoadedContent(List<MealHistoryModel> history) {
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_outlined,
              size: AppSizes.iconXl,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              'No hay historial de comidas',
              style: TextStyle(
                fontSize: AppSizes.fontLg,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              'Las comidas que planifiques apareceran aqui.',
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      );
    }

    final sorted = _sortedHistory(history);

    return RefreshIndicator(
      color: AppColors.menus,
      onRefresh: () async {
        final householdId = ref.read(currentHouseholdIdProvider);
        if (householdId != null) {
          await ref
              .read(mealHistoryProvider.notifier)
              .load(householdId);
        }
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        itemCount: sorted.length,
        itemBuilder: (context, index) {
          return _MealHistoryCard(meal: sorted[index]);
        },
      ),
    );
  }
}

class _MealHistoryCard extends StatelessWidget {
  final MealHistoryModel meal;

  const _MealHistoryCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('d MMM yyyy', 'es');
    final isLongTimeSinceCooked = meal.daysSinceLastCooked >= 30;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: isLongTimeSinceCooked
            ? const BorderSide(color: AppColors.warning, width: 1.5)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Row(
          children: [
            // Thumbnail
            if (meal.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: AppNetworkImage(
                    imageUrl: meal.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.menus.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.menusDark,
                  size: AppSizes.iconMd,
                ),
              ),

            const SizedBox(width: AppSizes.md),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.title,
                    style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Row(
                    children: [
                      Icon(
                        Icons.repeat,
                        size: AppSizes.iconXs,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.xs),
                      Text(
                        meal.timesCooked == 1
                            ? '1 vez'
                            : '${meal.timesCooked} veces',
                        style: TextStyle(
                          fontSize: AppSizes.fontSm,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppSizes.md),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: AppSizes.iconXs,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.xs),
                      Flexible(
                        child: Text(
                          dateFormat.format(meal.lastCooked),
                          style: TextStyle(
                            fontSize: AppSizes.fontSm,
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (isLongTimeSinceCooked) ...[
                    const SizedBox(height: AppSizes.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.15),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusFull),
                      ),
                      child: Text(
                        'Hace mucho que no lo hacen!',
                        style: TextStyle(
                          fontSize: AppSizes.fontXs,
                          fontWeight: FontWeight.w600,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: AppSizes.sm),

            // Days since last cooked
            Column(
              children: [
                Text(
                  '${meal.daysSinceLastCooked}',
                  style: TextStyle(
                    fontSize: AppSizes.fontXl,
                    fontWeight: FontWeight.bold,
                    color: isLongTimeSinceCooked
                        ? AppColors.warning
                        : AppColors.menus,
                  ),
                ),
                Text(
                  'dias',
                  style: TextStyle(
                    fontSize: AppSizes.fontXs,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
