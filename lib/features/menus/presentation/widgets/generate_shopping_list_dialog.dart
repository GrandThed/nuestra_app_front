import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';
import 'package:nuestra_app/features/menus/data/repositories/menu_repository.dart';

/// Dialog for generating a shopping list from a menu plan
class GenerateShoppingListDialog extends ConsumerStatefulWidget {
  final String menuId;
  final String? menuName;

  const GenerateShoppingListDialog({
    super.key,
    required this.menuId,
    this.menuName,
  });

  /// Show the dialog and return the result
  static Future<ShoppingListResultModel?> show(
    BuildContext context, {
    required String menuId,
    String? menuName,
  }) {
    return showDialog<ShoppingListResultModel>(
      context: context,
      builder: (context) => GenerateShoppingListDialog(
        menuId: menuId,
        menuName: menuName,
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

  Future<void> _generate() async {
    setState(() {
      _isGenerating = true;
      _error = null;
    });

    try {
      final repository = ref.read(menuRepositoryProvider);
      final result = await repository.generateShoppingList(
        menuId: widget.menuId,
        servingsMultiplier: _servingsMultiplier,
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
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _result != null ? _buildResult(theme) : _buildForm(theme),
        ),
      ),
    );
  }

  Widget _buildForm(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Row(
          children: [
            Icon(
              Icons.shopping_cart,
              color: theme.colorScheme.primary,
            ),
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
        const SizedBox(height: 16),

        if (widget.menuName != null)
          Text(
            'Menu: ${widget.menuName}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

        const SizedBox(height: 24),

        // Servings multiplier
        Text(
          'Multiplicador de porciones',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Ajusta las cantidades segun el numero de personas',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            IconButton(
              onPressed: _servingsMultiplier > 0.5
                  ? () => setState(() => _servingsMultiplier -= 0.5)
                  : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Expanded(
              child: Slider(
                value: _servingsMultiplier,
                min: 0.5,
                max: 4.0,
                divisions: 7,
                label: '${_servingsMultiplier}x',
                onChanged: (value) {
                  setState(() => _servingsMultiplier = value);
                },
              ),
            ),
            IconButton(
              onPressed: _servingsMultiplier < 4.0
                  ? () => setState(() => _servingsMultiplier += 0.5)
                  : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),

        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_servingsMultiplier}x porciones',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        if (_error != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: theme.colorScheme.error,
                ),
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

        const SizedBox(height: 24),

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
              onPressed: _isGenerating ? null : _generate,
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
