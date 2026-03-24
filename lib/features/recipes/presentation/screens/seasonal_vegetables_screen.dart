import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';

/// Returns the ISO week number (1-53) for the given [date].
int _weekOfYear(DateTime date) {
  // ISO 8601: Week 1 is the week containing the first Thursday of the year.
  final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays + 1;
  final weekday = date.weekday; // Monday=1 .. Sunday=7
  final weekNumber = ((dayOfYear - weekday + 10) / 7).floor();

  if (weekNumber < 1) {
    // Belongs to last week of previous year
    final dec31 = DateTime(date.year - 1, 12, 31);
    return _weekOfYear(dec31);
  }
  if (weekNumber > 52) {
    final jan1Next = DateTime(date.year + 1, 1, 1);
    if (jan1Next.weekday <= 4) {
      return 1;
    }
  }
  return weekNumber;
}

enum _SeasonStatus {
  inSeason,
  comingSoon,
  outOfSeason,
}

_SeasonStatus _classifyItem(SeasonalVegetableModel item, int currentWeek) {
  if (_isInSeason(item.startWeek, item.endWeek, currentWeek)) {
    return _SeasonStatus.inSeason;
  }
  if (_isComingSoon(item.startWeek, currentWeek)) {
    return _SeasonStatus.comingSoon;
  }
  return _SeasonStatus.outOfSeason;
}

/// Checks whether [currentWeek] falls within the [startWeek]-[endWeek] range,
/// handling wrap-around (e.g., startWeek=48, endWeek=8 means weeks 48..52,1..8).
bool _isInSeason(int startWeek, int endWeek, int currentWeek) {
  if (startWeek <= endWeek) {
    return currentWeek >= startWeek && currentWeek <= endWeek;
  }
  // Wraps around year boundary
  return currentWeek >= startWeek || currentWeek <= endWeek;
}

/// Checks whether the item's season starts within the next 4 weeks.
bool _isComingSoon(int startWeek, int currentWeek) {
  for (int i = 1; i <= 4; i++) {
    final futureWeek = ((currentWeek - 1 + i) % 52) + 1;
    if (futureWeek == startWeek) {
      return true;
    }
  }
  return false;
}

/// Returns the localized name based on device locale.
/// Falls back: nameEs -> namePt -> name (English)
String _localizedName(SeasonalVegetableModel item, Locale locale) {
  final lang = locale.languageCode;
  if (lang == 'es' && item.nameEs != null) return item.nameEs!;
  if (lang == 'pt' && item.namePt != null) return item.namePt!;
  // Default to Spanish if available, then English
  return item.nameEs ?? item.name;
}

class SeasonalVegetablesScreen extends ConsumerStatefulWidget {
  const SeasonalVegetablesScreen({super.key});

  @override
  ConsumerState<SeasonalVegetablesScreen> createState() =>
      _SeasonalVegetablesScreenState();
}

class _SeasonalVegetablesScreenState
    extends ConsumerState<SeasonalVegetablesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      ref
          .read(seasonalVegetablesProvider.notifier)
          .loadVegetablesIfNeeded();
      ref
          .read(seasonalFruitsProvider.notifier)
          .loadFruitsIfNeeded();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos de temporada'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Verduras', icon: Icon(Icons.eco)),
            Tab(text: 'Frutas', icon: Icon(Icons.apple)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _VegetablesTab(),
          _FruitsTab(),
        ],
      ),
    );
  }
}

class _VegetablesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(seasonalVegetablesProvider);

    return switch (state) {
      SeasonalVegetablesStateInitial() => const Center(
          child: Text('Cargando verduras de temporada...'),
        ),
      SeasonalVegetablesStateLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      SeasonalVegetablesStateError(:final message) => _ErrorView(
          message: message,
          onRetry: () => ref
              .read(seasonalVegetablesProvider.notifier)
              .loadVegetables(),
        ),
      SeasonalVegetablesStateLoaded(:final vegetables) =>
        vegetables.isEmpty
            ? _EmptyView(message: 'No hay verduras de temporada')
            : _ProduceList(
                items: vegetables,
                onRefresh: () => ref
                    .read(seasonalVegetablesProvider.notifier)
                    .loadVegetables(),
              ),
    };
  }
}

class _FruitsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(seasonalFruitsProvider);

    return switch (state) {
      SeasonalFruitsStateInitial() => const Center(
          child: Text('Cargando frutas de temporada...'),
        ),
      SeasonalFruitsStateLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      SeasonalFruitsStateError(:final message) => _ErrorView(
          message: message,
          onRetry: () => ref
              .read(seasonalFruitsProvider.notifier)
              .loadFruits(),
        ),
      SeasonalFruitsStateLoaded(:final fruits) =>
        fruits.isEmpty
            ? _EmptyView(message: 'No hay frutas de temporada')
            : _ProduceList(
                items: fruits,
                onRefresh: () => ref
                    .read(seasonalFruitsProvider.notifier)
                    .loadFruits(),
              ),
    };
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSizes.md),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final String message;

  const _EmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.eco_outlined,
            size: 80,
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant
                .withValues(alpha: 0.4),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            message,
            style: const TextStyle(
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProduceList extends StatelessWidget {
  final List<SeasonalVegetableModel> items;
  final Future<void> Function() onRefresh;

  const _ProduceList({required this.items, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final currentWeek = _weekOfYear(DateTime.now());
    final locale = Localizations.localeOf(context);

    final inSeason = <SeasonalVegetableModel>[];
    final comingSoon = <SeasonalVegetableModel>[];
    final outOfSeason = <SeasonalVegetableModel>[];

    for (final item in items) {
      switch (_classifyItem(item, currentWeek)) {
        case _SeasonStatus.inSeason:
          inSeason.add(item);
        case _SeasonStatus.comingSoon:
          comingSoon.add(item);
        case _SeasonStatus.outOfSeason:
          outOfSeason.add(item);
      }
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: [
          // Current week indicator
          _WeekIndicator(currentWeek: currentWeek),
          const SizedBox(height: AppSizes.lg),

          // In season
          if (inSeason.isNotEmpty) ...[
            _SectionHeader(
              title: 'En temporada',
              color: AppColors.success,
              icon: Icons.check_circle,
            ),
            const SizedBox(height: AppSizes.sm),
            ...inSeason.map(
              (item) => _ProduceCard(
                item: item,
                status: _SeasonStatus.inSeason,
                locale: locale,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],

          // Coming soon
          if (comingSoon.isNotEmpty) ...[
            _SectionHeader(
              title: 'Proximamente',
              color: AppColors.warning,
              icon: Icons.schedule,
            ),
            const SizedBox(height: AppSizes.sm),
            ...comingSoon.map(
              (item) => _ProduceCard(
                item: item,
                status: _SeasonStatus.comingSoon,
                locale: locale,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],

          // Out of season
          if (outOfSeason.isNotEmpty) ...[
            _SectionHeader(
              title: 'Fuera de temporada',
              color: AppColors.textSecondary,
              icon: Icons.hourglass_empty,
            ),
            const SizedBox(height: AppSizes.sm),
            ...outOfSeason.map(
              (item) => _ProduceCard(
                item: item,
                status: _SeasonStatus.outOfSeason,
                locale: locale,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _WeekIndicator extends StatelessWidget {
  final int currentWeek;

  const _WeekIndicator({required this.currentWeek});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMd,
        vertical: AppSizes.paddingSm,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: AppSizes.iconSm,
            color: colorScheme.primary,
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            'Semana actual: $currentWeek',
            style: TextStyle(
              fontSize: AppSizes.fontMd,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: AppSizes.iconSm, color: color),
        const SizedBox(width: AppSizes.sm),
        Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.fontLg,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _ProduceCard extends StatelessWidget {
  final SeasonalVegetableModel item;
  final _SeasonStatus status;
  final Locale locale;

  const _ProduceCard({
    required this.item,
    required this.status,
    required this.locale,
  });

  Color get _statusColor => switch (status) {
        _SeasonStatus.inSeason => AppColors.success,
        _SeasonStatus.comingSoon => AppColors.warning,
        _SeasonStatus.outOfSeason => AppColors.textSecondary,
      };

  IconData get _statusIcon => switch (status) {
        _SeasonStatus.inSeason => Icons.eco,
        _SeasonStatus.comingSoon => Icons.wb_sunny_outlined,
        _SeasonStatus.outOfSeason => Icons.ac_unit,
      };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Row(
          children: [
            // Status indicator
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Icon(
                _statusIcon,
                color: _statusColor,
                size: AppSizes.iconMd,
              ),
            ),
            const SizedBox(width: AppSizes.md),

            // Name and season range
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _localizedName(item, locale),
                    style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    'Semana ${item.startWeek} - Semana ${item.endWeek}',
                    style: const TextStyle(
                      fontSize: AppSizes.fontSm,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Colored dot indicator
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _statusColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
