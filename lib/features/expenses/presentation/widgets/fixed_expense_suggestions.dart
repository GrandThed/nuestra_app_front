import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/utils/currency_input_formatter.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/core/utils/money_format.dart';

/// Months whose suggestions the user dismissed this session ("year-month").
class _DismissedMonthsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void dismiss(String monthKey) => state = {...state, monthKey};
}

final _dismissedMonthsProvider =
    NotifierProvider<_DismissedMonthsNotifier, Set<String>>(
  _DismissedMonthsNotifier.new,
);

final _currency = const MoneyFormat();

/// Banner shown in Gastos when fixed expenses from previous months
/// (services, rent, subscriptions) are not loaded yet for the selected month.
/// Tapping it opens a sheet to review, adjust and load them in one go.
class FixedExpenseSuggestionsBanner extends ConsumerWidget {
  final int month;
  final int year;

  const FixedExpenseSuggestionsBanner({
    super.key,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final predictions =
        ref.watch(expensePredictionsProvider).asData?.value ?? const [];
    final monthKey = '$year-$month';
    final dismissed = ref.watch(_dismissedMonthsProvider).contains(monthKey);
    if (predictions.isEmpty || dismissed) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final total = predictions.fold(0.0, (sum, p) => sum + p.suggestedAmount);
    final count = predictions.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.md,
        0,
        AppSizes.md,
        AppSizes.sm,
      ),
      child: Material(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          onTap: () => _openSheet(context, predictions),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.sm,
            ),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, color: colorScheme.tertiary),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        count == 1
                            ? '1 gasto fijo para cargar'
                            : '$count gastos fijos para cargar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onTertiaryContainer,
                        ),
                      ),
                      Text(
                        'Se repiten todos los meses · ${_currency.format(total)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onTertiaryContainer
                              .withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => _openSheet(context, predictions),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.tertiary,
                  ),
                  child: const Text('Revisar'),
                ),
                IconButton(
                  color: colorScheme.onTertiaryContainer,
                  icon: const Icon(Icons.close, size: 18),
                  tooltip: 'Ocultar este mes',
                  visualDensity: VisualDensity.compact,
                  onPressed: () => ref
                      .read(_dismissedMonthsProvider.notifier)
                      .dismiss(monthKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openSheet(
    BuildContext context,
    List<ExpensePredictionModel> predictions,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _SuggestionsSheet(predictions: predictions),
    );
  }
}

class _SuggestionsSheet extends ConsumerStatefulWidget {
  final List<ExpensePredictionModel> predictions;

  const _SuggestionsSheet({required this.predictions});

  @override
  ConsumerState<_SuggestionsSheet> createState() => _SuggestionsSheetState();
}

class _SuggestionsSheetState extends ConsumerState<_SuggestionsSheet> {
  late final Map<String, ExpensePredictionModel> _items = {
    for (final p in widget.predictions) p.key: p,
  };

  // Pre-select the confident ones; the rest stay one tap away.
  late final Set<String> _selected = {
    for (final p in widget.predictions)
      if (p.confidence >= 0.6) p.key,
  };
  bool _saving = false;

  Future<void> _editAmount(ExpensePredictionModel p) async {
    final controller = TextEditingController(
      text: CurrencyInputFormatter.formatValue(p.suggestedAmount),
    );
    final amount = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(p.description),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [CurrencyInputFormatter()],
              decoration: const InputDecoration(
                prefixText: '\$ ',
                labelText: 'Monto de este mes',
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              'Último: ${_currency.format(p.lastAmount)} · '
              'Promedio: ${_currency.format(p.averageAmount)}',
              style: Theme.of(dialogContext).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final value = CurrencyInputFormatter.parse(controller.text);
              if (value != null && value > 0) {
                Navigator.pop(dialogContext, value);
              }
            },
            child: const Text('Listo'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (amount != null) {
      setState(() {
        _items[p.key] = p.copyWith(suggestedAmount: amount);
        _selected.add(p.key);
      });
    }
  }

  Future<void> _apply() async {
    final chosen = [
      for (final key in _selected)
        if (_items[key] != null) _items[key]!,
    ];
    if (chosen.isEmpty) return;

    setState(() => _saving = true);
    final created =
        await ref.read(expensesProvider.notifier).applyPredictions(chosen);
    if (!mounted) return;
    setState(() => _saving = false);

    final messenger = ScaffoldMessenger.of(context);
    if (created == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudieron cargar los gastos')),
      );
      return;
    }
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          created == 1 ? 'Se cargó 1 gasto' : 'Se cargaron $created gastos',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final items = _items.values.toList();
    final selectedTotal = items
        .where((p) => _selected.contains(p.key))
        .fold(0.0, (sum, p) => sum + p.suggestedAmount);

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gastos fijos detectados',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    'Se pagaron en los meses anteriores y todavía no están '
                    'cargados. Tocá un monto para ajustarlo.',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final p in items)
                    CheckboxListTile(
                      value: _selected.contains(p.key),
                      onChanged: (checked) => setState(() {
                        checked == true
                            ? _selected.add(p.key)
                            : _selected.remove(p.key);
                      }),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        '${p.category?.icon ?? ''} ${p.description}'.trim(),
                      ),
                      subtitle: Text(
                        'Día ${p.suggestedDate.day} · '
                        'pagado ${p.monthsSeen} de los últimos '
                        '${p.lookbackMonths} meses',
                      ),
                      secondary: TextButton(
                        onPressed: () => _editAmount(p),
                        child: Text(_currency.format(p.suggestedAmount)),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: FilledButton(
                onPressed: _selected.isEmpty || _saving ? null : _apply,
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        'Cargar ${_selected.length} · '
                        '${_currency.format(selectedTotal)}',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
