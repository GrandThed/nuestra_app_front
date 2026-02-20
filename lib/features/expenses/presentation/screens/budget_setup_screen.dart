import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';

/// Screen for setting up and viewing monthly budgets per category
class BudgetSetupScreen extends ConsumerStatefulWidget {
  const BudgetSetupScreen({super.key});

  @override
  ConsumerState<BudgetSetupScreen> createState() => _BudgetSetupScreenState();
}

class _BudgetSetupScreenState extends ConsumerState<BudgetSetupScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_AR', symbol: '\$');
  late int _selectedMonth;
  late int _selectedYear;

  final List<String> _monthNames = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = now.month;
    _selectedYear = now.year;
    Future.microtask(() {
      ref
          .read(budgetNotifierProvider.notifier)
          .loadIfNeeded(_selectedMonth, _selectedYear);
    });
  }

  Future<void> _onRefresh() async {
    await ref
        .read(budgetNotifierProvider.notifier)
        .load(_selectedMonth, _selectedYear);
  }

  void _previousMonth() {
    setState(() {
      if (_selectedMonth == 1) {
        _selectedMonth = 12;
        _selectedYear--;
      } else {
        _selectedMonth--;
      }
    });
    ref
        .read(budgetNotifierProvider.notifier)
        .load(_selectedMonth, _selectedYear, forceLoading: true);
  }

  void _nextMonth() {
    setState(() {
      if (_selectedMonth == 12) {
        _selectedMonth = 1;
        _selectedYear++;
      } else {
        _selectedMonth++;
      }
    });
    ref
        .read(budgetNotifierProvider.notifier)
        .load(_selectedMonth, _selectedYear, forceLoading: true);
  }

  Color _budgetColor(double percentUsed) {
    if (percentUsed > 90) return AppColors.error;
    if (percentUsed > 75) return AppColors.warning;
    return AppColors.success;
  }

  void _showEditBudgetDialog(BudgetStatusModel budget) {
    final controller = TextEditingController(
      text: budget.budgetLimit > 0
          ? budget.budgetLimit.toStringAsFixed(0)
          : '',
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Presupuesto: ${budget.categoryName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Establecer limite mensual para ${_monthNames[_selectedMonth - 1]} $_selectedYear',
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                color: Theme.of(dialogContext).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSizes.md),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Limite mensual',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d+\.?\d{0,2}'),
                ),
              ],
              autofocus: true,
            ),
            if (budget.actualSpent > 0) ...[
              const SizedBox(height: AppSizes.sm),
              Text(
                'Gastado este mes: ${_currencyFormat.format(budget.actualSpent)}',
                style: TextStyle(
                  fontSize: AppSizes.fontXs,
                  color: Theme.of(dialogContext).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final text = controller.text.trim();
              if (text.isEmpty) return;

              final limit = double.tryParse(text);
              if (limit == null || limit <= 0) return;

              Navigator.pop(dialogContext);

              final result = await ref
                  .read(budgetNotifierProvider.notifier)
                  .createOrUpdate(
                    categoryId: budget.categoryId,
                    monthlyLimit: limit,
                    month: _selectedMonth,
                    year: _selectedYear,
                  );

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      result != null
                          ? 'Presupuesto actualizado'
                          : 'Error al actualizar presupuesto',
                    ),
                    backgroundColor: result != null ? null : AppColors.error,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expensesDark,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, AppSizes.buttonHeight),
            ),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(budgetNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuestos'),
        backgroundColor: AppColors.expensesDark,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Month/Year selector
          _buildMonthSelector(),
          // Budget content
          Expanded(
            child: switch (state) {
              BudgetStateInitial() => const Center(
                  child: Text('Cargando presupuestos...'),
                ),
              BudgetStateLoading() => const Center(
                  child: CircularProgressIndicator(color: AppColors.expenses),
                ),
              BudgetStateError(:final message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: AppColors.error),
                      const SizedBox(height: AppSizes.md),
                      Text(message, textAlign: TextAlign.center),
                      const SizedBox(height: AppSizes.md),
                      ElevatedButton(
                        onPressed: _onRefresh,
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              BudgetStateLoaded(:final budgets) => _buildContent(budgets),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      color: AppColors.expenses.withValues(alpha: 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _previousMonth,
            color: AppColors.expenses,
          ),
          Text(
            '${_monthNames[_selectedMonth - 1]} $_selectedYear',
            style: const TextStyle(
              fontSize: AppSizes.fontLg,
              fontWeight: FontWeight.bold,
              color: AppColors.expenses,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _nextMonth,
            color: AppColors.expenses,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<BudgetStatusModel> budgets) {
    if (budgets.isEmpty) {
      return _buildEmptyState();
    }

    // Calculate overall totals
    final totalBudget =
        budgets.fold(0.0, (sum, b) => sum + b.budgetLimit);
    final totalSpent =
        budgets.fold(0.0, (sum, b) => sum + b.actualSpent);
    final overallPercent =
        totalBudget > 0 ? (totalSpent / totalBudget * 100) : 0.0;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.expenses,
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          // Overall summary card
          _buildOverallSummary(totalBudget, totalSpent, overallPercent),
          const SizedBox(height: AppSizes.md),

          // Individual category budgets
          ...budgets.map(
            (budget) => _BudgetCategoryCard(
              budget: budget,
              currencyFormat: _currencyFormat,
              budgetColor: _budgetColor(budget.percentUsed),
              onTap: () => _showEditBudgetDialog(budget),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallSummary(
    double totalBudget,
    double totalSpent,
    double overallPercent,
  ) {
    final overallColor = _budgetColor(overallPercent);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resumen general',
                  style: TextStyle(
                    fontSize: AppSizes.fontLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.sm,
                    vertical: AppSizes.xs,
                  ),
                  decoration: BoxDecoration(
                    color: overallColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                  ),
                  child: Text(
                    '${overallPercent.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: AppSizes.fontSm,
                      fontWeight: FontWeight.bold,
                      color: overallColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusXs),
              child: LinearProgressIndicator(
                value: totalBudget > 0
                    ? (totalSpent / totalBudget).clamp(0.0, 1.0)
                    : 0.0,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                color: overallColor,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gastado: ${_currencyFormat.format(totalSpent)}',
                  style: TextStyle(
                    fontSize: AppSizes.fontSm,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Limite: ${_currencyFormat.format(totalBudget)}',
                  style: TextStyle(
                    fontSize: AppSizes.fontSm,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            if (totalBudget > totalSpent) ...[
              const SizedBox(height: AppSizes.xs),
              Text(
                'Disponible: ${_currencyFormat.format(totalBudget - totalSpent)}',
                style: const TextStyle(
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.success,
                ),
              ),
            ] else if (totalSpent > totalBudget && totalBudget > 0) ...[
              const SizedBox(height: AppSizes.xs),
              Text(
                'Excedido: ${_currencyFormat.format(totalSpent - totalBudget)}',
                style: const TextStyle(
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_outlined,
              size: 80,
              color: AppColors.expenses.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              'Sin presupuestos',
              style: TextStyle(
                fontSize: AppSizes.fontXl,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              'Crea categorias de gastos primero y luego podras establecer presupuestos mensuales para cada una',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Card widget for displaying budget status for a single category
class _BudgetCategoryCard extends StatelessWidget {
  final BudgetStatusModel budget;
  final NumberFormat currencyFormat;
  final Color budgetColor;
  final VoidCallback onTap;

  const _BudgetCategoryCard({
    required this.budget,
    required this.currencyFormat,
    required this.budgetColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final progressValue = budget.budgetLimit > 0
        ? (budget.actualSpent / budget.budgetLimit).clamp(0.0, 1.0)
        : 0.0;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category name and percentage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      budget.categoryName,
                      style: const TextStyle(
                        fontSize: AppSizes.fontMd,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: budgetColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                    ),
                    child: Text(
                      '${budget.percentUsed.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: AppSizes.fontXs,
                        fontWeight: FontWeight.bold,
                        color: budgetColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  color: budgetColor,
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              // Amount details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Spent
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gastado',
                        style: TextStyle(
                          fontSize: AppSizes.fontXs,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        currencyFormat.format(budget.actualSpent),
                        style: TextStyle(
                          fontSize: AppSizes.fontSm,
                          fontWeight: FontWeight.bold,
                          color: budgetColor,
                        ),
                      ),
                    ],
                  ),
                  // Limit
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Limite',
                        style: TextStyle(
                          fontSize: AppSizes.fontXs,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        currencyFormat.format(budget.budgetLimit),
                        style: const TextStyle(
                          fontSize: AppSizes.fontSm,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  // Remaining
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Restante',
                        style: TextStyle(
                          fontSize: AppSizes.fontXs,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        currencyFormat.format(budget.remaining),
                        style: TextStyle(
                          fontSize: AppSizes.fontSm,
                          fontWeight: FontWeight.bold,
                          color: budget.remaining >= 0
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Edit hint
              const SizedBox(height: AppSizes.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 14,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: AppSizes.xs),
                  Text(
                    'Tocar para editar',
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
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
