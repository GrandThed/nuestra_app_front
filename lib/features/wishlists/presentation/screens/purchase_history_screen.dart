import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/wishlists/data/models/wishlist_model.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_notifier.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_state.dart';

class PurchaseHistoryScreen extends ConsumerStatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  ConsumerState<PurchaseHistoryScreen> createState() =>
      _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends ConsumerState<PurchaseHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final householdId = ref.read(currentHouseholdIdProvider);
      if (householdId != null) {
        ref
            .read(purchaseHistoryProvider.notifier)
            .loadIfNeeded(householdId);
      }
    });
  }

  /// Groups purchase history entries by month key (e.g. "2026-02")
  Map<String, List<WishlistPurchaseHistoryModel>> _groupByMonth(
    List<WishlistPurchaseHistoryModel> history,
  ) {
    final grouped = <String, List<WishlistPurchaseHistoryModel>>{};
    for (final item in history) {
      final key =
          '${item.purchasedAt.year}-${item.purchasedAt.month.toString().padLeft(2, '0')}';
      grouped.putIfAbsent(key, () => []).add(item);
    }

    // Sort keys descending (most recent month first)
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    return {for (final key in sortedKeys) key: grouped[key]!};
  }

  /// Calculates total spent for a list of purchases
  double _totalForMonth(List<WishlistPurchaseHistoryModel> items) {
    double total = 0;
    for (final item in items) {
      if (item.price != null) {
        total += item.price!;
      }
    }
    return total;
  }

  /// Formats a month key (e.g. "2026-02") into a display string
  String _formatMonthKey(String key) {
    final parts = key.split('-');
    if (parts.length != 2) return key;
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    if (year == null || month == null) return key;
    final date = DateTime(year, month);
    final formatted = DateFormat('MMMM yyyy', 'es').format(date);
    // Capitalize first letter
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(purchaseHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de compras'),
        backgroundColor: AppColors.wishlistsDark,
        foregroundColor: Colors.white,
      ),
      body: switch (state) {
        PurchaseHistoryStateInitial() => const Center(
            child: Text('Cargando historial...'),
          ),
        PurchaseHistoryStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.wishlists),
          ),
        PurchaseHistoryStateError(:final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: AppSizes.iconXl,
                  color: AppColors.error,
                ),
                const SizedBox(height: AppSizes.md),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: AppSizes.md),
                ElevatedButton(
                  onPressed: () {
                    final householdId = ref.read(currentHouseholdIdProvider);
                    if (householdId != null) {
                      ref
                          .read(purchaseHistoryProvider.notifier)
                          .load(householdId, forceLoading: true);
                    }
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        PurchaseHistoryStateLoaded(:final history) =>
          _buildLoadedContent(history),
      },
    );
  }

  Widget _buildLoadedContent(List<WishlistPurchaseHistoryModel> history) {
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: AppSizes.iconXl,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              'No hay historial de compras',
              style: TextStyle(
                fontSize: AppSizes.fontLg,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              'Las compras realizadas apareceran aqui.',
              style: TextStyle(
                fontSize: AppSizes.fontSm,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      );
    }

    final grouped = _groupByMonth(history);

    return RefreshIndicator(
      color: AppColors.wishlists,
      onRefresh: () async {
        final householdId = ref.read(currentHouseholdIdProvider);
        if (householdId != null) {
          await ref
              .read(purchaseHistoryProvider.notifier)
              .load(householdId);
        }
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        itemCount: grouped.length,
        itemBuilder: (context, index) {
          final monthKey = grouped.keys.elementAt(index);
          final items = grouped[monthKey]!;
          final total = _totalForMonth(items);

          return _MonthSection(
            monthLabel: _formatMonthKey(monthKey),
            total: total,
            items: items,
          );
        },
      ),
    );
  }
}

class _MonthSection extends StatelessWidget {
  final String monthLabel;
  final double total;
  final List<WishlistPurchaseHistoryModel> items;

  const _MonthSection({
    required this.monthLabel,
    required this.total,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currencyFormat = NumberFormat.currency(
      locale: 'es_AR',
      symbol: '\$',
      decimalDigits: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month header
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppSizes.sm,
            top: AppSizes.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  monthLabel,
                  style: TextStyle(
                    fontSize: AppSizes.fontLg,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              if (total > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.sm,
                    vertical: AppSizes.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.wishlists.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                  child: Text(
                    currencyFormat.format(total),
                    style: const TextStyle(
                      fontSize: AppSizes.fontSm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.wishlistsDark,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Purchase items
        ...items.map((item) => _PurchaseCard(purchase: item)),

        const SizedBox(height: AppSizes.sm),
      ],
    );
  }
}

class _PurchaseCard extends StatelessWidget {
  final WishlistPurchaseHistoryModel purchase;

  const _PurchaseCard({required this.purchase});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('d MMM yyyy', 'es');
    final currencyFormat = NumberFormat.currency(
      locale: 'es_AR',
      symbol: '\$',
      decimalDigits: 0,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.wishlists.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.wishlistsDark,
                size: AppSizes.iconMd,
              ),
            ),

            const SizedBox(width: AppSizes.md),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    purchase.name,
                    style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: AppSizes.iconXs,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.xs),
                      Text(
                        dateFormat.format(purchase.purchasedAt),
                        style: TextStyle(
                          fontSize: AppSizes.fontSm,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (purchase.purchasedBy != null) ...[
                        const SizedBox(width: AppSizes.md),
                        Icon(
                          Icons.person_outline,
                          size: AppSizes.iconXs,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSizes.xs),
                        Flexible(
                          child: Text(
                            purchase.purchasedBy!.name,
                            style: TextStyle(
                              fontSize: AppSizes.fontSm,
                              color: AppColors.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Price
            if (purchase.price != null) ...[
              const SizedBox(width: AppSizes.sm),
              Text(
                currencyFormat.format(purchase.price),
                style: const TextStyle(
                  fontSize: AppSizes.fontMd,
                  fontWeight: FontWeight.bold,
                  color: AppColors.wishlistsDark,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
