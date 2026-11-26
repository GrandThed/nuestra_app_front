import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';
import 'package:nuestra_app/features/food/presentation/food_form_sheet.dart';
import 'package:nuestra_app/features/food/presentation/food_providers.dart';

/// What the household eats, can't eat and how it cooks. The same data the
/// assistant fills from conversation; editable here with the same forms.
class PreferencesTab extends ConsumerWidget {
  const PreferencesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(foodProfileProvider);
    final prefs = ref.watch(foodPreferencesProvider);
    final members = ref.watch(foodMembersProvider);

    void editProfile() => showFoodFormSheet(
          context,
          ref,
          (id) => FoodForms.perfil(
            id,
            members: members,
            profile: profile.asData?.value ?? const FoodProfile(),
            prefs: prefs.asData?.value ?? const [],
          ),
        );

    final list = prefs.asData?.value ?? const <FoodPreference>[];
    List<FoodPreference> of(String kind) => list.where((p) => p.kind == kind).toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(foodProfileProvider);
        ref.invalidate(foodPreferencesProvider);
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.md, AppSizes.md, 96),
        children: [
          if (profile.asData?.value.onboarded == false)
            Card(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              child: ListTile(
                leading: const Icon(Icons.auto_awesome),
                title: const Text('Contanos cómo comen'),
                subtitle: const Text('Dietas, alergias y gustos: así filtramos recetas y menús.'),
                onTap: editProfile,
              ),
            ),
          _ProfileCard(profile: profile.asData?.value, onEdit: editProfile),
          const SizedBox(height: AppSizes.md),
          _Section(title: 'Dietas', empty: 'Ninguna', prefs: of('diet')),
          _Section(title: 'Alergias e intolerancias', empty: 'Ninguna', prefs: of('allergy'),
              note: 'Una alergia de cualquier persona descarta la receta para toda la casa.'),
          _Section(title: 'No les gusta', empty: 'Nada por ahora', prefs: of('dislike'),
              note: 'Si es opcional en una receta, se indica que lo saquen; si no, la receta no aparece.'),
          _Section(title: 'Les encanta', empty: 'Nada por ahora', prefs: of('like'),
              note: 'Las recetas con estos ingredientes aparecen primero.'),
          const SizedBox(height: AppSizes.md),
          FilledButton.tonalIcon(
            icon: const Icon(Icons.add),
            label: const Text('Agregar un gusto o alergia'),
            onPressed: () => showFoodFormSheet(
              context,
              ref,
              (id) => FoodForms.confirmarPreferencia(id, members: members),
            ),
          ),
          if (prefs.hasError) Text('No se pudieron cargar: ${prefs.error}'),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final FoodProfile? profile;
  final VoidCallback onEdit;
  const _ProfileCard({required this.profile, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final p = profile;
    const skills = {1: 'básico', 2: 'intermedio', 3: 'avanzado'};
    return Card(
      child: ListTile(
        title: const Text('Cómo cocinan'),
        subtitle: p == null
            ? const Text('Cargando…')
            : Text([
                'Para ${p.servings} ${p.servings == 1 ? 'persona' : 'personas'}',
                p.weekdayMaxMinutes == null ? 'sin límite de tiempo' : 'hasta ${p.weekdayMaxMinutes} min entre semana',
                'nivel ${skills[p.skill]}',
                'planean ${p.meals.map((m) => mealLabels[m]?.toLowerCase() ?? m).join(', ')}',
              ].join(' · ')),
        trailing: TextButton(onPressed: onEdit, child: const Text('Editar')),
      ),
    );
  }
}

class _Section extends ConsumerWidget {
  final String title;
  final String empty;
  final String? note;
  final List<FoodPreference> prefs;
  const _Section({required this.title, required this.empty, required this.prefs, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: text.titleSmall),
          if (note != null) Text(note!, style: text.bodySmall),
          const SizedBox(height: AppSizes.xs),
          if (prefs.isEmpty)
            Text(empty, style: text.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))
          else
            Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.xs,
              children: [
                for (final p in prefs)
                  InputChip(
                    label: Text('${p.label}${p.memberName != null ? ' · ${p.memberName}' : ''}'),
                    onDeleted: () async {
                      await ref.read(foodRepositoryProvider).deletePreference(p.id);
                      ref.invalidate(foodPreferencesProvider);
                      ref.invalidate(recipeSearchProvider);
                    },
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
