import 'package:flutter/material.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';

class ToolCallCard extends StatelessWidget {
  final ChatToolCallModel toolCall;

  const ToolCallCard({super.key, required this.toolCall});

  @override
  Widget build(BuildContext context) {
    final config = _getToolConfig(toolCall.tool);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: config.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: config.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(config.icon, size: 18, color: config.color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: config.color,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _getDescription(toolCall),
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 18,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }

  String _getDescription(ChatToolCallModel tc) {
    final params = tc.params;
    switch (tc.tool) {
      case 'create_recipe':
        return params['title'] as String? ?? 'Nueva receta';
      case 'add_wishlist_items':
        final items = params['items'] as List<dynamic>? ?? [];
        final names = items
            .map((i) => (i as Map<String, dynamic>)['name'] as String? ?? '')
            .where((n) => n.isNotEmpty)
            .toList();
        return names.join(', ');
      case 'create_expense':
        final amount = params['amount'];
        final desc = params['description'] as String? ?? '';
        return '$desc — \$$amount';
      case 'create_calendar_event':
        return params['title'] as String? ?? 'Nuevo evento';
      case 'add_board_link':
        return params['title'] as String? ?? params['url'] as String? ?? 'Link guardado';
      case 'get_expense_summary':
        return 'Resumen del mes ${params['month'] ?? ''}';
      case 'search_recipes':
        return 'Buscando "${params['query'] ?? ''}"';
      case 'list_calendar_events':
        return 'Eventos del período';
      case 'list_wishlist_items':
        return 'Items de la lista';
      case 'list_boards':
        return 'Tableros del hogar';
      case 'add_menu_item':
        return '${params['recipeName'] ?? 'Receta'} — ${params['mealType'] ?? ''}';
      case 'generate_shopping_list':
        return 'Lista generada del menú';
      default:
        return tc.tool;
    }
  }

  _ToolConfig _getToolConfig(String tool) {
    switch (tool) {
      case 'create_recipe':
      case 'search_recipes':
      case 'extract_recipe_from_image':
        return _ToolConfig(
          icon: Icons.restaurant_menu,
          label: 'RECETA',
          color: const Color(0xFFF97316),
        );
      case 'add_wishlist_items':
      case 'list_wishlist_items':
        return _ToolConfig(
          icon: Icons.checklist,
          label: 'LISTA',
          color: const Color(0xFF8B5CF6),
        );
      case 'create_expense':
      case 'get_expense_summary':
      case 'scan_receipt':
        return _ToolConfig(
          icon: Icons.account_balance_wallet,
          label: 'GASTO',
          color: const Color(0xFF22C55E),
        );
      case 'create_calendar_event':
      case 'list_calendar_events':
        return _ToolConfig(
          icon: Icons.calendar_today,
          label: 'EVENTO',
          color: const Color(0xFF3B82F6),
        );
      case 'add_board_link':
      case 'list_boards':
        return _ToolConfig(
          icon: Icons.dashboard,
          label: 'TABLERO',
          color: const Color(0xFFEC4899),
        );
      case 'add_menu_item':
      case 'generate_shopping_list':
        return _ToolConfig(
          icon: Icons.calendar_view_week,
          label: 'MENÚ',
          color: const Color(0xFF14B8A6),
        );
      default:
        return _ToolConfig(
          icon: Icons.auto_awesome,
          label: 'ACCIÓN',
          color: const Color(0xFF6366F1),
        );
    }
  }
}

class _ToolConfig {
  final IconData icon;
  final String label;
  final Color color;

  const _ToolConfig({
    required this.icon,
    required this.label,
    required this.color,
  });
}
