import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';

/// Screen for viewing expense summary with balances and settlements
class ExpenseSummaryScreen extends ConsumerStatefulWidget {
  final int? month;
  final int? year;

  const ExpenseSummaryScreen({
    super.key,
    this.month,
    this.year,
  });

  @override
  ConsumerState<ExpenseSummaryScreen> createState() =>
      _ExpenseSummaryScreenState();
}

class _ExpenseSummaryScreenState extends ConsumerState<ExpenseSummaryScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_AR', symbol: '\$');
  late int _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = widget.month ?? now.month;
    _selectedYear = widget.year ?? now.year;

    Future.microtask(() {
      ref.read(expenseSummaryProvider.notifier).loadSummary(
            month: _selectedMonth,
            year: _selectedYear,
            forceLoading: true,
          );
      // Also load expenses for the same month/year
      ref.read(expensesProvider.notifier).loadExpenses(
            month: _selectedMonth,
            year: _selectedYear,
            forceLoading: true,
          );
    });
  }

  String _getMonthName(int month) {
    return DateFormat('MMMM', 'es').format(DateTime(2024, month));
  }

  Future<void> _selectMonth() async {
    final now = DateTime.now();
    final result = await showDialog<Map<String, int>>(
      context: context,
      builder: (dialogContext) => _MonthYearPickerDialog(
        initialYear: _selectedYear,
        initialMonth: _selectedMonth,
        firstYear: 2020,
        lastYear: now.year + 1,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedMonth = result['month']!;
        _selectedYear = result['year']!;
      });
      ref.read(expenseSummaryProvider.notifier).loadSummary(
            month: _selectedMonth,
            year: _selectedYear,
            forceLoading: true,
          );
      // Also reload expenses for the new month/year
      ref.read(expensesProvider.notifier).loadExpenses(
            month: _selectedMonth,
            year: _selectedYear,
            forceLoading: true,
          );
    }
  }

  Future<void> _recalculateSplits() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Recalcular divisiones'),
        content: const Text(
          'Se recalcularán las divisiones de todos los gastos de este mes '
          'usando los ingresos actuales de cada miembro.\n\n'
          'Los gastos con divisiones personalizadas no se modificarán.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Recalcular'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final result = await ref
          .read(expenseSummaryProvider.notifier)
          .recalculateSplits(
            month: _selectedMonth,
            year: _selectedYear,
          );

      if (mounted && result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Se recalcularon ${result.updatedCount} gastos'
              '${result.skippedCustom > 0 ? ' (${result.skippedCustom} personalizados omitidos)' : ''}',
            ),
          ),
        );
        // Reload summary and expenses
        ref.read(expenseSummaryProvider.notifier).loadSummary(
              month: _selectedMonth,
              year: _selectedYear,
              forceLoading: true,
            );
        ref.read(expensesProvider.notifier).loadExpenses(
              month: _selectedMonth,
              year: _selectedYear,
              forceLoading: true,
            );
      }
    }
  }

  /// Opens the itemized breakdown for the period: every expense colored by who
  /// paid it, the per-person calculations, plus options to copy it or settle.
  Future<void> _showSettlementBreakdown() async {
    final summaryState = ref.read(expenseSummaryProvider);
    if (summaryState is! ExpenseSummaryStateLoaded) return;

    final expensesState = ref.read(expensesProvider);
    // Only consider expenses that still have pending splits — already-settled
    // ones were paid in a previous round and shouldn't be counted again.
    final expenses = expensesState is ExpensesStateLoaded
        ? expensesState.expenses.where((e) => !e.allSettled).toList()
        : <ExpenseModel>[];

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => _SettlementBreakdownSheet(
        monthLabel: '${_getMonthName(_selectedMonth)} $_selectedYear',
        expenses: expenses,
        currencyFormat: _currencyFormat,
        onSettle: () {
          Navigator.pop(sheetContext);
          _runSettlePeriod();
        },
      ),
    );
  }

  Future<void> _runSettlePeriod() async {
    final fromDate = DateTime(_selectedYear, _selectedMonth, 1);
    // End of the last day of the month so late-in-the-day expenses are included.
    final toDate =
        DateTime(_selectedYear, _selectedMonth + 1, 0, 23, 59, 59, 999);

    final result = await ref
        .read(expenseSummaryProvider.notifier)
        .settlePeriod(fromDate: fromDate, toDate: toDate);

    if (mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Se saldaron ${result.settledCount} divisiones en ${result.expensesAffected} gastos',
          ),
        ),
      );
      // Refresh the main expenses list for the same period and the summary.
      ref.read(expensesProvider.notifier).loadExpenses(
            month: _selectedMonth,
            year: _selectedYear,
          );
      ref.read(expenseSummaryProvider.notifier).loadSummary(
            month: _selectedMonth,
            year: _selectedYear,
            forceLoading: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseSummaryProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de gastos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate_outlined),
            tooltip: 'Recalcular divisiones por ingreso',
            onPressed: _recalculateSplits,
          ),
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: 'Saldar período',
            onPressed: _showSettlementBreakdown,
          ),
        ],
      ),
      body: switch (state) {
        ExpenseSummaryStateInitial() ||
        ExpenseSummaryStateLoading() =>
          const Center(child: CircularProgressIndicator()),
        ExpenseSummaryStateError(message: final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                const SizedBox(height: AppSizes.md),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: AppSizes.md),
                FilledButton.icon(
                  onPressed: () => ref
                      .read(expenseSummaryProvider.notifier)
                      .loadSummary(
                        month: _selectedMonth,
                        year: _selectedYear,
                        forceLoading: true,
                      ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ExpenseSummaryStateLoaded(summary: final summary) =>
          _buildContent(summary, colorScheme),
      },
    );
  }

  Widget _buildContent(ExpenseSummaryModel summary, ColorScheme colorScheme) {
    // Get expenses from the expenses notifier
    final expensesState = ref.watch(expensesProvider);
    final allExpenses = expensesState is ExpensesStateLoaded ? expensesState.expenses : <ExpenseModel>[];

    // Separate into pending and settled
    final pendingExpenses = allExpenses.where((e) => !e.allSettled).toList();
    final settledExpenses = allExpenses.where((e) => e.allSettled).toList();

    return RefreshIndicator(
      onRefresh: () => ref
          .read(expenseSummaryProvider.notifier)
          .loadSummary(month: _selectedMonth, year: _selectedYear),
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.lg),
        children: [
          // Month selector
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(
                '${_getMonthName(_selectedMonth)} $_selectedYear',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectMonth,
            ),
          ),
          const SizedBox(height: AppSizes.lg),

          // Total card
          Card(
            color: colorScheme.primaryContainer.withValues(alpha: 0.15),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.xl),
              child: Column(
                children: [
                  const Text(
                    'Total del mes',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    _currencyFormat.format(summary.totalAmount),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    '${summary.expenseCount} gastos',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.xl),

          // Member balances
          if (summary.memberBalances.isNotEmpty) ...[
            Text(
              'Balances',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: summary.memberBalances.asMap().entries.map((entry) {
                    final index = entry.key;
                    final balance = entry.value;
                    final isLast = index == summary.memberBalances.length - 1;

                    return Column(
                      children: [
                        _BalanceRow(
                          balance: balance,
                          currencyFormat: _currencyFormat,
                        ),
                        if (!isLast) const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
          ],

          // Suggested settlements
          if (summary.settlements.isNotEmpty) ...[
            Text(
              'Sugerencias de pago',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: summary.settlements.asMap().entries.map((entry) {
                    final index = entry.key;
                    final settlement = entry.value;
                    final isLast = index == summary.settlements.length - 1;

                    return Column(
                      children: [
                        _SettlementRow(
                          settlement: settlement,
                          currencyFormat: _currencyFormat,
                        ),
                        if (!isLast) const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
          ],

          // Category breakdown
          if (summary.byCategory.isNotEmpty) ...[
            Text(
              'Por categoría',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: summary.byCategory.asMap().entries.map((entry) {
                    final index = entry.key;
                    final category = entry.value;
                    final isLast = index == summary.byCategory.length - 1;
                    final percentage =
                        (category.total / summary.totalAmount * 100)
                            .toStringAsFixed(1);

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSizes.sm),
                          child: Row(
                            children: [
                              if (category.icon != null) ...[
                                Text(
                                  category.icon!,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: AppSizes.md),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${category.count} gastos · $percentage%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                _currencyFormat.format(category.total),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isLast) const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
          ],

          // Pending expenses section
          if (pendingExpenses.isNotEmpty) ...[
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Text(
                  'Pendientes (${pendingExpenses.length})',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            Card(
              child: Column(
                children: pendingExpenses.asMap().entries.map((entry) {
                  final index = entry.key;
                  final expense = entry.value;
                  final isLast = index == pendingExpenses.length - 1;
                  return Column(
                    children: [
                      _ExpenseListTile(
                        expense: expense,
                        currencyFormat: _currencyFormat,
                      ),
                      if (!isLast) const Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
          ],

          // Settled expenses section
          if (settledExpenses.isNotEmpty) ...[
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Text(
                  'Saldados (${settledExpenses.length})',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            Card(
              child: Column(
                children: settledExpenses.asMap().entries.map((entry) {
                  final index = entry.key;
                  final expense = entry.value;
                  final isLast = index == settledExpenses.length - 1;
                  return Column(
                    children: [
                      _ExpenseListTile(
                        expense: expense,
                        currencyFormat: _currencyFormat,
                        isSettled: true,
                      ),
                      if (!isLast) const Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  final MemberBalanceModel balance;
  final NumberFormat currencyFormat;

  const _BalanceRow({
    required this.balance,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPositive = balance.balance >= 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.2),
            child: Text(
              balance.name.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  balance.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Pagó: ${currencyFormat.format(balance.paid)} · Debe: ${currencyFormat.format(balance.owes)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isPositive
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${isPositive ? '+' : ''}${currencyFormat.format(balance.balance)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isPositive ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettlementRow extends StatelessWidget {
  final SettlementModel settlement;
  final NumberFormat currencyFormat;

  const _SettlementRow({
    required this.settlement,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.red.withValues(alpha: 0.2),
            child: Text(
              settlement.from.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  settlement.from.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    const Icon(Icons.arrow_forward, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      settlement.to.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              final colorScheme = Theme.of(context).colorScheme;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  currencyFormat.format(settlement.amount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ExpenseListTile extends StatelessWidget {
  final ExpenseModel expense;
  final NumberFormat currencyFormat;
  final bool isSettled;

  const _ExpenseListTile({
    required this.expense,
    required this.currencyFormat,
    this.isSettled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('d MMM', 'es');

    return ListTile(
      leading: expense.category?.icon != null
          ? CircleAvatar(
              backgroundColor: isSettled
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              child: Text(
                expense.category!.icon!,
                style: const TextStyle(fontSize: 18),
              ),
            )
          : CircleAvatar(
              backgroundColor: isSettled
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              child: Icon(
                Icons.receipt_outlined,
                color: isSettled ? Colors.green : Colors.orange,
                size: 20,
              ),
            ),
      title: Text(
        expense.description,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isSettled ? colorScheme.onSurfaceVariant : null,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${dateFormat.format(expense.date)} · ${expense.paidBy.name}',
        style: TextStyle(
          fontSize: 12,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Text(
        currencyFormat.format(expense.amount),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSettled ? Colors.green : colorScheme.primary,
        ),
      ),
    );
  }
}

/// Color + emoji assigned to each member. The dot color is used in the UI; the
/// emoji is used in the copied plain-text breakdown so colors survive copy.
const List<({Color color, String emoji})> _kMemberPalette = [
  (color: Color(0xFF3B82F6), emoji: '🔵'), // blue
  (color: Color(0xFFF97316), emoji: '🟠'), // orange
  (color: Color(0xFF22C55E), emoji: '🟢'), // green
  (color: Color(0xFF8B5CF6), emoji: '🟣'), // purple
  (color: Color(0xFFEF4444), emoji: '🔴'), // red
  (color: Color(0xFFEAB308), emoji: '🟡'), // yellow
];

/// Per-member running totals for the settlement breakdown.
class _MemberCalc {
  _MemberCalc({
    required this.userId,
    required this.name,
    required this.colorIndex,
  });

  final String userId;
  final String name;
  final int colorIndex;
  double paid = 0;
  double share = 0;

  double get balance => paid - share;
  ({Color color, String emoji}) get palette =>
      _kMemberPalette[colorIndex % _kMemberPalette.length];
}

/// Bottom sheet showing the itemized breakdown of a period: every expense
/// colored by who paid it, a member legend, the per-person calculations, and
/// buttons to copy the breakdown or settle the whole period.
class _SettlementBreakdownSheet extends StatelessWidget {
  const _SettlementBreakdownSheet({
    required this.monthLabel,
    required this.expenses,
    required this.currencyFormat,
    required this.onSettle,
  });

  final String monthLabel;
  final List<ExpenseModel> expenses;
  final NumberFormat currencyFormat;
  final VoidCallback onSettle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Build a stable member ordering by first appearance (payers first).
    final order = <String>[];
    final calcs = <String, _MemberCalc>{};
    void touch(String id, String name) {
      if (!calcs.containsKey(id)) {
        calcs[id] = _MemberCalc(
          userId: id,
          name: name,
          colorIndex: order.length,
        );
        order.add(id);
      }
    }

    for (final e in expenses) {
      touch(e.paidBy.id, e.paidBy.name);
      for (final s in e.splits) {
        touch(s.userId, s.user?.name ?? 'Usuario');
      }
    }

    var total = 0.0;
    for (final e in expenses) {
      total += e.amount;
      calcs[e.paidBy.id]?.paid += e.amount;
      for (final s in e.splits) {
        calcs[s.userId]?.share += s.amount;
      }
    }

    final members = order.map((id) => calcs[id]!).toList();
    final sortedExpenses = [...expenses]
      ..sort((a, b) => b.date.compareTo(a.date));
    final settlements = _computeSettlements(members);
    final copyText =
        _buildCopyText(sortedExpenses, calcs, members, total, settlements);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.lg,
                0,
                AppSizes.lg,
                AppSizes.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saldar $monthLabel',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${expenses.length} gastos pendientes · ${currencyFormat.format(total)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            if (expenses.isEmpty)
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.xl),
                    child: Text('No hay gastos pendientes en este periodo.'),
                  ),
                ),
              )
            else
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.all(AppSizes.lg),
                  children: [
                    // Member legend
                    _buildLegend(context, members),
                    const SizedBox(height: AppSizes.md),

                    // Itemized list colored by payer
                    ...sortedExpenses.map(
                      (e) => _buildExpenseRow(context, e, calcs),
                    ),

                    const SizedBox(height: AppSizes.sm),
                    const Divider(),
                    const SizedBox(height: AppSizes.sm),

                    // Per-member calculations
                    Text(
                      'Cálculos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSizes.sm),
                    ...members.map(
                      (m) => _buildMemberCalc(context, m, total),
                    ),

                    // Who owes whom
                    if (settlements.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.md),
                      Text(
                        'Para saldar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      ...settlements.map(
                        (s) => Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: AppSizes.xs),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('${s.from} le debe a ${s.to}'),
                              ),
                              Text(
                                currencyFormat.format(s.amount),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

            // Action buttons
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: copyText),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Copiado al portapapeles'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.copy),
                        label: const Text('Copiar'),
                      ),
                    ),
                    const SizedBox(width: AppSizes.md),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: expenses.isEmpty ? null : onSettle,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Saldar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context, List<_MemberCalc> members) {
    return Wrap(
      spacing: AppSizes.md,
      runSpacing: AppSizes.xs,
      children: members.map((m) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: m.palette.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSizes.xs),
            Text(m.name, style: const TextStyle(fontSize: 13)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildExpenseRow(
    BuildContext context,
    ExpenseModel expense,
    Map<String, _MemberCalc> calcs,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final color =
        calcs[expense.paidBy.id]?.palette.color ?? colorScheme.outline;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Text(
              expense.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            currencyFormat.format(expense.amount),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCalc(
    BuildContext context,
    _MemberCalc member,
    double total,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final pctPaid = total > 0 ? (member.paid / total * 100) : 0.0;
    final pctShare = total > 0 ? (member.share / total * 100) : 0.0;
    final balance = member.balance;
    final isPositive = balance >= 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: member.palette.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Pagó ${currencyFormat.format(member.paid)} (${pctPaid.toStringAsFixed(0)}%) · '
                  'le corresponde ${currencyFormat.format(member.share)} (${pctShare.toStringAsFixed(0)}%)',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            '${isPositive ? '+' : ''}${currencyFormat.format(balance)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  /// Greedy debtor/creditor matching over the full-period balances.
  List<({String from, String to, double amount})> _computeSettlements(
    List<_MemberCalc> members,
  ) {
    final debtors = members
        .where((m) => m.balance < -0.01)
        .map((m) => (name: m.name, amount: m.balance))
        .toList()
      ..sort((a, b) => a.amount.compareTo(b.amount));
    final creditors = members
        .where((m) => m.balance > 0.01)
        .map((m) => (name: m.name, amount: m.balance))
        .toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));

    final result = <({String from, String to, double amount})>[];
    var debts = debtors.map((d) => d.amount).toList();
    var credits = creditors.map((c) => c.amount).toList();

    var i = 0;
    var j = 0;
    while (i < debtors.length && j < creditors.length) {
      final amount = math.min(-debts[i], credits[j]);
      if (amount > 0.01) {
        result.add((
          from: debtors[i].name,
          to: creditors[j].name,
          amount: (amount * 100).round() / 100,
        ));
      }
      debts[i] += amount;
      credits[j] -= amount;
      if (debts[i].abs() < 0.01) i++;
      if (credits[j] < 0.01) j++;
    }

    return result;
  }

  String _buildCopyText(
    List<ExpenseModel> sortedExpenses,
    Map<String, _MemberCalc> calcs,
    List<_MemberCalc> members,
    double total,
    List<({String from, String to, double amount})> settlements,
  ) {
    final buf = StringBuffer();
    buf.writeln('Gastos $monthLabel');
    buf.writeln('');
    for (final e in sortedExpenses) {
      final emoji = calcs[e.paidBy.id]?.palette.emoji ?? '•';
      buf.writeln(
        '$emoji ${e.description} — ${currencyFormat.format(e.amount)} (${e.paidBy.name})',
      );
    }
    buf.writeln('');
    buf.writeln('Total: ${currencyFormat.format(total)}');
    buf.writeln('');
    for (final m in members) {
      final pctPaid = total > 0 ? (m.paid / total * 100) : 0.0;
      final pctShare = total > 0 ? (m.share / total * 100) : 0.0;
      buf.writeln(
        '${m.palette.emoji} ${m.name}: pagó ${currencyFormat.format(m.paid)} '
        '(${pctPaid.toStringAsFixed(0)}%) · le corresponde '
        '${currencyFormat.format(m.share)} (${pctShare.toStringAsFixed(0)}%)',
      );
    }
    if (settlements.isNotEmpty) {
      buf.writeln('');
      for (final s in settlements) {
        buf.writeln(
          '${s.from} le debe a ${s.to} ${currencyFormat.format(s.amount)}',
        );
      }
    }
    return buf.toString();
  }
}

/// Dialog for selecting only month and year
class _MonthYearPickerDialog extends StatefulWidget {
  final int initialYear;
  final int initialMonth;
  final int firstYear;
  final int lastYear;

  const _MonthYearPickerDialog({
    required this.initialYear,
    required this.initialMonth,
    required this.firstYear,
    required this.lastYear,
  });

  @override
  State<_MonthYearPickerDialog> createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<_MonthYearPickerDialog> {
  late int _selectedYear;
  late int _selectedMonth;

  final List<String> _monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialYear;
    _selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const Text('Seleccionar mes'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Year selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _selectedYear > widget.firstYear
                      ? () => setState(() => _selectedYear--)
                      : null,
                ),
                Text(
                  _selectedYear.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _selectedYear < widget.lastYear
                      ? () => setState(() => _selectedYear++)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
            // Month grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final month = index + 1;
                final isSelected = month == _selectedMonth;
                return InkWell(
                  onTap: () => setState(() => _selectedMonth = month),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Text(
                      _monthNames[index].substring(0, 3),
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? Colors.white
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, {
            'year': _selectedYear,
            'month': _selectedMonth,
          }),
          child: const Text('Seleccionar'),
        ),
      ],
    );
  }
}
