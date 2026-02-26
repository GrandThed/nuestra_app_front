import 'package:flutter/material.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';

/// Bottom sheet that shows tool call details and a confirm button.
class ToolCallDetailSheet extends StatelessWidget {
  final ChatToolCallModel toolCall;
  final VoidCallback onConfirm;

  const ToolCallDetailSheet({
    super.key,
    required this.toolCall,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          Row(
            children: [
              Icon(
                _getIcon(),
                color: colorScheme.primary,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _getTitle(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Content based on tool type
          Expanded(
            child: SingleChildScrollView(
              child: _buildContent(context),
            ),
          ),

          const SizedBox(height: 20),

          // Confirm button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check, size: 20),
              label: Text(_getConfirmLabel()),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (toolCall.tool) {
      case 'create_recipe':
        return toolCall.params['title'] as String? ?? 'Nueva receta';
      case 'add_wishlist_items':
        return 'Agregar a ${toolCall.params['categoryName'] ?? 'lista'}';
      case 'create_expense':
        return 'Registrar gasto';
      case 'create_calendar_event':
        return toolCall.params['title'] as String? ?? 'Nuevo evento';
      case 'add_board_link':
        return 'Guardar link';
      case 'add_menu_item':
        return 'Agregar al menú';
      case 'generate_shopping_list':
        return 'Generar lista de compras';
      default:
        return toolCall.tool;
    }
  }

  IconData _getIcon() {
    switch (toolCall.tool) {
      case 'create_recipe':
        return Icons.restaurant_menu;
      case 'add_wishlist_items':
        return Icons.checklist;
      case 'create_expense':
        return Icons.account_balance_wallet;
      case 'create_calendar_event':
        return Icons.calendar_today;
      case 'add_board_link':
        return Icons.link;
      case 'add_menu_item':
        return Icons.calendar_view_week;
      case 'generate_shopping_list':
        return Icons.shopping_cart;
      default:
        return Icons.auto_awesome;
    }
  }

  String _getConfirmLabel() {
    switch (toolCall.tool) {
      case 'create_recipe':
        return 'Crear receta';
      case 'add_wishlist_items':
        return 'Agregar items';
      case 'create_expense':
        return 'Registrar gasto';
      case 'create_calendar_event':
        return 'Crear evento';
      case 'add_board_link':
        return 'Guardar link';
      case 'add_menu_item':
        return 'Agregar al menú';
      case 'generate_shopping_list':
        return 'Generar lista';
      default:
        return 'Confirmar';
    }
  }

  Widget _buildContent(BuildContext context) {
    switch (toolCall.tool) {
      case 'create_recipe':
        return _buildRecipeContent(context);
      case 'add_wishlist_items':
        return _buildWishlistContent(context);
      case 'create_expense':
        return _buildExpenseContent(context);
      case 'create_calendar_event':
        return _buildCalendarContent(context);
      case 'add_board_link':
        return _buildBoardLinkContent(context);
      case 'add_menu_item':
        return _buildMenuItemContent(context);
      default:
        return _buildGenericContent(context);
    }
  }

  Widget _buildRecipeContent(BuildContext context) {
    final params = toolCall.params;
    final ingredients = params['ingredients'] as List<dynamic>? ?? [];
    final instructions = params['instructions'] as List<dynamic>? ?? [];
    final servings = params['servings'];
    final prepTime = params['prepTimeMinutes'];
    final cookTime = params['cookTimeMinutes'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Meta info chips
        if (servings != null || prepTime != null || cookTime != null)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (servings != null) _chip(context, Icons.people, '$servings porciones'),
              if (prepTime != null) _chip(context, Icons.timer_outlined, '$prepTime min prep'),
              if (cookTime != null) _chip(context, Icons.local_fire_department, '$cookTime min cocción'),
            ],
          ),
        if (servings != null || prepTime != null || cookTime != null)
          const SizedBox(height: 16),

        // Ingredients
        if (ingredients.isNotEmpty) ...[
          _sectionTitle(context, 'Ingredientes'),
          const SizedBox(height: 8),
          ...ingredients.map((i) {
            final ing = i as Map<String, dynamic>;
            final qty = ing['quantity'];
            final unit = ing['unit'] as String? ?? '';
            final name = ing['name'] as String? ?? '';
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Text('  •  ', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  Expanded(
                    child: Text(
                      qty != null ? '$qty $unit $name'.trim() : name,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
        ],

        // Instructions
        if (instructions.isNotEmpty) ...[
          _sectionTitle(context, 'Pasos'),
          const SizedBox(height: 8),
          ...instructions.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${entry.key + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.value as String,
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildWishlistContent(BuildContext context) {
    final items = toolCall.params['items'] as List<dynamic>? ?? [];
    final category = toolCall.params['categoryName'] as String? ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(context, 'Categoría', category),
        const SizedBox(height: 12),
        _sectionTitle(context, 'Items'),
        const SizedBox(height: 8),
        ...items.map((item) {
          final i = item as Map<String, dynamic>;
          final name = i['name'] as String? ?? '';
          final qty = i['quantity'];
          final notes = i['notes'] as String? ?? '';
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Text('  •  ', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                Expanded(
                  child: Text(
                    [
                      if (qty != null) '${qty}x',
                      name,
                      if (notes.isNotEmpty) '($notes)',
                    ].join(' '),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildExpenseContent(BuildContext context) {
    final params = toolCall.params;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(context, 'Descripción', params['description'] as String? ?? ''),
        const SizedBox(height: 8),
        _infoRow(context, 'Monto', '\$${params['amount']}'),
        const SizedBox(height: 8),
        _infoRow(context, 'Categoría', params['categoryName'] as String? ?? ''),
        if (params['date'] != null) ...[
          const SizedBox(height: 8),
          _infoRow(context, 'Fecha', params['date'] as String),
        ],
      ],
    );
  }

  Widget _buildCalendarContent(BuildContext context) {
    final params = toolCall.params;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(context, 'Título', params['title'] as String? ?? ''),
        const SizedBox(height: 8),
        _infoRow(context, 'Inicio', params['startDate'] as String? ?? ''),
        if (params['endDate'] != null) ...[
          const SizedBox(height: 8),
          _infoRow(context, 'Fin', params['endDate'] as String),
        ],
        if (params['description'] != null) ...[
          const SizedBox(height: 8),
          _infoRow(context, 'Descripción', params['description'] as String),
        ],
        const SizedBox(height: 8),
        _infoRow(context, 'Todo el día', params['allDay'] == true ? 'Sí' : 'No'),
        if (params['recurrence'] != null && params['recurrence'] != 'none') ...[
          const SizedBox(height: 8),
          _infoRow(context, 'Repetir', _recurrenceLabel(params['recurrence'] as String)),
        ],
      ],
    );
  }

  Widget _buildBoardLinkContent(BuildContext context) {
    final params = toolCall.params;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(context, 'Tablero', params['boardName'] as String? ?? ''),
        const SizedBox(height: 8),
        _infoRow(context, 'URL', params['url'] as String? ?? ''),
        if (params['title'] != null) ...[
          const SizedBox(height: 8),
          _infoRow(context, 'Título', params['title'] as String),
        ],
        if (params['notes'] != null) ...[
          const SizedBox(height: 8),
          _infoRow(context, 'Notas', params['notes'] as String),
        ],
      ],
    );
  }

  Widget _buildMenuItemContent(BuildContext context) {
    final params = toolCall.params;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(context, 'Comida', params['recipeName'] as String? ?? params['customName'] as String? ?? ''),
        const SizedBox(height: 8),
        _infoRow(context, 'Fecha', params['date'] as String? ?? ''),
        const SizedBox(height: 8),
        _infoRow(context, 'Tipo', _mealTypeLabel(params['mealType'] as String? ?? '')),
      ],
    );
  }

  Widget _buildGenericContent(BuildContext context) {
    final entries = toolCall.params.entries.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _infoRow(context, e.key, e.value.toString()),
        );
      }).toList(),
    );
  }

  // ==================== Helpers ====================

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _chip(BuildContext context, IconData icon, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _recurrenceLabel(String value) {
    switch (value) {
      case 'daily':
        return 'Diario';
      case 'weekly':
        return 'Semanal';
      case 'monthly':
        return 'Mensual';
      case 'yearly':
        return 'Anual';
      default:
        return value;
    }
  }

  String _mealTypeLabel(String value) {
    switch (value) {
      case 'desayuno':
        return 'Desayuno';
      case 'almuerzo':
        return 'Almuerzo';
      case 'merienda':
        return 'Merienda';
      case 'cena':
        return 'Cena';
      default:
        return value;
    }
  }
}
