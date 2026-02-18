import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:intl/intl.dart';

/// Card showing expenses summary on the home dashboard
class ExpensesSummaryCard extends ConsumerWidget {
  const ExpensesSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyTotal = ref.watch(totalExpensesAmountProvider);
    final colorScheme = Theme.of(context).colorScheme;

    final currentMonth = DateFormat('MMMM', 'es').format(DateTime.now());

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => context.go(AppRoutes.expenses),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMd),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: AppColors.expenses.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColors.expenses,
                  size: AppSizes.iconMd,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gastos de $currentMonth',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      monthlyTotal > 0
                          ? '\$${NumberFormat('#,##0.00', 'es').format(monthlyTotal)}'
                          : 'Sin gastos registrados',
                      style: TextStyle(
                        color: monthlyTotal > 0
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                        fontSize: AppSizes.fontSm,
                        fontWeight:
                            monthlyTotal > 0 ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
