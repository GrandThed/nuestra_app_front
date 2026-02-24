import 'package:flutter/material.dart';

class QuickActionChips extends StatelessWidget {
  final void Function(String text) onTap;

  const QuickActionChips({super.key, required this.onTap});

  static const _actions = [
    '¿Qué tenemos esta semana?',
    'Agregá leche a la lista',
    '¿Cuánto gastamos este mes?',
    'Sugerí una receta',
    'Creá un evento para el sábado',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: _actions.map((label) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => onTap(label),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.35),
                  ),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
