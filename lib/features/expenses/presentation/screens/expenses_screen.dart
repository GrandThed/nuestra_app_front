import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';

/// Expenses screen - Expense tracking and splitting
class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_AR', symbol: '\$');

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(expensesNotifierProvider.notifier).loadExpensesIfNeeded();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(expensesNotifierProvider.notifier).loadExpenses();
  }

  void _showMonthPicker() async {
    final state = ref.read(expensesNotifierProvider);
    if (state is! ExpensesStateLoaded) return;

    final now = DateTime.now();
    final selectedDate = DateTime(state.selectedYear, state.selectedMonth);

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1, 12),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      ref.read(expensesNotifierProvider.notifier).setMonth(
            picked.month,
            picked.year,
          );
    }
  }

  void _navigateToAddExpense() {
    context.push(AppRoutes.addExpense);
  }

  void _navigateToSummary() {
    context.push(AppRoutes.expenseSummary);
  }

  void _navigateToExpenseDetail(ExpenseModel expense) {
    context.push(AppRoutes.expenseDetail(expense.id));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expensesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.expenses),
        backgroundColor: AppColors.expenses,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_outlined),
            tooltip: 'Ver resumen',
            onPressed: _navigateToSummary,
          ),
        ],
      ),
      body: switch (state) {
        ExpensesStateInitial() => const Center(
            child: Text('Cargando gastos...'),
          ),
        ExpensesStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.expenses),
          ),
        ExpensesStateError(:final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                const SizedBox(height: 16),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onRefresh,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ExpensesStateLoaded(
          :final categories,
          :final expenses,
          :final selectedMonth,
          :final selectedYear,
          :final selectedCategoryId,
        ) =>
          _buildContent(
            categories,
            expenses,
            selectedMonth,
            selectedYear,
            selectedCategoryId,
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddExpense,
        backgroundColor: AppColors.expenses,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildContent(
    List<ExpenseCategoryModel> categories,
    List<ExpenseModel> expenses,
    int selectedMonth,
    int selectedYear,
    String? selectedCategoryId,
  ) {
    final total = expenses.fold(0.0, (sum, e) => sum + e.amount);
    final monthName = DateFormat.MMMM('es').format(
      DateTime(selectedYear, selectedMonth),
    );

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.expenses,
      child: Column(
        children: [
          // Month selector and total
          _buildHeader(monthName, selectedYear, total),
          // Category filter chips
          if (categories.isNotEmpty)
            _buildCategoryChips(categories, expenses, selectedCategoryId),
          // Expenses list
          Expanded(
            child: expenses.isEmpty
                ? _buildEmptyState()
                : _buildExpensesList(expenses),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String monthName, int year, double total) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      color: AppColors.expenses.withValues(alpha: 0.1),
      child: Row(
        children: [
          // Month selector
          InkWell(
            onTap: _showMonthPicker,
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.sm,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                border: Border.all(color: AppColors.expenses.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today, size: 18, color: AppColors.expenses),
                  const SizedBox(width: AppSizes.sm),
                  Text(
                    '${monthName.capitalize()} $year',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.expenses,
                    ),
                  ),
                  const SizedBox(width: AppSizes.xs),
                  const Icon(Icons.arrow_drop_down, color: AppColors.expenses),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Total
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                _currencyFormat.format(total),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.expenses,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(
    List<ExpenseCategoryModel> categories,
    List<ExpenseModel> expenses,
    String? selectedCategoryId,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      color: colorScheme.surface,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Row(
          children: [
            // "All" chip
            _CategoryChip(
              label: 'Todos',
              icon: null,
              count: expenses.length,
              isSelected: selectedCategoryId == null,
              onTap: () {
                ref.read(expensesNotifierProvider.notifier).setCategoryFilter(null);
              },
            ),
            const SizedBox(width: AppSizes.sm),
            // Category chips
            ...categories.map((category) {
              final count = expenses.where((e) => e.category?.id == category.id).length;
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: _CategoryChip(
                  label: category.name,
                  icon: category.icon,
                  count: count,
                  isSelected: selectedCategoryId == category.id,
                  onTap: () {
                    ref.read(expensesNotifierProvider.notifier).setCategoryFilter(category.id);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesList(List<ExpenseModel> expenses) {
    // Sort by date descending
    final sortedExpenses = List<ExpenseModel>.from(expenses)
      ..sort((a, b) => b.date.compareTo(a.date));

    // Group by date
    final groupedExpenses = <String, List<ExpenseModel>>{};
    final dateFormat = DateFormat('EEEE, d MMM', 'es');

    for (final expense in sortedExpenses) {
      final dateKey = dateFormat.format(expense.date);
      groupedExpenses.putIfAbsent(dateKey, () => []).add(expense);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.md),
      itemCount: groupedExpenses.length,
      itemBuilder: (context, index) {
        final dateKey = groupedExpenses.keys.elementAt(index);
        final dayExpenses = groupedExpenses[dateKey]!;
        final dayTotal = dayExpenses.fold(0.0, (sum, e) => sum + e.amount);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
              child: Row(
                children: [
                  Text(
                    dateKey.capitalize(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _currencyFormat.format(dayTotal),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.expenses.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Expenses for this date
            ...dayExpenses.map((expense) => _ExpenseItemTile(
                  expense: expense,
                  currencyFormat: _currencyFormat,
                  onTap: () => _navigateToExpenseDetail(expense),
                )),
            const SizedBox(height: AppSizes.sm),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 80,
            color: AppColors.expenses.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.emptyExpenses,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Registra tu primer gasto',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _navigateToAddExpense,
            icon: const Icon(Icons.add),
            label: const Text('Agregar gasto'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expenses,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final String? icon;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Text(icon!, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 4),
          ],
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.surface : AppColors.expenses,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.expenses : colorScheme.surface,
                ),
              ),
            ),
          ],
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.expenses,
      backgroundColor: colorScheme.surfaceContainerHighest,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.surface : colorScheme.onSurface,
      ),
      showCheckmark: false,
    );
  }
}

class _ExpenseItemTile extends StatelessWidget {
  final ExpenseModel expense;
  final NumberFormat currencyFormat;
  final VoidCallback onTap;

  const _ExpenseItemTile({
    required this.expense,
    required this.currencyFormat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              // Category icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.expenses.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                alignment: Alignment.center,
                child: Text(
                  expense.category?.icon ?? '💰',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              // Description and category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (expense.category != null) ...[
                          Text(
                            expense.category!.name,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Text(' • ', style: TextStyle(fontSize: 12)),
                        ],
                        Text(
                          'Pagado por ${expense.paidBy.name}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Amount and status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currencyFormat.format(expense.amount),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.expenses,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: expense.allSettled
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      expense.allSettled ? 'Saldado' : 'Pendiente',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: expense.allSettled ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
