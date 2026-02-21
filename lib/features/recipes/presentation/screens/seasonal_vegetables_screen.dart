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

_SeasonStatus _classifyVegetable(SeasonalVegetableModel veg, int currentWeek) {
  if (_isInSeason(veg.startWeek, veg.endWeek, currentWeek)) {
    return _SeasonStatus.inSeason;
  }
  if (_isComingSoon(veg.startWeek, currentWeek)) {
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

/// Checks whether the vegetable's season starts within the next 4 weeks.
bool _isComingSoon(int startWeek, int currentWeek) {
  for (int i = 1; i <= 4; i++) {
    final futureWeek = ((currentWeek - 1 + i) % 52) + 1;
    if (futureWeek == startWeek) {
      return true;
    }
  }
  return false;
}

class SeasonalVegetablesScreen extends ConsumerStatefulWidget {
  const SeasonalVegetablesScreen({super.key});

  @override
  ConsumerState<SeasonalVegetablesScreen> createState() =>
      _SeasonalVegetablesScreenState();
}

class _SeasonalVegetablesScreenState
    extends ConsumerState<SeasonalVegetablesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(seasonalVegetablesProvider.notifier)
          .loadVegetablesIfNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seasonalVegetablesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verduras de temporada'),
        backgroundColor: AppColors.recipes,
        foregroundColor: Colors.white,
      ),
      body: switch (state) {
        SeasonalVegetablesStateInitial() => const Center(
            child: Text('Cargando verduras de temporada...'),
          ),
        SeasonalVegetablesStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.recipes),
          ),
        SeasonalVegetablesStateError(:final message) => _buildErrorState(
            message,
          ),
        SeasonalVegetablesStateLoaded(:final vegetables) =>
          vegetables.isEmpty ? _buildEmptyState() : _buildContent(vegetables),
      },
    );
  }

  Widget _buildErrorState(String message) {
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
              onPressed: () => ref
                  .read(seasonalVegetablesProvider.notifier)
                  .loadVegetables(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.eco_outlined,
            size: 80,
            color: AppColors.recipes.withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppSizes.md),
          const Text(
            'No hay verduras de temporada',
            style: TextStyle(
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          const Text(
            'Agrega verduras desde el backend',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<SeasonalVegetableModel> vegetables) {
    final currentWeek = _weekOfYear(DateTime.now());

    final inSeason = <SeasonalVegetableModel>[];
    final comingSoon = <SeasonalVegetableModel>[];
    final outOfSeason = <SeasonalVegetableModel>[];

    for (final veg in vegetables) {
      switch (_classifyVegetable(veg, currentWeek)) {
        case _SeasonStatus.inSeason:
          inSeason.add(veg);
        case _SeasonStatus.comingSoon:
          comingSoon.add(veg);
        case _SeasonStatus.outOfSeason:
          outOfSeason.add(veg);
      }
    }

    return RefreshIndicator(
      color: AppColors.recipes,
      onRefresh: () => ref
          .read(seasonalVegetablesProvider.notifier)
          .loadVegetables(),
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: [
          // Current week indicator
          _buildWeekIndicator(currentWeek),
          const SizedBox(height: AppSizes.lg),

          // In season
          if (inSeason.isNotEmpty) ...[
            _buildSectionHeader(
              title: 'En temporada',
              color: AppColors.success,
              icon: Icons.check_circle,
            ),
            const SizedBox(height: AppSizes.sm),
            ...inSeason.map(
              (veg) => _VegetableCard(
                vegetable: veg,
                status: _SeasonStatus.inSeason,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],

          // Coming soon
          if (comingSoon.isNotEmpty) ...[
            _buildSectionHeader(
              title: 'Proximamente',
              color: AppColors.warning,
              icon: Icons.schedule,
            ),
            const SizedBox(height: AppSizes.sm),
            ...comingSoon.map(
              (veg) => _VegetableCard(
                vegetable: veg,
                status: _SeasonStatus.comingSoon,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],

          // Out of season
          if (outOfSeason.isNotEmpty) ...[
            _buildSectionHeader(
              title: 'Fuera de temporada',
              color: AppColors.textSecondary,
              icon: Icons.hourglass_empty,
            ),
            const SizedBox(height: AppSizes.sm),
            ...outOfSeason.map(
              (veg) => _VegetableCard(
                vegetable: veg,
                status: _SeasonStatus.outOfSeason,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWeekIndicator(int currentWeek) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMd,
        vertical: AppSizes.paddingSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.recipes.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color: AppColors.recipes.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today,
            size: AppSizes.iconSm,
            color: AppColors.recipes,
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            'Semana actual: $currentWeek',
            style: const TextStyle(
              fontSize: AppSizes.fontMd,
              fontWeight: FontWeight.w600,
              color: AppColors.recipes,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required Color color,
    required IconData icon,
  }) {
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

class _VegetableCard extends StatelessWidget {
  final SeasonalVegetableModel vegetable;
  final _SeasonStatus status;

  const _VegetableCard({
    required this.vegetable,
    required this.status,
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
                    vegetable.name,
                    style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    'Semana ${vegetable.startWeek} - Semana ${vegetable.endWeek}',
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
