import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/presentation/food_providers.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

/// Everything the week's menu needs, grouped by where you buy it. Ticks are
/// shared with the household.
class ShoppingScreen extends ConsumerStatefulWidget {
  final DateTime monday;
  const ShoppingScreen({super.key, required this.monday});

  @override
  ConsumerState<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends ConsumerState<ShoppingScreen> {
  final Map<String, bool> _local = {};

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(shoppingListProvider(widget.monday));
    final title = 'Compras · semana del ${DateFormat('d MMM', 'es').format(widget.monday)}';
    return Scaffold(
      appBar: AppBar(title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: switch (list) {
        AsyncData(:final value) when value.isEmpty => const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.xl),
              child: Text('El menú de esta semana no tiene recetas todavía.', textAlign: TextAlign.center),
            ),
          ),
        AsyncData(:final value) => RefreshIndicator(
            onRefresh: () async => ref.invalidate(shoppingListProvider(widget.monday)),
            child: ListView(
              padding: const EdgeInsets.only(bottom: AppSizes.xl),
              children: [for (final group in value) ..._group(context, group)],
            ),
          ),
        AsyncError(:final error) => Center(child: Text('No se pudo cargar la lista: $error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  List<Widget> _group(BuildContext context, ShoppingGroup group) => [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.md, AppSizes.md, 0),
          child: Text(group.label, style: Theme.of(context).textTheme.titleSmall),
        ),
        for (final item in group.items)
          CheckboxListTile(
            value: _local[item.key] ?? item.checked,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              item.name,
              style: (_local[item.key] ?? item.checked)
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
            subtitle: Text([item.display, if (item.optional) 'opcional'].join(' · ')),
            onChanged: (value) => _toggle(item, value ?? false),
          ),
      ];

  Future<void> _toggle(ShoppingItem item, bool checked) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return;
    setState(() => _local[item.key] = checked);
    try {
      await ref.read(foodRepositoryProvider).checkShoppingItem(householdId, widget.monday, item.key, checked);
    } catch (_) {
      if (mounted) setState(() => _local.remove(item.key));
    }
  }
}
