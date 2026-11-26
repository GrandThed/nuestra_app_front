import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';
import 'package:nuestra_app/features/food/presentation/food_form_sheet.dart';
import 'package:nuestra_app/features/food/presentation/food_providers.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

/// A recipe, scaled to the chosen number of servings.
class RecipeDetailScreen extends ConsumerStatefulWidget {
  final String slug;
  final int? servings;
  const RecipeDetailScreen({super.key, required this.slug, this.servings});

  @override
  ConsumerState<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen> {
  late int? _servings = widget.servings;

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(recipeDetailProvider((slug: widget.slug, servings: _servings)));
    final recipe = detail.asData?.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe?.title ?? 'Receta', maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          if (recipe != null)
            IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              tooltip: 'Agregar al menú',
              onPressed: () => _addToMenu(context, recipe),
            ),
          if (recipe?.householdRecipe == true)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Borrar receta',
              onPressed: () async {
                final outcome = await showFoodFormSheet(
                  context,
                  ref,
                  (id) => FoodForms.confirmar(id,
                      message: '¿Borro "${recipe!.title}"? No se puede deshacer.',
                      action: 'borrar_receta',
                      payload: {'receta': recipe.slug},
                      confirmLabel: 'Borrar'),
                );
                if (outcome?.done == true && context.mounted) context.pop();
              },
            ),
        ],
      ),
      body: switch (detail) {
        AsyncData(:final value) => _Body(
            recipe: value,
            onServings: (s) => setState(() => _servings = s),
          ),
        AsyncError(:final error) => Center(child: Text('No se pudo cargar la receta: $error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Future<void> _addToMenu(BuildContext context, RecipeDetail recipe) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return;
    final picked = await showModalBottomSheet<({DateTime day, String meal})>(
      context: context,
      builder: (_) => _SlotPicker(mealTypes: recipe.mealTypes),
    );
    if (picked == null || !context.mounted) return;
    final repo = ref.read(foodRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    Future<void> save({bool force = false}) async {
      await repo.setEntry(householdId, picked.day, picked.meal,
          recipeSlug: recipe.slug, servings: _servings ?? recipe.servings, force: force);
      ref.invalidate(menuWeekProvider);
      ref.invalidate(shoppingListProvider);
      messenger.showSnackBar(SnackBar(
        content: Text('Agregada: ${mealLabels[picked.meal]?.toLowerCase()} del '
            '${DateFormat("EEEE d", 'es').format(picked.day)}'),
      ));
    }

    try {
      await save();
    } on ServerException catch (e) {
      if (!context.mounted) return;
      final force = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Va contra sus preferencias'),
          content: Text(e.message),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Agregar igual')),
          ],
        ),
      );
      if (force == true) await save(force: true);
    }
  }
}

class _Body extends StatelessWidget {
  final RecipeDetail recipe;
  final ValueChanged<int> onServings;
  const _Body({required this.recipe, required this.onServings});

  @override
  Widget build(BuildContext context) {
    final r = recipe;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final groups = <String?, List<RecipeLine>>{};
    for (final line in r.ingredients) {
      groups.putIfAbsent(line.group, () => []).add(line);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.sm, AppSizes.md, AppSizes.xl),
      children: [
        Text(r.summary, style: text.bodyLarge),
        const SizedBox(height: AppSizes.sm),
        Wrap(spacing: AppSizes.sm, runSpacing: AppSizes.xs, children: [
          Chip(avatar: const Icon(Icons.timer_outlined, size: 18), label: Text('${r.totalMinutes} min')),
          if (r.countryName.isNotEmpty)
            Chip(label: Text(r.countryName[0].toUpperCase() + r.countryName.substring(1))),
          Chip(label: Text(const {1: 'Fácil', 2: 'Media', 3: 'Difícil'}[r.difficulty] ?? '')),
          for (final d in r.dietTags) Chip(label: Text(dietLabels[d] ?? d)),
        ]),
        if (r.warnings.isNotEmpty)
          Card(
            color: scheme.errorContainer,
            child: ListTile(
              leading: Icon(Icons.warning_amber, color: scheme.onErrorContainer),
              title: Text('Ojo con sus preferencias', style: TextStyle(color: scheme.onErrorContainer)),
              subtitle: Text(r.warnings.join('\n'), style: TextStyle(color: scheme.onErrorContainer)),
            ),
          ),
        if (!r.reviewed)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
            child: Text(
              r.origin == 'photo' ? 'Leída de una foto: revisá las cantidades.' : 'Receta sin revisar todavía.',
              style: text.bodySmall?.copyWith(color: scheme.tertiary),
            ),
          ),
        const SizedBox(height: AppSizes.md),
        Row(children: [
          Expanded(child: Text('Ingredientes', style: text.titleLarge)),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            tooltip: 'Menos porciones',
            onPressed: r.servings > 1 ? () => onServings(r.servings - 1) : null,
          ),
          Text('${r.servings} porc.', style: text.titleSmall),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Más porciones',
            onPressed: r.servings < 50 ? () => onServings(r.servings + 1) : null,
          ),
        ]),
        for (final entry in groups.entries) ...[
          if (entry.key != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.sm),
              child: Text(entry.key!, style: text.titleSmall),
            ),
          for (final line in entry.value) _IngredientRow(line: line),
        ],
        if (r.allergens.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.sm),
            child: Text(
              'Contiene: ${r.allergens.map((a) => allergenLabels[a] ?? a).join(', ')}',
              style: text.bodySmall,
            ),
          ),
        const SizedBox(height: AppSizes.lg),
        Text('Pasos', style: text.titleLarge),
        const SizedBox(height: AppSizes.sm),
        for (final step in r.steps)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.md),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: scheme.primaryContainer,
                child: Text('${step.position}', style: text.labelMedium?.copyWith(color: scheme.onPrimaryContainer)),
              ),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(step.text, style: text.bodyLarge),
                  if (step.timerSeconds != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('⏱ ${(step.timerSeconds! / 60).round()} min',
                          style: text.labelMedium?.copyWith(color: scheme.primary)),
                    ),
                ]),
              ),
            ]),
          ),
        for (final tip in r.tips)
          Card(
            color: scheme.tertiaryContainer,
            child: ListTile(
              leading: Icon(Icons.lightbulb_outline, color: scheme.onTertiaryContainer),
              title: Text(tip, style: TextStyle(color: scheme.onTertiaryContainer)),
            ),
          ),
      ],
    );
  }
}

class _IngredientRow extends StatelessWidget {
  final RecipeLine line;
  const _IngredientRow({required this.line});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = line.omit;
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(
          decoration: muted ? TextDecoration.lineThrough : null,
          color: muted ? scheme.onSurfaceVariant : null,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 88,
          child: Text(line.display, style: style?.copyWith(fontWeight: FontWeight.w700)),
        ),
        Expanded(
          child: Text.rich(TextSpan(children: [
            TextSpan(text: line.name, style: style),
            if (line.preparation != null) TextSpan(text: ', ${line.preparation}', style: style),
            if (line.optional) TextSpan(text: ' (opcional)', style: Theme.of(context).textTheme.bodySmall),
            if (muted)
              TextSpan(
                text: '  · sacalo',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.error),
              ),
          ])),
        ),
      ]),
    );
  }
}

/// Pick a day of the next two weeks and a meal.
class _SlotPicker extends StatefulWidget {
  final List<String> mealTypes;
  const _SlotPicker({required this.mealTypes});

  @override
  State<_SlotPicker> createState() => _SlotPickerState();
}

class _SlotPickerState extends State<_SlotPicker> {
  final _today = DateTime.now();
  late DateTime _day = DateTime(_today.year, _today.month, _today.day);
  late String _meal = widget.mealTypes.firstWhere(
    (m) => ['almuerzo', 'cena', 'desayuno', 'merienda'].contains(m),
    orElse: () => 'cena',
  );

  @override
  Widget build(BuildContext context) {
    final days = List.generate(14, (i) => DateTime(_today.year, _today.month, _today.day + i));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, AppSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('¿Cuándo?', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSizes.sm),
            Wrap(spacing: 6, runSpacing: 6, children: [
              for (final d in days)
                ChoiceChip(
                  label: Text(DateFormat('EEE d', 'es').format(d)),
                  selected: d == _day,
                  onSelected: (_) => setState(() => _day = d),
                ),
            ]),
            const SizedBox(height: AppSizes.md),
            Wrap(spacing: 6, children: [
              for (final m in const ['desayuno', 'almuerzo', 'merienda', 'cena'])
                ChoiceChip(
                  label: Text(mealLabels[m]!),
                  selected: m == _meal,
                  onSelected: (_) => setState(() => _meal = m),
                ),
            ]),
            const SizedBox(height: AppSizes.md),
            FilledButton(
              onPressed: () => Navigator.pop(context, (day: _day, meal: _meal)),
              child: const Text('Agregar al menú'),
            ),
          ],
        ),
      ),
    );
  }
}
