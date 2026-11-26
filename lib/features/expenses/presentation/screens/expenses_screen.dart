import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/core/theme/text_styles.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';
import 'package:nuestra_app/features/expenses/presentation/widgets/fixed_expense_suggestions.dart';
import 'package:nuestra_app/core/utils/money_format.dart';

/// Expenses screen - Expense tracking and splitting
class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  final _currencyFormat = const MoneyFormat();
  final _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(expensesProvider.notifier).loadExpensesIfNeeded();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  List<ExpenseModel> _filterExpenses(
    List<ExpenseModel> expenses,
    String? selectedCategoryId,
  ) {
    var filtered = expenses;

    // Filter by category if one is selected
    if (selectedCategoryId != null) {
      filtered =
          filtered.where((e) => e.category?.id == selectedCategoryId).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered =
          filtered.where((e) {
            return e.description.toLowerCase().contains(query) ||
                (e.category?.name.toLowerCase().contains(query) ?? false) ||
                e.paidBy.name.toLowerCase().contains(query);
          }).toList();
    }

    return filtered;
  }

  Future<void> _onRefresh() async {
    await ref.read(expensesProvider.notifier).loadExpenses();
  }

  void _showMonthPicker() async {
    final state = ref.read(expensesProvider);
    if (state is! ExpensesStateLoaded) return;

    final now = DateTime.now();
    int selectedYear = state.selectedYear;
    int selectedMonth = state.selectedMonth;

    final result = await showDialog<Map<String, int>>(
      context: context,
      builder:
          (dialogContext) => _MonthYearPickerDialog(
            initialYear: selectedYear,
            initialMonth: selectedMonth,
            firstYear: 2020,
            lastYear: now.year + 1,
          ),
    );

    if (result != null) {
      ref
          .read(expensesProvider.notifier)
          .setMonth(result['month']!, result['year']!);
    }
  }

  void _navigateToAddExpense() {
    context.push(AppRoutes.addExpense);
  }

  void _showCategoryOptions(ExpenseCategoryModel category) {
    showModalBottomSheet(
      context: context,
      builder:
          (sheetContext) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: Row(
                    children: [
                      if (category.icon != null)
                        Text(
                          category.icon!,
                          style: const TextStyle(fontSize: 24),
                        ),
                      const SizedBox(width: AppSizes.sm),
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Editar categoria'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showEditCategoryDialog(category);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                  ),
                  title: const Text(
                    'Eliminar categoria',
                    style: TextStyle(color: AppColors.error),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _confirmDeleteCategory(category);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showEditCategoryDialog(ExpenseCategoryModel category) {
    final nameController = TextEditingController(text: category.name);
    final iconController = TextEditingController(text: category.icon ?? '');

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Editar categoria'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                ),
                const SizedBox(height: AppSizes.md),
                TextField(
                  controller: iconController,
                  decoration: const InputDecoration(
                    labelText: 'Emoji (opcional)',
                    hintText: 'Ej: 🛒',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) return;

                  Navigator.pop(dialogContext);
                  final result = await ref
                      .read(expensesProvider.notifier)
                      .updateCategory(
                        id: category.id,
                        name: name,
                        icon:
                            iconController.text.trim().isEmpty
                                ? null
                                : iconController.text.trim(),
                      );

                  if (mounted && result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Categoria actualizada')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, AppSizes.buttonHeight),
                ),
                child: const Text('Guardar'),
              ),
            ],
          ),
    );
  }

  void _confirmDeleteCategory(ExpenseCategoryModel category) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Eliminar categoria'),
            content: Text(
              '¿Eliminar "${category.name}"? Los gastos de esta categoria quedaran sin categoria asignada.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  final success = await ref
                      .read(expensesProvider.notifier)
                      .deleteCategory(category.id);

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success ? 'Categoria eliminada' : 'Error al eliminar',
                        ),
                        backgroundColor: success ? null : AppColors.error,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  minimumSize: const Size(0, AppSizes.buttonHeight),
                ),
                child: const Text('Eliminar'),
              ),
            ],
          ),
    );
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    final iconController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Nueva categoria'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                ),
                const SizedBox(height: AppSizes.md),
                TextField(
                  controller: iconController,
                  decoration: const InputDecoration(
                    labelText: 'Emoji (opcional)',
                    hintText: 'Ej: 🛒',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) return;

                  Navigator.pop(dialogContext);
                  final result = await ref
                      .read(expensesProvider.notifier)
                      .createCategory(
                        name: name,
                        icon:
                            iconController.text.trim().isEmpty
                                ? null
                                : iconController.text.trim(),
                      );

                  if (mounted && result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Categoria creada')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, AppSizes.buttonHeight),
                ),
                child: const Text('Crear'),
              ),
            ],
          ),
    );
  }

  void _navigateToExpenseDetail(ExpenseModel expense) {
    context.push(AppRoutes.expenseDetail(expense.id));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expensesProvider);

    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  cursorColor: Theme.of(context).colorScheme.onSurface,
                  decoration: InputDecoration(
                    hintText: 'Buscar gastos...',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                )
                : const Text(AppStrings.expenses),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            tooltip: _isSearching ? 'Cerrar busqueda' : 'Buscar',
            onPressed: _toggleSearch,
          ),
          if (!_isSearching)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Opciones',
              onSelected: (route) => context.push(route),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: AppRoutes.expenseSummary,
                  child: ListTile(
                    leading: Icon(Icons.bar_chart_outlined),
                    title: Text('Resumen mensual'),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const PopupMenuItem(
                  value: AppRoutes.expenseTrends,
                  child: ListTile(
                    leading: Icon(Icons.trending_up),
                    title: Text('Tendencias'),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const PopupMenuItem(
                  value: AppRoutes.recurringExpenses,
                  child: ListTile(
                    leading: Icon(Icons.repeat),
                    title: Text('Gastos recurrentes'),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const PopupMenuItem(
                  value: AppRoutes.budgetSetup,
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text('Presupuestos'),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
        ],
      ),
      body: switch (state) {
        ExpensesStateInitial() => const Center(
          child: Text('Cargando gastos...'),
        ),
        ExpensesStateLoading() => const Center(
          child: CircularProgressIndicator(),
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
            expenses, // All expenses for category counts
            _filterExpenses(
              expenses,
              selectedCategoryId,
            ), // Filtered for display
            selectedMonth,
            selectedYear,
            selectedCategoryId,
          ),
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddExpense,
        icon: const Icon(Icons.add),
        label: const Text('Gasto'),
      ),
    );
  }

  Widget _buildContent(
    List<ExpenseCategoryModel> categories,
    List<ExpenseModel> allExpenses, // For category counts
    List<ExpenseModel> filteredExpenses, // For display
    int selectedMonth,
    int selectedYear,
    String? selectedCategoryId,
  ) {
    final monthName = DateFormat.MMMM(
      'es',
    ).format(DateTime(selectedYear, selectedMonth));

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        children: [
          // Month selector and total
          _buildHeader(
            monthName,
            selectedYear,
            filteredExpenses,
            isFiltered: selectedCategoryId != null,
          ),
          // Fixed expenses from previous months not loaded yet this month
          FixedExpenseSuggestionsBanner(
            month: selectedMonth,
            year: selectedYear,
          ),
          // Category filter chips - use allExpenses for counts
          if (categories.isNotEmpty)
            _buildCategoryChips(categories, allExpenses, selectedCategoryId),
          // Expenses list - use filtered expenses
          Expanded(
            child:
                filteredExpenses.isEmpty
                    ? _buildEmptyState()
                    : _buildExpensesList(filteredExpenses),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    String monthName,
    int year,
    List<ExpenseModel> expenses, {
    required bool isFiltered,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final total = expenses.fold(0.0, (sum, e) => sum + e.amount);

    // Who paid how much this month, biggest first
    final byPayer = <String, double>{};
    for (final e in expenses) {
      byPayer[e.paidBy.name] = (byPayer[e.paidBy.name] ?? 0) + e.amount;
    }
    final payers = byPayer.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.md,
        0,
        AppSizes.md,
        AppSizes.sm,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month selector
          Material(
            color: colorScheme.surfaceContainerLow,
            shape: StadiumBorder(
              side: BorderSide(color: colorScheme.outlineVariant),
            ),
            child: InkWell(
              onTap: _showMonthPicker,
              customBorder: const StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 6, 8, 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${monthName.capitalize()} $year',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            isFiltered ? 'Total de la categoría' : 'Total del mes',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          _BigAmount(amount: total, size: 38, color: colorScheme.onSurface),
          if (payers.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                payers
                    .map((p) => '${p.key} ${_currencyFormat.format(p.value)}')
                    .join(' · '),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
        ],
        ),
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
                ref
                    .read(expensesProvider.notifier)
                    .setCategoryFilter(null);
              },
            ),
            const SizedBox(width: AppSizes.sm),
            // Category chips
            ...categories.map((category) {
              final count =
                  expenses.where((e) => e.category?.id == category.id).length;
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: _CategoryChip(
                  label: category.name,
                  icon: category.icon,
                  count: count,
                  isSelected: selectedCategoryId == category.id,
                  onTap: () {
                    ref
                        .read(expensesProvider.notifier)
                        .setCategoryFilter(category.id);
                  },
                  onLongPress: () => _showCategoryOptions(category),
                ),
              );
            }),
            // Add category button
            ActionChip(
              avatar: const Icon(Icons.add, size: 18),
              label: const Text('Nueva'),
              onPressed: _showAddCategoryDialog,
            ),
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
      // Bottom room so the "+ Gasto" button never covers the last amount
      padding: const EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, 96),
      itemCount: groupedExpenses.length,
      itemBuilder: (context, index) {
        final dateKey = groupedExpenses.keys.elementAt(index);
        final dayExpenses = groupedExpenses[dateKey]!;
        final dayTotal = dayExpenses.fold(0.0, (sum, e) => sum + e.amount);

        return Column(
          key: ValueKey(dateKey),
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
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Expenses for this date, in one card
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (var i = 0; i < dayExpenses.length; i++) ...[
                    if (i > 0)
                      const Divider(indent: AppSizes.md, endIndent: AppSizes.md),
                    _ExpenseItemTile(
                      expense: dayExpenses[i],
                      currencyFormat: _currencyFormat,
                      onTap: () => _navigateToExpenseDetail(dayExpenses[i]),
                    ),
                  ],
                ],
              ),
            ),
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
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
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
  final VoidCallback? onLongPress;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.count,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onLongPress: onLongPress,
      child: FilterChip(
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
              Text(
                '$count',
                style: TextStyle(
                  color: (isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurfaceVariant)
                      .withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
        selected: isSelected,
        onSelected: (_) => onTap(),
        side: isSelected
            ? BorderSide.none
            : BorderSide(color: colorScheme.outlineVariant),
        labelStyle: TextStyle(
          color: isSelected
              ? colorScheme.onPrimaryContainer
              : colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
        showCheckmark: false,
      ),
    );
  }
}

class _ExpenseItemTile extends StatelessWidget {
  final ExpenseModel expense;
  final MoneyFormat currencyFormat;
  final VoidCallback onTap;

  const _ExpenseItemTile({
    required this.expense,
    required this.currencyFormat,
    required this.onTap,
  });

  static final _installmentSuffix = RegExp(r'\s*\(cuota (\d+)/(\d+)\)\s*$');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final settled = expense.allSettled;

    // "Heladera (cuota 2/6)" shows as "Heladera" + a "2/6" tag
    final match = _installmentSuffix.firstMatch(expense.description);
    final description = match != null
        ? expense.description.substring(0, match.start)
        : expense.description;
    final installment = expense.installmentNumber != null &&
            expense.installmentCount != null
        ? '${expense.installmentNumber}/${expense.installmentCount}'
        : match != null
            ? '${match[1]}/${match[2]}'
            : null;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: 12,
        ),
        child: Row(
          children: [
            // Category emoji on a sand tile
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              alignment: Alignment.center,
              child: Text(
                expense.category?.icon ?? '💰',
                style: const TextStyle(fontSize: 19),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          description,
                          style: textTheme.titleSmall?.copyWith(
                            color: settled
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (installment != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'cuota $installment',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.memberColor(expense.paidBy.id),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          expense.paidBy.name,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currencyFormat.format(expense.amount),
                  style: AppTextStyles.amount(
                    color: settled
                        ? colorScheme.onSurfaceVariant
                        : colorScheme.onSurface,
                  ),
                ),
                if (settled)
                  Text(
                    '✓ saldado',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.success,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Month total and other big amounts: "$" and cents smaller and muted,
/// Fraunces with tabular figures.
class _BigAmount extends StatelessWidget {
  final double amount;
  final double size;
  final Color color;

  const _BigAmount({
    required this.amount,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.outline;
    final whole = NumberFormat.decimalPattern('es_AR').format(amount.truncate());
    final cents = ((amount - amount.truncate()) * 100).round();
    final big = AppTextStyles.bigAmount(size: size, color: color);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '\$ ',
            style: big.copyWith(fontSize: size * 0.55, color: muted),
          ),
          TextSpan(text: whole, style: big),
          if (cents > 0)
            TextSpan(
              text: ',${cents.toString().padLeft(2, '0')}',
              style: big.copyWith(fontSize: size * 0.5, color: muted),
            ),
        ],
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
    _selectedYear = widget.initialYear;
    _selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const Text('Seleccionar mes'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Year selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed:
                      _selectedYear > widget.firstYear
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
                  onPressed:
                      _selectedYear < widget.lastYear
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
                      color:
                          isSelected
                              ? colorScheme.primary
                              : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Text(
                      _monthNames[index].substring(0, 3),
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected ? Colors.white : colorScheme.onSurface,
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
          onPressed:
              () => Navigator.pop(context, {
                'year': _selectedYear,
                'month': _selectedMonth,
              }),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, AppSizes.buttonHeight),
          ),
          child: const Text('Seleccionar'),
        ),
      ],
    );
  }
}
