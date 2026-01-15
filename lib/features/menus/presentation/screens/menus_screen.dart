import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';
import 'package:nuestra_app/shared/widgets/app_network_image.dart';

class MenusScreen extends ConsumerStatefulWidget {
  const MenusScreen({super.key});

  @override
  ConsumerState<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends ConsumerState<MenusScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final weekStart = ref.read(selectedWeekStartProvider);
      ref.read(upcomingMealsNotifierProvider.notifier).loadWeekIfNeeded(weekStart);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekStart = ref.watch(selectedWeekStartProvider);
    final state = ref.watch(upcomingMealsNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Menú Semanal'),
        backgroundColor: AppColors.menus,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => _showGenerateShoppingDialog(context),
            tooltip: 'Generar lista de compras',
          ),
        ],
      ),
      body: Column(
        children: [
          // Week selector
          _WeekSelector(
            weekStart: weekStart,
            onPreviousWeek: () {
              ref.read(selectedWeekStartProvider.notifier).previousWeek();
              final newWeek = ref.read(selectedWeekStartProvider);
              ref.read(upcomingMealsNotifierProvider.notifier).loadWeek(newWeek);
            },
            onNextWeek: () {
              ref.read(selectedWeekStartProvider.notifier).nextWeek();
              final newWeek = ref.read(selectedWeekStartProvider);
              ref.read(upcomingMealsNotifierProvider.notifier).loadWeek(newWeek);
            },
            onToday: () {
              ref.read(selectedWeekStartProvider.notifier).setWeek(DateTime.now());
              final newWeek = ref.read(selectedWeekStartProvider);
              ref.read(upcomingMealsNotifierProvider.notifier).loadWeek(newWeek);
            },
          ),

          // Content
          Expanded(
            child: switch (state) {
              UpcomingMealsStateInitial() => const Center(
                  child: Text('Cargando menú...'),
                ),
              UpcomingMealsStateLoading() => const Center(
                  child: CircularProgressIndicator(color: AppColors.menus),
                ),
              UpcomingMealsStateError(:final message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                      const SizedBox(height: 16),
                      Text(message, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(upcomingMealsNotifierProvider.notifier).loadWeek(weekStart);
                        },
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              UpcomingMealsStateLoaded(:final items, :final weekStart) =>
                _buildWeekView(items, weekStart),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/menus/add-meal'),
        backgroundColor: AppColors.menus,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildWeekView(List<MenuItemModel> items, DateTime weekStart) {
    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      itemCount: 7,
      itemBuilder: (context, index) {
        final day = days[index];
        final dayMeals = items.where((item) {
          return item.date.year == day.year &&
              item.date.month == day.month &&
              item.date.day == day.day;
        }).toList();

        return _DayCard(
          date: day,
          meals: dayMeals,
          onAddMeal: () => context.push('/menus/add-meal', extra: day),
          onMealTap: (meal) => _showMealOptions(context, meal),
        );
      },
    );
  }

  void _showMealOptions(BuildContext context, MenuItemModel meal) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Meal info header
            if (meal.recipe != null)
              ListTile(
                leading: meal.recipe!.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: AppNetworkImage(
                            imageUrl: meal.recipe!.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const CircleAvatar(
                        backgroundColor: AppColors.menus,
                        child: Icon(Icons.restaurant, color: Colors.white),
                      ),
                title: Text(meal.recipe!.title),
                subtitle: Text(meal.mealType.mealTypeDisplay),
              ),
            const Divider(),

            // View recipe
            if (meal.recipe != null)
              ListTile(
                leading: const Icon(Icons.restaurant_menu),
                title: const Text('Ver receta'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.push('/recipes/${meal.recipe!.id}');
                },
              ),

            // Edit meal
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Editar'),
              onTap: () {
                Navigator.pop(sheetContext);
                context.push('/menus/edit-meal/${meal.id}');
              },
            ),

            // Delete meal
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text('Eliminar', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(sheetContext);
                _confirmDeleteMeal(context, meal);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteMeal(BuildContext context, MenuItemModel meal) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar comida'),
        content: Text(
          '¿Seguro que quieres eliminar "${meal.recipe?.title ?? 'esta comida'}" del menú?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ref.read(upcomingMealsNotifierProvider.notifier).removeMealFromView(meal.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Comida eliminada'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showGenerateShoppingDialog(BuildContext context) {
    final multiplierController = TextEditingController(text: '1.0');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Generar lista de compras'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Se generará una lista de compras con todos los ingredientes de las recetas del menú actual.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: multiplierController,
              decoration: const InputDecoration(
                labelText: 'Multiplicador de porciones',
                hintText: '1.0',
                helperText: 'Ej: 2.0 para duplicar las cantidades',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              final multiplier = double.tryParse(multiplierController.text) ?? 1.0;
              _generateShoppingList(context, multiplier);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.menus),
            child: const Text('Generar'),
          ),
        ],
      ),
    );
  }

  void _generateShoppingList(BuildContext context, double multiplier) {
    // TODO: Implement shopping list generation
    // This would require a current menu plan ID
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Función próximamente disponible'),
        backgroundColor: AppColors.info,
      ),
    );
  }
}

class _WeekSelector extends StatelessWidget {
  final DateTime weekStart;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;
  final VoidCallback onToday;

  const _WeekSelector({
    required this.weekStart,
    required this.onPreviousWeek,
    required this.onNextWeek,
    required this.onToday,
  });

  @override
  Widget build(BuildContext context) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final dateFormat = DateFormat('d MMM', 'es');
    final isCurrentWeek = _isCurrentWeek(weekStart);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: AppColors.surface,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onPreviousWeek,
            color: AppColors.menus,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${dateFormat.format(weekStart)} - ${dateFormat.format(weekEnd)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isCurrentWeek)
                  TextButton(
                    onPressed: onToday,
                    child: const Text(
                      'Ir a hoy',
                      style: TextStyle(color: AppColors.menus),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onNextWeek,
            color: AppColors.menus,
          ),
        ],
      ),
    );
  }

  bool _isCurrentWeek(DateTime weekStart) {
    final now = DateTime.now();
    final currentWeekStart = DateTime(now.year, now.month, now.day - (now.weekday - 1));
    return weekStart.year == currentWeekStart.year &&
        weekStart.month == currentWeekStart.month &&
        weekStart.day == currentWeekStart.day;
  }
}

class _DayCard extends StatelessWidget {
  final DateTime date;
  final List<MenuItemModel> meals;
  final VoidCallback onAddMeal;
  final Function(MenuItemModel) onMealTap;

  const _DayCard({
    required this.date,
    required this.meals,
    required this.onAddMeal,
    required this.onMealTap,
  });

  @override
  Widget build(BuildContext context) {
    final dayFormat = DateFormat('EEEE', 'es');
    final dateFormat = DateFormat('d/M');
    final isToday = _isToday(date);

    // Sort meals by meal type order
    final mealTypeOrder = ['breakfast', 'lunch', 'dinner', 'snack'];
    final sortedMeals = [...meals]..sort((a, b) {
        final aIndex = mealTypeOrder.indexOf(a.mealType);
        final bIndex = mealTypeOrder.indexOf(b.mealType);
        return aIndex.compareTo(bIndex);
      });

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isToday
            ? const BorderSide(color: AppColors.menus, width: 2)
            : BorderSide.none,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isToday ? AppColors.menus.withValues(alpha: 0.1) : AppColors.surfaceVariant,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                if (isToday)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.menus,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'HOY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  '${dayFormat.format(date).capitalize()} ${dateFormat.format(date)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isToday ? AppColors.menus : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: onAddMeal,
                  color: AppColors.menus,
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Meals list
          if (sortedMeals.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Sin comidas planificadas',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            ...sortedMeals.map((meal) => _MealTile(
                  meal: meal,
                  onTap: () => onMealTap(meal),
                )),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}

class _MealTile extends StatelessWidget {
  final MenuItemModel meal;
  final VoidCallback onTap;

  const _MealTile({required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Meal type icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _getMealTypeColor(meal.mealType).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  meal.mealType.mealTypeIcon,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Meal info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealType.mealTypeDisplay,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getMealTypeColor(meal.mealType),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    meal.recipe?.title ?? 'Sin receta',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Recipe image
            if (meal.recipe?.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: AppNetworkImage(
                    imageUrl: meal.recipe!.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }

  Color _getMealTypeColor(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.green;
      case 'dinner':
        return Colors.indigo;
      case 'snack':
        return Colors.pink;
      default:
        return AppColors.menus;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
