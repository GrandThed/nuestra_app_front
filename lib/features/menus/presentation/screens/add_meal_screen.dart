import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';
import 'package:nuestra_app/features/menus/data/repositories/menu_repository.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';

/// Screen for adding or editing a meal in a menu plan
class AddMealScreen extends ConsumerStatefulWidget {
  final String menuId;
  final DateTime? initialDate;
  final String? mealItemId; // For editing existing meal

  const AddMealScreen({
    super.key,
    required this.menuId,
    this.initialDate,
    this.mealItemId,
  });

  @override
  ConsumerState<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends ConsumerState<AddMealScreen> {
  late DateTime _selectedDate;
  String _selectedMealType = 'lunch';
  RecipeModel? _selectedRecipe;
  final _searchController = TextEditingController();
  bool _isLoading = false;
  bool _isLoadingMeal = false;

  bool get _isEditing => widget.mealItemId != null;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();

    // Load recipes if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipesState = ref.read(recipesNotifierProvider);
      if (recipesState is RecipesStateInitial) {
        ref.read(recipesNotifierProvider.notifier).loadRecipes();
      }

      // Load existing meal data if editing
      if (_isEditing) {
        _loadExistingMeal();
      }
    });
  }

  Future<void> _loadExistingMeal() async {
    setState(() => _isLoadingMeal = true);

    // Get meal from the menu plan detail
    final menuState = ref.read(menuPlanDetailNotifierProvider(widget.menuId));
    if (menuState is MenuPlanDetailStateLoaded) {
      final meal = menuState.plan.items?.firstWhere(
        (item) => item.id == widget.mealItemId,
        orElse: () => throw Exception('Meal not found'),
      );

      if (meal != null) {
        setState(() {
          _selectedDate = meal.date;
          _selectedMealType = meal.mealType;
          _selectedRecipe = meal.recipe;
          _isLoadingMeal = false;
        });
      }
    } else {
      // Need to load menu plan first
      await ref
          .read(menuPlanDetailNotifierProvider(widget.menuId).notifier)
          .loadMenuPlan();

      final menuState = ref.read(menuPlanDetailNotifierProvider(widget.menuId));
      if (menuState is MenuPlanDetailStateLoaded) {
        final meal = menuState.plan.items?.firstWhere(
          (item) => item.id == widget.mealItemId,
        );

        if (meal != null) {
          setState(() {
            _selectedDate = meal.date;
            _selectedMealType = meal.mealType;
            _selectedRecipe = meal.recipe;
          });
        }
      }
      setState(() => _isLoadingMeal = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      locale: const Locale('es'),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save() async {
    if (_selectedRecipe == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una receta')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final repository = ref.read(menuRepositoryProvider);

    try {
      if (_isEditing && widget.mealItemId != null) {
        // Update existing meal
        await repository.updateMenuItem(
          menuId: widget.menuId,
          itemId: widget.mealItemId!,
          date: _selectedDate,
          mealType: _selectedMealType,
          recipeId: _selectedRecipe!.id,
        );
      } else {
        // Add new meal
        await repository.addMenuItem(
          menuId: widget.menuId,
          recipeId: _selectedRecipe!.id,
          date: _selectedDate,
          mealType: _selectedMealType,
        );
      }

      // Refresh upcoming meals for the current week
      final weekStart = ref.read(selectedWeekStartProvider);
      ref.read(upcomingMealsNotifierProvider.notifier).loadWeek(weekStart);

      // Refresh menu plan detail if loaded
      ref
          .read(menuPlanDetailNotifierProvider(widget.menuId).notifier)
          .loadMenuPlan();

      if (mounted) {
        context.pop(true); // Return success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipesState = ref.watch(recipesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar comida' : 'Agregar comida'),
        actions: [
          TextButton(
            onPressed: _isLoading || _selectedRecipe == null ? null : _save,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Guardar'),
          ),
        ],
      ),
      body: _isLoadingMeal
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Date and meal type selection
                Container(
                  color: theme.colorScheme.surfaceContainerLow,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Date picker
                      InkWell(
                        onTap: _selectDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fecha',
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('EEEE d MMMM', 'es')
                                          .format(_selectedDate)
                                          .capitalize(),
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Meal type selector
                      Text(
                        'Tipo de comida',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _MealTypeSelector(
                        selected: _selectedMealType,
                        onChanged: (type) {
                          setState(() => _selectedMealType = type);
                        },
                      ),
                    ],
                  ),
                ),

                // Recipe search
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar receta...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref
                                    .read(recipesNotifierProvider.notifier)
                                    .loadRecipes();
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      ref
                          .read(recipesNotifierProvider.notifier)
                          .loadRecipes(search: value);
                    },
                  ),
                ),

                // Selected recipe indicator
                if (_selectedRecipe != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Receta seleccionada',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              Text(
                                _selectedRecipe!.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() => _selectedRecipe = null);
                          },
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 8),

                // Recipe list
                Expanded(
                  child: switch (recipesState) {
                    RecipesStateInitial() ||
                    RecipesStateLoading() =>
                      const Center(child: CircularProgressIndicator()),
                    RecipesStateError(message: final message) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 48),
                            const SizedBox(height: 16),
                            Text(message),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(recipesNotifierProvider.notifier)
                                    .loadRecipes();
                              },
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      ),
                    RecipesStateLoaded(recipes: final recipes) =>
                      recipes.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.restaurant_menu,
                                    size: 64,
                                    color: theme.colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _searchController.text.isNotEmpty
                                        ? 'No se encontraron recetas'
                                        : 'No hay recetas',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  if (_searchController.text.isEmpty)
                                    TextButton(
                                      onPressed: () {
                                        // Navigate to create recipe
                                        context.push('/recipes/new');
                                      },
                                      child:
                                          const Text('Crear primera receta'),
                                    ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: recipes.length,
                              itemBuilder: (context, index) {
                                final recipe = recipes[index];
                                final isSelected =
                                    _selectedRecipe?.id == recipe.id;

                                return _RecipeListTile(
                                  recipe: recipe,
                                  isSelected: isSelected,
                                  onTap: () {
                                    setState(() => _selectedRecipe = recipe);
                                  },
                                );
                              },
                            ),
                  },
                ),
              ],
            ),
    );
  }
}

/// Meal type selector widget
class _MealTypeSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _MealTypeSelector({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const mealTypes = ['breakfast', 'lunch', 'dinner', 'snack'];

    return Row(
      children: mealTypes.map((type) {
        final isSelected = type == selected;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: type != mealTypes.last ? 8 : 0,
            ),
            child: InkWell(
              onTap: () => onChanged(type),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      type.mealTypeIcon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type.mealTypeDisplay,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Recipe list tile widget
class _RecipeListTile extends StatelessWidget {
  final RecipeModel recipe;
  final bool isSelected;
  final VoidCallback onTap;

  const _RecipeListTile({
    required this.recipe,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected ? theme.colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Recipe image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: recipe.imageUrl != null
                      ? Image.network(
                          recipe.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.restaurant_menu),
                          ),
                        )
                      : Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.restaurant_menu,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Recipe info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? theme.colorScheme.onPrimaryContainer
                            : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (recipe.servings != null)
                      Text(
                        '${recipe.servings} porciones',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.7)
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    if (recipe.ingredients != null &&
                        recipe.ingredients!.isNotEmpty)
                      Text(
                        '${recipe.ingredients!.length} ingredientes',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.7)
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),

              // Selection indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// String extension for capitalize
extension _StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
