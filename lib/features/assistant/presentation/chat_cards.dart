import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/core/theme/text_styles.dart';
import 'package:nuestra_app/core/utils/currency_input_formatter.dart';
import 'package:nuestra_app/core/utils/money_format.dart';
import 'package:nuestra_app/features/assistant/application/assistant_actions.dart' show monthLabel;
import 'package:nuestra_app/features/assistant/presentation/assistant_controller.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';

const _money = MoneyFormat();
final _shortDate = DateFormat('d MMM', 'es');

/// The frame shared by every card: a label on top ("GASTO", "RECETAS"), the
/// content, and optional actions at the bottom.
class _CardFrame extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget child;
  final List<Widget> actions;

  /// Honey border: something waiting for the user.
  final bool highlight;

  const _CardFrame({
    required this.label,
    required this.icon,
    required this.child,
    this.actions = const [],
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.md, right: 24),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: highlight ? scheme.tertiary : scheme.outlineVariant,
          width: highlight ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 16, color: highlight ? scheme.tertiary : scheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(
              label.toUpperCase(),
              style: text.labelSmall?.copyWith(
                color: highlight ? scheme.tertiary : scheme.onSurfaceVariant,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
          const SizedBox(height: 10),
          child,
          if (actions.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
          ],
        ],
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Widget? trailing;
  const _StatusLine(this.icon, this.label, this.color, {this.trailing});

  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Expanded(child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600))),
        ?trailing,
      ]);
}

/// Any data card, by type.
class DataCardView extends StatelessWidget {
  final int entryKey;
  final DataCard card;
  const DataCardView({super.key, required this.entryKey, required this.card});

  @override
  Widget build(BuildContext context) => switch (card) {
        final ExpenseDraftCard c => ExpenseDraftView(entryKey: entryKey, card: c),
        final SpendingCard c => _SpendingView(c),
        final MonthSummaryCard c => _SummaryView(c),
        final FixedExpensesCard c => _FixedView(c),
        final RecipesCard c => _RecipesView(c),
        final MenuCard c => _MenuView(c),
        final PreferenceCard c => _PreferenceView(entryKey: entryKey, card: c),
        final LinkCard c => _LinkView(c),
      };
}

// ---------- Expense to save ----------

/// The expense read from the message, editable until it is saved. This card
/// is the confirmation: nothing else asks.
class ExpenseDraftView extends ConsumerStatefulWidget {
  final int entryKey;
  final ExpenseDraftCard card;
  const ExpenseDraftView({super.key, required this.entryKey, required this.card});

  @override
  ConsumerState<ExpenseDraftView> createState() => _ExpenseDraftViewState();
}

class _ExpenseDraftViewState extends ConsumerState<ExpenseDraftView> {
  late final _description = TextEditingController(text: widget.card.description);
  late final _amount = TextEditingController(
    text: widget.card.amount == null ? '' : CurrencyInputFormatter.formatValue(widget.card.amount!),
  );
  late DateTime _date = widget.card.date;
  late String? _categoryId = widget.card.categoryId;
  late String? _categoryName = widget.card.categoryName;

  @override
  void didUpdateWidget(ExpenseDraftView old) {
    super.didUpdateWidget(old);
    // Corrected by message ("no, eran 8000"): show the new values
    final c = widget.card;
    final o = old.card;
    if (c.description != o.description) _description.text = c.description;
    if (c.amount != o.amount) _amount.text = c.amount == null ? '' : CurrencyInputFormatter.formatValue(c.amount!);
    if (c.date != o.date) _date = c.date;
    if (c.categoryId != o.categoryId) {
      _categoryId = c.categoryId;
      _categoryName = c.categoryName;
    }
  }

  @override
  void dispose() {
    _description.dispose();
    _amount.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(now.year - 2),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    ref.read(assistantProvider.notifier).confirmDraft(
          widget.entryKey,
          description: _description.text.trim().isEmpty ? null : _description.text.trim(),
          amount: CurrencyInputFormatter.parse(_amount.text),
          date: _date,
          categoryId: () => _categoryId,
          categoryName: () => _categoryName,
        );
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.card;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final expensesState = ref.watch(expensesProvider);
    final categories =
        expensesState is ExpensesStateLoaded ? expensesState.categories : const <ExpenseCategoryModel>[];

    if (!card.isOpen && card.status != DraftStatus.saving) {
      return _CardFrame(
        label: 'Gasto',
        icon: Icons.receipt_long_outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_money.format(card.amount ?? 0),
                style: AppTextStyles.bigAmount(size: 24, color: scheme.onSurface)),
            Text(card.description, style: text.bodyLarge),
            Text('${card.categoryName ?? 'Sin categoría'} · ${_shortDate.format(card.date)}',
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            if (card.status == DraftStatus.saved)
              _StatusLine(
                Icons.check_circle,
                'Guardado en Gastos',
                scheme.success,
                trailing: card.expenseId == null
                    ? null
                    : TextButton(
                        onPressed: () => context.push(AppRoutes.expenseDetail(card.expenseId!)),
                        child: const Text('Ver'),
                      ),
              )
            else
              _StatusLine(Icons.block, 'Descartado', scheme.onSurfaceVariant),
          ],
        ),
      );
    }

    final saving = card.status == DraftStatus.saving;
    // Plain text that can be edited: no box, an underline while typing
    final dense = InputDecoration(
      isDense: true,
      filled: false,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: scheme.primary, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      hintStyle: TextStyle(color: scheme.onSurfaceVariant.withValues(alpha: 0.6)),
    );
    return _CardFrame(
      label: 'Gasto para guardar',
      icon: Icons.receipt_long_outlined,
      highlight: true,
      actions: [
        TextButton(
          onPressed: saving ? null : () => ref.read(assistantProvider.notifier).discardDraft(widget.entryKey),
          child: const Text('Descartar'),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: saving ? null : _save,
          child: saving
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Guardar'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text('\$ ', style: AppTextStyles.bigAmount(size: 18, color: scheme.onSurfaceVariant)),
            Expanded(
              child: TextField(
                controller: _amount,
                enabled: !saving,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [CurrencyInputFormatter()],
                style: AppTextStyles.bigAmount(size: 28, color: scheme.onSurface),
                decoration: dense.copyWith(hintText: 'Monto'),
              ),
            ),
          ]),
          TextField(
            controller: _description,
            enabled: !saving,
            textCapitalization: TextCapitalization.sentences,
            style: text.bodyLarge,
            decoration: dense.copyWith(hintText: 'Descripción'),
          ),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: [
            ActionChip(
              avatar: const Icon(Icons.event, size: 16),
              label: Text(_dayLabel(_date)),
              onPressed: saving ? null : _pickDate,
            ),
            _CategoryChip(
              categories: categories,
              selectedName: _categoryName,
              enabled: !saving,
              onSelected: (c) => setState(() {
                _categoryId = c?.id;
                _categoryName = c?.name;
              }),
            ),
          ]),
          if (card.status == DraftStatus.failed) ...[
            const SizedBox(height: 8),
            _StatusLine(Icons.error_outline, 'No se pudo guardar. Intenta de nuevo.', scheme.error),
          ],
        ],
      ),
    );
  }

  static String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(d.year, d.month, d.day);
    if (day == today) return 'Hoy';
    if (day == today.subtract(const Duration(days: 1))) return 'Ayer';
    return DateFormat('EEE d MMM', 'es').format(d);
  }
}

class _CategoryChip extends StatelessWidget {
  final List<ExpenseCategoryModel> categories;
  final String? selectedName;
  final bool enabled;
  final ValueChanged<ExpenseCategoryModel?> onSelected;

  const _CategoryChip({
    required this.categories,
    required this.selectedName,
    required this.enabled,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final missing = selectedName == null;
    return ActionChip(
      avatar: Icon(missing ? Icons.label_outline : Icons.label, size: 16,
          color: missing ? scheme.tertiary : null),
      label: Text(selectedName ?? 'Elegir categoría',
          style: missing ? TextStyle(color: scheme.tertiary, fontWeight: FontWeight.w600) : null),
      onPressed: !enabled || categories.isEmpty
          ? null
          : () async {
              final picked = await showModalBottomSheet<ExpenseCategoryModel?>(
                context: context,
                showDragHandle: true,
                builder: (ctx) => SafeArea(
                  child: ListView(shrinkWrap: true, children: [
                    for (final c in categories)
                      ListTile(
                        leading: Text(c.icon ?? '•', style: const TextStyle(fontSize: 20)),
                        title: Text(c.name),
                        selected: c.name == selectedName,
                        onTap: () => Navigator.pop(ctx, c),
                      ),
                  ]),
                ),
              );
              if (picked != null) onSelected(picked);
            },
    );
  }
}

// ---------- Expense data ----------

class _SpendingView extends StatelessWidget {
  final SpendingCard card;
  const _SpendingView(this.card);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return _CardFrame(
      label: card.title,
      icon: Icons.search,
      actions: [
        TextButton(onPressed: () => context.go(AppRoutes.expenses), child: const Text('Ver en Gastos')),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_money.format(card.total), style: AppTextStyles.bigAmount(size: 30, color: scheme.onSurface)),
          Text(
            card.count == 0
                ? 'No hay gastos así este mes.'
                : '${card.count} ${card.count == 1 ? 'gasto' : 'gastos'}',
            style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
          if (card.rows.isNotEmpty) const SizedBox(height: 8),
          for (final r in card.rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(children: [
                SizedBox(
                  width: 52,
                  child: Text(_shortDate.format(r.date),
                      style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                ),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(r.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(r.who, style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                  ]),
                ),
                Text(_money.format(r.amount), style: AppTextStyles.amount(color: scheme.onSurface)),
              ]),
            ),
          if (card.count > card.rows.length)
            Text('y ${card.count - card.rows.length} más',
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _SummaryView extends StatelessWidget {
  final MonthSummaryCard card;
  const _SummaryView(this.card);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final top = card.byCategory.take(6).toList();
    final max = top.isEmpty ? 1.0 : top.first.amount;
    return _CardFrame(
      label: 'Gastos de ${monthLabel(card.year, card.month, DateTime.now())}',
      icon: Icons.pie_chart_outline,
      actions: [
        TextButton(onPressed: () => context.go(AppRoutes.expenses), child: const Text('Ver en Gastos')),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_money.format(card.total), style: AppTextStyles.bigAmount(size: 30, color: scheme.onSurface)),
          Text('${card.count} ${card.count == 1 ? 'gasto' : 'gastos'}',
              style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          if (top.isNotEmpty) const SizedBox(height: 10),
          for (final s in top)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text('${s.icon ?? ''} ${s.name}'.trim())),
                  Text(_money.format(s.amount), style: AppTextStyles.amount(color: scheme.onSurface)),
                ]),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: s.amount / max,
                    minHeight: 6,
                    backgroundColor: scheme.surfaceContainerHighest,
                  ),
                ),
              ]),
            ),
          if (card.byCategory.length > top.length)
            Text('y ${card.byCategory.length - top.length} categorías más',
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          if (card.byMember.length > 1) ...[
            const SizedBox(height: 10),
            Text(
              card.byMember.map((m) => '${m.name} ${_money.format(m.amount)}').join(' · '),
              style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class _FixedView extends StatelessWidget {
  final FixedExpensesCard card;
  const _FixedView(this.card);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final total = card.items.fold(0.0, (s, i) => s + i.amount);
    return _CardFrame(
      label: 'Gastos fijos sin cargar',
      icon: Icons.event_repeat,
      highlight: true,
      actions: [
        FilledButton.tonal(onPressed: () => context.go(AppRoutes.expenses), child: const Text('Revisar y cargar')),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final i in card.items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(children: [
                Expanded(child: Text(i.description)),
                Text('día ${i.day}  ', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                Text(_money.format(i.amount), style: AppTextStyles.amount(color: scheme.onSurface)),
              ]),
            ),
          const Divider(),
          Row(children: [
            const Expanded(child: Text('Total estimado')),
            Text(_money.format(total), style: AppTextStyles.amount(color: scheme.onSurface)),
          ]),
        ],
      ),
    );
  }
}

// ---------- Food ----------

class _RecipesView extends StatelessWidget {
  final RecipesCard card;
  const _RecipesView(this.card);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return _CardFrame(
      label: card.title,
      icon: Icons.menu_book_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final r in card.recipes)
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => context.push('/food/recipes/${r.slug}'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r.title, style: text.titleSmall),
                      if (r.note.isNotEmpty)
                        Text(r.note, style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                    ]),
                  ),
                  if (r.minutes > 0)
                    Text('${r.minutes} min', style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                  Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
                ]),
              ),
            ),
          if (card.excluded > 0)
            Text('Dejé afuera ${card.excluded} por sus gustos y alergias.',
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _MenuView extends StatelessWidget {
  final MenuCard card;
  const _MenuView(this.card);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final byDay = <String, List<MenuSlot>>{};
    for (final s in card.slots) {
      (byDay[s.date] ??= []).add(s);
    }
    final dayFormat = DateFormat('EEE d', 'es');
    return _CardFrame(
      label: 'Menú de la semana',
      icon: Icons.restaurant_menu,
      actions: [
        TextButton(onPressed: () => context.go(AppRoutes.food), child: const Text('Abrir el menú')),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (card.slots.isEmpty) const Text('No quedó ninguna comida cargada.'),
          for (final entry in byDay.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  width: 56,
                  child: Text(
                    DateTime.tryParse(entry.key) == null ? entry.key : dayFormat.format(DateTime.parse(entry.key)),
                    style: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    for (final s in entry.value)
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: '${mealLabels[s.meal] ?? s.meal}: ',
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                        TextSpan(text: s.title),
                      ])),
                  ]),
                ),
              ]),
            ),
        ],
      ),
    );
  }
}

class _PreferenceView extends ConsumerWidget {
  final int entryKey;
  final PreferenceCard card;
  const _PreferenceView({required this.entryKey, required this.card});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return _CardFrame(
      label: 'Lo tengo en cuenta',
      icon: Icons.favorite_border,
      child: _StatusLine(
        card.undone ? Icons.undo : Icons.check_circle,
        card.undone ? 'Borrado: ${card.label}' : card.label,
        card.undone ? scheme.onSurfaceVariant : scheme.success,
        trailing: card.undone || card.preferenceId == null
            ? null
            : TextButton(
                onPressed: () => ref.read(assistantProvider.notifier).undoPreference(entryKey),
                child: const Text('Deshacer'),
              ),
      ),
    );
  }
}

class _LinkView extends StatelessWidget {
  final LinkCard card;
  const _LinkView(this.card);

  static const _icons = {
    'cart': Icons.shopping_cart_outlined,
    'recipe': Icons.menu_book_outlined,
    'menu': Icons.restaurant_menu,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.md, right: 24),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Icon(_icons[card.icon] ?? Icons.open_in_new, color: scheme.primary),
        title: Text(card.title),
        subtitle: card.subtitle.isEmpty ? null : Text(card.subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(card.route),
      ),
    );
  }
}

/// Text written by the model, as plain text (it is told not to use
/// markdown, and any marks are removed before it gets here).
class AssistantTextView extends StatelessWidget {
  final String text;
  final String? status;
  const AssistantTextView({super.key, required this.text, this.status});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.md, right: 48),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(6),
          ),
        ),
        child: SelectableText(text, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}

/// "Entendiendo…" with a small spinner while the assistant works.
class StatusView extends StatelessWidget {
  final String status;
  const StatusView(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.md, left: 4),
      child: Row(children: [
        SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: scheme.tertiary)),
        const SizedBox(width: 10),
        Text(status, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
      ]),
    );
  }
}
