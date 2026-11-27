import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_controller.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';
import 'package:nuestra_app/features/food/presentation/food_form_sheet.dart';
import 'package:nuestra_app/features/food/presentation/food_providers.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

/// The week's menu: days x planned meals.
class MenuTab extends ConsumerWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monday = ref.watch(selectedWeekProvider);
    final week = ref.watch(menuWeekProvider(monday));
    final meals = ref.watch(foodProfileProvider).asData?.value.meals ?? const ['almuerzo', 'cena'];

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(menuWeekProvider(monday)),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.sm, AppSizes.md, 96),
        children: [
          _WeekHeader(monday: monday),
          const SizedBox(height: AppSizes.sm),
          _WeekActions(monday: monday, hasEntries: week.asData?.value.entries.isNotEmpty ?? false),
          const SizedBox(height: AppSizes.md),
          ...switch (week) {
            AsyncData(:final value) => [
                for (final day in value.days)
                  _DayCard(day: DateTime.parse(day), meals: meals, week: value),
              ],
            AsyncError(:final error) => [Center(child: Text('No se pudo cargar el menú: $error'))],
            _ => [const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()))],
          },
        ],
      ),
    );
  }
}

class _WeekHeader extends ConsumerWidget {
  final DateTime monday;
  const _WeekHeader({required this.monday});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(selectedWeekProvider.notifier);
    final sunday = monday.add(const Duration(days: 6));
    final fmt = DateFormat('d MMM', 'es');
    final isThisWeek = monday == mondayOf(DateTime.now());
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.chevron_left), tooltip: 'Semana anterior', onPressed: notifier.previous),
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            onTap: notifier.thisWeek,
            child: Column(
              children: [
                Text('${fmt.format(monday)} – ${fmt.format(sunday)}',
                    style: Theme.of(context).textTheme.titleMedium),
                Text(isThisWeek ? 'Esta semana' : 'Toca para volver a esta semana',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        IconButton(icon: const Icon(Icons.chevron_right), tooltip: 'Semana siguiente', onPressed: notifier.next),
      ],
    );
  }
}

class _WeekActions extends ConsumerWidget {
  final DateTime monday;
  final bool hasEntries;
  const _WeekActions({required this.monday, required this.hasEntries});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: AppSizes.sm,
      runSpacing: AppSizes.sm,
      children: [
        FilledButton.tonalIcon(
          icon: const Icon(Icons.auto_awesome, size: 18),
          label: const Text('Armar con el asistente'),
          onPressed: () {
            ref.read(assistantProvider.notifier).openWeekPlanner(monday);
            context.go(AppRoutes.chat);
          },
        ),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(minimumSize: const Size(0, 40)),
          icon: const Icon(Icons.shopping_cart_outlined, size: 18),
          label: const Text('Lista de compras'),
          onPressed: () => context.push('/food/shopping?week=${isoDate(monday)}'),
        ),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(minimumSize: const Size(0, 40)),
          icon: const Icon(Icons.replay, size: 18),
          label: const Text('Repetir semana anterior'),
          onPressed: () async {
            final householdId = ref.read(currentHouseholdIdProvider);
            if (householdId == null) return;
            final copied = await ref.read(foodRepositoryProvider).copyPreviousWeek(householdId, monday);
            ref.invalidate(menuWeekProvider(monday));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(copied == 0 ? 'La semana anterior estaba vacía' : 'Copié $copied comidas'),
              ));
            }
          },
        ),
        if (hasEntries)
          TextButton.icon(
            icon: const Icon(Icons.delete_sweep_outlined, size: 18),
            label: const Text('Vaciar'),
            onPressed: () => showFoodFormSheet(
              context,
              ref,
              (id) => FoodForms.confirmar(id,
                  message: '¿Borro todo el menú de esta semana?',
                  action: 'vaciar_semana',
                  payload: {'fecha': isoDate(monday)},
                  confirmLabel: 'Vaciar'),
            ),
          ),
      ],
    );
  }
}

class _DayCard extends ConsumerWidget {
  final DateTime day;
  final List<String> meals;
  final MenuWeekData week;
  const _DayCard({required this.day, required this.meals, required this.week});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final today = DateTime.now();
    final isToday = day.year == today.year && day.month == today.month && day.day == today.day;
    final label = DateFormat('EEEE d', 'es').format(day);
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        side: BorderSide(color: isToday ? scheme.primary : scheme.outlineVariant, width: isToday ? 1.5 : 1),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.sm, AppSizes.sm, AppSizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${label[0].toUpperCase()}${label.substring(1)}${isToday ? ' · hoy' : ''}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isToday ? scheme.primary : scheme.onSurface,
                  ),
            ),
            for (final meal in meals) _Slot(day: day, meal: meal, entry: week.entryFor(isoDate(day), meal)),
          ],
        ),
      ),
    );
  }
}

class _Slot extends ConsumerWidget {
  final DateTime day;
  final String meal;
  final MenuEntry? entry;
  const _Slot({required this.day, required this.meal, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final e = entry;
    final subtitle = e == null
        ? null
        : e.freeText != null
            ? null
            : [
                if (!e.isLeftovers && (e.recipe?.totalMinutes ?? 0) > 0) '${e.recipe!.totalMinutes} min',
                if (e.servings != null) '${e.servings} porciones',
                if (e.rating == 3) '★ para repetir',
                if (e.rating == 1) 'no repetir',
                if (e.status == 'cooked' && e.rating == null) 'cocinada',
              ].join(' · ');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: SizedBox(
        width: 72,
        child: Text(mealLabels[meal] ?? meal,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant)),
      ),
      title: e == null
          ? Text('Elegir…', style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w600))
          : Text(e.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: subtitle == null || subtitle.isEmpty ? null : Text(subtitle),
      trailing: e?.status == 'cooked' ? Icon(Icons.check_circle, size: 18, color: scheme.primary) : null,
      onTap: () => e == null ? _choose(context, ref) : _actions(context, ref, e),
    );
  }

  Future<void> _choose(BuildContext context, WidgetRef ref) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return;
    final candidates = await ref.read(foodRepositoryProvider).candidates(householdId, day, meal);
    if (!context.mounted) return;
    await showFoodFormSheet(
      context,
      ref,
      (id) => FoodForms.cambiarComida(id, day: day, meal: meal, candidates: candidates),
    );
  }

  Future<void> _actions(BuildContext context, WidgetRef ref, MenuEntry e) async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (e.recipe != null)
              ListTile(leading: const Icon(Icons.menu_book_outlined), title: const Text('Ver receta'),
                  onTap: () => Navigator.pop(ctx, 'ver')),
            ListTile(leading: const Icon(Icons.swap_horiz), title: const Text('Cambiar'),
                onTap: () => Navigator.pop(ctx, 'cambiar')),
            if (e.recipe != null && !e.isLeftovers)
              ListTile(leading: const Icon(Icons.star_outline), title: const Text('¿Qué tal estuvo?'),
                  onTap: () => Navigator.pop(ctx, 'valorar')),
            ListTile(leading: const Icon(Icons.delete_outline), title: const Text('Quitar'),
                onTap: () => Navigator.pop(ctx, 'quitar')),
          ],
        ),
      ),
    );
    if (!context.mounted || choice == null) return;
    switch (choice) {
      case 'ver':
        context.push('/food/recipes/${e.recipe!.slug}${e.servings != null ? '?servings=${e.servings}' : ''}');
      case 'cambiar':
        await _choose(context, ref);
      case 'valorar':
        await showFoodFormSheet(context, ref, (id) => FoodForms.valorar(id, entryId: e.id, title: e.title));
      case 'quitar':
        await ref.read(foodRepositoryProvider).deleteEntry(e.id);
        ref.invalidate(menuWeekProvider);
        ref.invalidate(shoppingListProvider);
    }
  }
}
