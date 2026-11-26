import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/utils/debouncer.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';
import 'package:nuestra_app/features/food/presentation/food_form_sheet.dart';
import 'package:nuestra_app/features/food/presentation/food_providers.dart';
import 'package:nuestra_app/features/food/presentation/recipe_photo_flow.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

const _mealFilters = {
  null: 'Todas',
  'almuerzo': 'Almuerzo',
  'cena': 'Cena',
  'merienda': 'Merienda',
  'postre': 'Postre',
  'entrada': 'Entrada',
  'acompanamiento': 'Acompañamiento',
};

/// Search the catalog and the household's own recipes; add new ones.
class RecipesTab extends ConsumerStatefulWidget {
  const RecipesTab({super.key});

  @override
  ConsumerState<RecipesTab> createState() => _RecipesTabState();
}

class _RecipesTabState extends ConsumerState<RecipesTab> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 350));

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(recipeQueryProvider);
    final results = ref.watch(recipeSearchProvider);
    final notifier = ref.read(recipeQueryProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add-recipe',
        icon: const Icon(Icons.add),
        label: const Text('Receta'),
        onPressed: () => _addMenu(context),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.md, AppSizes.md, 96),
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar: lentejas, peruana, papas y huevo…',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (text) => _debouncer.run(() => notifier.setText(text)),
          ),
          const SizedBox(height: AppSizes.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              for (final e in _mealFilters.entries)
                Padding(
                  padding: const EdgeInsets.only(right: AppSizes.sm),
                  child: ChoiceChip(
                    label: Text(e.value),
                    selected: query.mealType == e.key,
                    onSelected: (_) => notifier.setMealType(e.key),
                  ),
                ),
            ]),
          ),
          const SizedBox(height: AppSizes.sm),
          ...switch (results) {
            AsyncData(:final value) => [
                if (value.excluded > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSizes.sm),
                    child: Text(
                      'Ocultamos ${value.excluded} receta${value.excluded == 1 ? '' : 's'} por sus preferencias.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                if (value.recipes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(AppSizes.xl),
                    child: Text('No encontré recetas. Probá con otra palabra o agregá una propia.',
                        textAlign: TextAlign.center),
                  ),
                for (final r in value.recipes) RecipeCard(recipe: r),
              ],
            AsyncError(:final error) => [Text('No se pudieron cargar las recetas: $error')],
            _ => [const Padding(padding: EdgeInsets.all(32), child: Center(child: CircularProgressIndicator()))],
          },
        ],
      ),
    );
  }

  Future<void> _addMenu(BuildContext context) async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(leading: const Icon(Icons.photo_camera_outlined), title: const Text('Desde una foto o captura'),
              subtitle: const Text('El asistente la lee en tu teléfono'), onTap: () => Navigator.pop(ctx, 'foto')),
          ListTile(leading: const Icon(Icons.edit_note), title: const Text('Escribirla'),
              onTap: () => Navigator.pop(ctx, 'escribir')),
          ListTile(leading: const Icon(Icons.kitchen_outlined), title: const Text('¿Qué hay en la heladera?'),
              subtitle: const Text('Buscar recetas con lo que tenés'), onTap: () => Navigator.pop(ctx, 'heladera')),
          ListTile(leading: const Icon(Icons.eco_outlined), title: const Text('De estación'),
              onTap: () => Navigator.pop(ctx, 'estacion')),
        ]),
      ),
    );
    if (!context.mounted || choice == null) return;
    switch (choice) {
      case 'foto':
        await addRecipeFromPhoto(context, ref);
      case 'escribir':
        await showFoodFormSheet(context, ref, (id) => FoodForms.nuevaReceta(id));
      case 'heladera':
        await showFoodFormSheet(context, ref, FoodForms.heladera);
      case 'estacion':
        final householdId = ref.read(currentHouseholdIdProvider);
        if (householdId == null) return;
        final produce = await ref.read(foodRepositoryProvider).seasonIngredients(householdId);
        if (!context.mounted) return;
        await showFoodFormSheet(context, ref, (id) => FoodForms.deEstacion(id, ingredients: produce));
    }
  }
}

/// A recipe in a list.
class RecipeCard extends StatelessWidget {
  final RecipeSummary recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final r = recipe;
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/food/recipes/${r.slug}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(child: Text(r.title, style: text.titleMedium)),
                if (r.householdRecipe) Icon(Icons.home_outlined, size: 18, color: scheme.tertiary),
              ]),
              const SizedBox(height: 2),
              Text(
                [
                  if (r.totalMinutes > 0) '${r.totalMinutes} min',
                  if (r.countryName.isNotEmpty) r.countryName[0].toUpperCase() + r.countryName.substring(1),
                  if (r.mainIngredients.isNotEmpty) r.mainIngredients.take(3).join(', '),
                ].join(' · '),
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              if (r.dietTags.isNotEmpty || r.omit.isNotEmpty || r.why.isNotEmpty) ...[
                const SizedBox(height: AppSizes.sm),
                Wrap(spacing: 6, runSpacing: 4, children: [
                  for (final d in r.dietTags.take(3)) _Tag(dietLabels[d] ?? d),
                  for (final o in r.omit) _Tag('sin $o', warn: true),
                  for (final w in r.why.take(2)) _Tag(w, accent: true),
                ]),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final bool warn;
  final bool accent;
  const _Tag(this.text, {this.warn = false, this.accent = false});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = warn ? scheme.errorContainer : accent ? scheme.tertiaryContainer : scheme.surfaceContainerHighest;
    final fg = warn ? scheme.onErrorContainer : accent ? scheme.onTertiaryContainer : scheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
      child: Text(text, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg)),
    );
  }
}
