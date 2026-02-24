import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';
import 'package:nuestra_app/features/menus/data/repositories/menu_repository.dart';

/// Dialog for generating a shopping list from a menu plan
class GenerateShoppingListDialog extends ConsumerStatefulWidget {
  final String menuId;
  final String? menuName;
  final List<MenuItemModel> weekMeals;

  const GenerateShoppingListDialog({
    super.key,
    required this.menuId,
    this.menuName,
    required this.weekMeals,
  });

  /// Show the dialog and return the result
  static Future<ShoppingListResultModel?> show(
    BuildContext context, {
    required String menuId,
    String? menuName,
    required List<MenuItemModel> weekMeals,
  }) {
    return showDialog<ShoppingListResultModel>(
      context: context,
      builder: (context) => GenerateShoppingListDialog(
        menuId: menuId,
        menuName: menuName,
        weekMeals: weekMeals,
      ),
    );
  }

  @override
  ConsumerState<GenerateShoppingListDialog> createState() =>
      _GenerateShoppingListDialogState();
}

class _GenerateShoppingListDialogState
    extends ConsumerState<GenerateShoppingListDialog> {
  double _servingsMultiplier = 1.0;
  bool _isGenerating = false;
  ShoppingListResultModel? _result;
  String? _error;

  /// Dates that have meals, sorted
  late final List<DateTime> _availableDates;

  /// Currently selected dates
  late final Set<DateTime> _selectedDates;

  @override
  void initState() {
    super.initState();
    // Extract unique dates that have meals
    final dateSet = <DateTime>{};
    for (final meal in widget.weekMeals) {
      dateSet.add(DateTime(meal.date.year, meal.date.month, meal.date.day));
    }
    _availableDates = dateSet.toList()..sort();
    _selectedDates = Set.from(_availableDates);
  }

  List<MenuItemModel> get _selectedMeals {
    return widget.weekMeals.where((meal) {
      final mealDate = DateTime(meal.date.year, meal.date.month, meal.date.day);
      return _selectedDates.contains(mealDate);
    }).toList();
  }

  Future<void> _generate() async {
    if (_selectedDates.isEmpty) return;

    setState(() {
      _isGenerating = true;
      _error = null;
    });

    try {
      final repository = ref.read(menuRepositoryProvider);
      final result = await repository.generateShoppingList(
        menuId: widget.menuId,
        servingsMultiplier: _servingsMultiplier,
        dates: _selectedDates.toList(),
      );

      setState(() {
        _result = result;
        _isGenerating = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 650),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _result != null ? _buildResult(theme) : _buildForm(theme),
        ),
      ),
    );
  }

  Widget _buildForm(ThemeData theme) {
    final selectedMeals = _selectedMeals;
    // Group selected meals by date
    final mealsByDate = <DateTime, List<MenuItemModel>>{};
    for (final meal in selectedMeals) {
      final key = DateTime(meal.date.year, meal.date.month, meal.date.day);
      mealsByDate.putIfAbsent(key, () => []).add(meal);
    }
    // Sort meals within each date by meal type
    const mealTypeOrder = ['breakfast', 'lunch', 'dinner', 'snack'];
    for (final meals in mealsByDate.values) {
      meals.sort((a, b) {
        final aIdx = mealTypeOrder.indexOf(a.mealType);
        final bIdx = mealTypeOrder.indexOf(b.mealType);
        return aIdx.compareTo(bIdx);
      });
    }
    final sortedDates = mealsByDate.keys.toList()..sort();

    // Count unique recipes
    final recipeCount =
        selectedMeals.where((m) => m.recipe != null).map((m) => m.recipeId).toSet().length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Row(
          children: [
            Icon(Icons.shopping_cart, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Generar lista de compras',
                style: theme.textTheme.titleLarge,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),

        if (widget.menuName != null) ...[
          const SizedBox(height: 4),
          Text(
            'Menu: ${widget.menuName}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],

        const SizedBox(height: 16),

        // Date selection
        Text('Seleccionar dias', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: _availableDates.map((date) {
            final isSelected = _selectedDates.contains(date);
            final dayFormat = DateFormat('EEE', 'es');
            final dateFormat = DateFormat('d/M');
            final label =
                '${dayFormat.format(date).substring(0, 3).toUpperCase()} ${dateFormat.format(date)}';
            return FilterChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedDates.add(date);
                  } else {
                    _selectedDates.remove(date);
                  }
                });
              },
              showCheckmark: false,
              selectedColor: theme.colorScheme.primaryContainer,
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        // Meal preview
        if (selectedMeals.isNotEmpty) ...[
          Row(
            children: [
              Text(
                '${selectedMeals.length} comida${selectedMeals.length != 1 ? 's' : ''} ($recipeCount receta${recipeCount != 1 ? 's' : ''})',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final date = sortedDates[index];
                  final meals = mealsByDate[date]!;
                  final dayFormat = DateFormat('EEEE d', 'es');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index > 0)
                        const Divider(height: 1, indent: 12, endIndent: 12),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                        child: Text(
                          dayFormat.format(date),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...meals.map((meal) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                            child: Row(
                              children: [
                                Text(
                                  meal.mealType.mealTypeIcon,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    meal.recipe?.title ?? 'Sin receta',
                                    style: theme.textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  );
                },
              ),
            ),
          ),
        ] else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'Selecciona al menos un dia',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),

        const SizedBox(height: 12),

        // Servings multiplier (compact)
        Row(
          children: [
            Text('Porciones:', style: theme.textTheme.labelLarge),
            IconButton(
              onPressed: _servingsMultiplier > 0.5
                  ? () => setState(() => _servingsMultiplier -= 0.5)
                  : null,
              icon: const Icon(Icons.remove_circle_outline, size: 20),
              visualDensity: VisualDensity.compact,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${_servingsMultiplier}x',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: _servingsMultiplier < 4.0
                  ? () => setState(() => _servingsMultiplier += 0.5)
                  : null,
              icon: const Icon(Icons.add_circle_outline, size: 20),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),

        if (_error != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: theme.colorScheme.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _error!,
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 16),

        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed:
                  _isGenerating || _selectedDates.isEmpty ? null : _generate,
              icon: _isGenerating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.shopping_cart),
              label: Text(_isGenerating ? 'Generando...' : 'Generar'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResult(ThemeData theme) {
    final result = _result!;
    final items = result.shoppingList ?? [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lista generada',
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    '${result.itemsCreated} items agregados',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Items preview
        if (items.isNotEmpty)
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: items.length > 10 ? 10 : items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 20),
                    title: Text(item.name),
                    subtitle: item.sourceRecipeName != null
                        ? Text(
                            item.sourceRecipeName!,
                            style: theme.textTheme.bodySmall,
                          )
                        : null,
                    trailing: item.quantity != null
                        ? Text(
                            '${item.quantity}${item.unit != null ? ' ${item.unit}' : ''}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  );
                },
              ),
            ),
          ),

        if (items.length > 10)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '... y ${items.length - 10} items mas',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        const SizedBox(height: 24),

        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _result = null;
                  _error = null;
                });
              },
              child: const Text('Generar otra'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(result),
              child: const Text('Ver lista completa'),
            ),
          ],
        ),
      ],
    );
  }
}
