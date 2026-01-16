import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
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
      ref.read(expenseSummaryNotifierProvider.notifier).loadSummary(
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
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime(_selectedYear, _selectedMonth),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (result != null) {
      setState(() {
        _selectedMonth = result.month;
        _selectedYear = result.year;
      });
      ref.read(expenseSummaryNotifierProvider.notifier).loadSummary(
            month: _selectedMonth,
            year: _selectedYear,
            forceLoading: true,
          );
    }
  }

  Future<void> _settlePeriod() async {
    final fromDate = DateTime(_selectedYear, _selectedMonth, 1);
    final toDate = DateTime(_selectedYear, _selectedMonth + 1, 0);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saldar período'),
        content: Text(
          '¿Marcar todos los gastos de ${_getMonthName(_selectedMonth)} $_selectedYear como saldados?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Saldar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final result = await ref
          .read(expenseSummaryNotifierProvider.notifier)
          .settlePeriod(fromDate: fromDate, toDate: toDate);

      if (mounted && result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Se saldaron ${result.settledCount} divisiones en ${result.expensesAffected} gastos',
            ),
          ),
        );
        // Also refresh the main expenses list
        ref.read(expensesNotifierProvider.notifier).loadExpenses();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseSummaryNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de gastos'),
        backgroundColor: AppColors.expenses,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: 'Saldar período',
            onPressed: _settlePeriod,
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
                      .read(expenseSummaryNotifierProvider.notifier)
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
    return RefreshIndicator(
      onRefresh: () => ref
          .read(expenseSummaryNotifierProvider.notifier)
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
            color: AppColors.expenses.withValues(alpha: 0.1),
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
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.expenses,
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
            backgroundColor: AppColors.expenses.withValues(alpha: 0.2),
            child: Text(
              balance.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.expenses,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.expenses.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              currencyFormat.format(settlement.amount),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.expenses,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
