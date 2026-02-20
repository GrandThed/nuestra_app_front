import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';

/// Screen for viewing expense trends over multiple months
class ExpenseTrendsScreen extends ConsumerStatefulWidget {
  const ExpenseTrendsScreen({super.key});

  @override
  ConsumerState<ExpenseTrendsScreen> createState() =>
      _ExpenseTrendsScreenState();
}

class _ExpenseTrendsScreenState extends ConsumerState<ExpenseTrendsScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_AR', symbol: '\$');

  final List<String> _monthNames = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic',
  ];

  // Category colors for visual bars
  static const List<Color> _categoryColors = [
    Color(0xFF22C55E), // green
    Color(0xFF3B82F6), // blue
    Color(0xFFF59E0B), // amber
    Color(0xFFEF4444), // red
    Color(0xFF8B5CF6), // purple
    Color(0xFFEC4899), // pink
    Color(0xFF14B8A6), // teal
    Color(0xFFF97316), // orange
    Color(0xFF6366F1), // indigo
    Color(0xFF84CC16), // lime
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(expenseTrendsNotifierProvider.notifier).loadIfNeeded();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(expenseTrendsNotifierProvider.notifier).load();
  }

  Color _colorForCategory(int index) {
    return _categoryColors[index % _categoryColors.length];
  }

  String _monthLabel(int month, int year) {
    return '${_monthNames[month - 1]} $year';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseTrendsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tendencias de gastos'),
        backgroundColor: AppColors.expensesDark,
        foregroundColor: Colors.white,
      ),
      body: switch (state) {
        ExpenseTrendsStateInitial() => const Center(
            child: Text('Cargando tendencias...'),
          ),
        ExpenseTrendsStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.expenses),
          ),
        ExpenseTrendsStateError(:final message) => Center(
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
        ExpenseTrendsStateLoaded(:final trends) => _buildContent(trends),
      },
    );
  }

  Widget _buildContent(List<ExpenseTrendModel> trends) {
    if (trends.isEmpty) {
      return _buildEmptyState();
    }

    // Find max total for scaling bars
    final maxTotal = trends.fold(
      0.0,
      (max, t) => t.total > max ? t.total : max,
    );

    // Collect all unique category names across all months for the legend
    final allCategories = <String>{};
    for (final trend in trends) {
      for (final cat in trend.byCategory) {
        allCategories.add(cat.name);
      }
    }
    final categoryList = allCategories.toList();

    // Calculate month-over-month changes
    final monthChanges = <int, double>{};
    for (int i = 1; i < trends.length; i++) {
      final prev = trends[i - 1].total;
      if (prev > 0) {
        monthChanges[i] = ((trends[i].total - prev) / prev) * 100;
      }
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.expenses,
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          // Category legend
          if (categoryList.isNotEmpty) ...[
            _buildCategoryLegend(categoryList),
            const SizedBox(height: AppSizes.md),
          ],

          // Month-by-month cards (most recent first)
          ...List.generate(trends.length, (index) {
            final reversedIndex = trends.length - 1 - index;
            final trend = trends[reversedIndex];
            final change = monthChanges[reversedIndex];

            return _TrendMonthCard(
              trend: trend,
              monthLabel: _monthLabel(trend.month, trend.year),
              currencyFormat: _currencyFormat,
              maxTotal: maxTotal,
              monthChange: change,
              categoryColorResolver: _colorForCategory,
              categoryList: categoryList,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryLegend(List<String> categories) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorias',
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Wrap(
              spacing: AppSizes.md,
              runSpacing: AppSizes.xs,
              children: List.generate(categories.length, (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _colorForCategory(index),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: AppSizes.xs),
                    Text(
                      categories[index],
                      style: const TextStyle(fontSize: AppSizes.fontXs),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.trending_up,
            size: 80,
            color: AppColors.expenses.withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            'Sin datos de tendencias',
            style: TextStyle(
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            'Registra gastos durante varios meses para ver las tendencias',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Card for displaying a single month's trend data
class _TrendMonthCard extends StatelessWidget {
  final ExpenseTrendModel trend;
  final String monthLabel;
  final NumberFormat currencyFormat;
  final double maxTotal;
  final double? monthChange;
  final Color Function(int index) categoryColorResolver;
  final List<String> categoryList;

  const _TrendMonthCard({
    required this.trend,
    required this.monthLabel,
    required this.currencyFormat,
    required this.maxTotal,
    required this.monthChange,
    required this.categoryColorResolver,
    required this.categoryList,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month header with total and change
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  monthLabel,
                  style: const TextStyle(
                    fontSize: AppSizes.fontMd,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      currencyFormat.format(trend.total),
                      style: const TextStyle(
                        fontSize: AppSizes.fontMd,
                        fontWeight: FontWeight.bold,
                        color: AppColors.expenses,
                      ),
                    ),
                    if (monthChange != null) ...[
                      const SizedBox(width: AppSizes.sm),
                      _buildChangeIndicator(monthChange!),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sm),

            // Stacked bar representing total proportional to max
            _buildTotalBar(colorScheme),
            const SizedBox(height: AppSizes.sm),

            // Category breakdown
            if (trend.byCategory.isNotEmpty) ...[
              ...trend.byCategory.map((cat) {
                final categoryIndex = categoryList.indexOf(cat.name);
                final color = categoryColorResolver(
                  categoryIndex >= 0 ? categoryIndex : 0,
                );
                return _buildCategoryRow(cat, color, colorScheme);
              }),
            ] else
              Text(
                'Sin desglose por categoria',
                style: TextStyle(
                  fontSize: AppSizes.fontXs,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangeIndicator(double change) {
    final isPositive = change > 0;
    final color = isPositive ? AppColors.error : AppColors.success;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            '${change.abs().toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBar(ColorScheme colorScheme) {
    final barFraction = maxTotal > 0 ? (trend.total / maxTotal) : 0.0;

    if (trend.byCategory.isEmpty) {
      // Single color bar when no category breakdown
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
        child: Container(
          height: 16,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSizes.radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: barFraction.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.expenses,
                borderRadius: BorderRadius.circular(AppSizes.radiusXs),
              ),
            ),
          ),
        ),
      );
    }

    // Stacked bar with category colors
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusXs),
      child: Container(
        height: 16,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.radiusXs),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: barFraction.clamp(0.0, 1.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 0 || trend.total <= 0) {
                return const SizedBox.shrink();
              }

              return Row(
                children: trend.byCategory.map((cat) {
                  final fraction = cat.total / trend.total;
                  final categoryIndex = categoryList.indexOf(cat.name);
                  final color = categoryColorResolver(
                    categoryIndex >= 0 ? categoryIndex : 0,
                  );

                  return Expanded(
                    flex: (fraction * 1000).round().clamp(1, 1000),
                    child: Container(color: color),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(
    ExpenseCategoryBreakdownModel cat,
    Color color,
    ColorScheme colorScheme,
  ) {
    final percentage =
        trend.total > 0 ? (cat.total / trend.total * 100) : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.xs),
      child: Row(
        children: [
          // Color indicator
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          // Category name with icon
          Expanded(
            child: Row(
              children: [
                if (cat.icon != null) ...[
                  Text(cat.icon!, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: AppSizes.xs),
                ],
                Flexible(
                  child: Text(
                    cat.name,
                    style: TextStyle(
                      fontSize: AppSizes.fontXs,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Amount and percentage
          Text(
            currencyFormat.format(cat.total),
            style: const TextStyle(
              fontSize: AppSizes.fontXs,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          SizedBox(
            width: 36,
            child: Text(
              '${percentage.toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 10,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
