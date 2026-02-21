import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/activity/data/models/activity_model.dart';
import 'package:nuestra_app/features/activity/presentation/providers/activity_notifier.dart';
import 'package:nuestra_app/features/activity/presentation/providers/activity_state.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

/// Screen that displays the household activity feed
class ActivityFeedScreen extends ConsumerStatefulWidget {
  const ActivityFeedScreen({super.key});

  @override
  ConsumerState<ActivityFeedScreen> createState() => _ActivityFeedScreenState();
}

class _ActivityFeedScreenState extends ConsumerState<ActivityFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final householdId = ref.read(currentHouseholdIdProvider);
      if (householdId != null) {
        ref.read(activityFeedProvider.notifier).loadIfNeeded(householdId);
      }
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final householdId = ref.read(currentHouseholdIdProvider);
      if (householdId != null) {
        ref.read(activityFeedProvider.notifier).loadMore(householdId);
      }
    }
  }

  Future<void> _onRefresh() async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId != null) {
      await ref.read(activityFeedProvider.notifier).load(householdId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activityFeedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad del hogar'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
      ),
      body: switch (state) {
        ActivityFeedStateInitial() => const Center(
          child: Text('Cargando actividad...'),
        ),
        ActivityFeedStateLoading() => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        ActivityFeedStateError(:final message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: AppSizes.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              ElevatedButton(
                onPressed: _onRefresh,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        ActivityFeedStateLoaded(:final activities, :final hasMore) =>
          _buildContent(activities, hasMore),
      },
    );
  }

  Widget _buildContent(List<ActivityLogModel> activities, bool hasMore) {
    if (activities.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.primary,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
        itemCount: activities.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= activities.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSizes.lg),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }

          final activity = activities[index];
          return _ActivityItemCard(activity: activity);
        },
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
            Icons.history,
            size: 80,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            'Sin actividad reciente',
            style: TextStyle(
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            'La actividad del hogar aparecera aqui',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

/// Card widget for a single activity feed item
class _ActivityItemCard extends StatelessWidget {
  final ActivityLogModel activity;

  const _ActivityItemCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final entityInfo = _entityTypeInfo(activity.entityType);
    final actionVerb = _actionVerb(activity.action);
    final entityLabel = entityInfo.label;
    final metadataSummary = _buildMetadataSummary(activity.metadata);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.xs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User avatar
            _buildAvatar(activity.user),
            const SizedBox(width: AppSizes.md),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action description with entity icon
                  Row(
                    children: [
                      Icon(
                        entityInfo.icon,
                        size: AppSizes.iconSm,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.xs),
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: AppSizes.fontSm,
                              color: colorScheme.onSurface,
                            ),
                            children: [
                              TextSpan(
                                text: activity.user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: ' $actionVerb '),
                              TextSpan(
                                text: entityLabel,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Metadata summary
                  if (metadataSummary != null) ...[
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      metadataSummary,
                      style: TextStyle(
                        fontSize: AppSizes.fontXs,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            // Relative time
            Text(
              _relativeTime(activity.createdAt),
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

  Widget _buildAvatar(ActivityUserModel user) {
    if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: AppSizes.avatarSm / 2,
        backgroundImage: NetworkImage(user.avatarUrl!),
        backgroundColor: AppColors.primary.withValues(alpha: 0.2),
      );
    }

    final initial = user.name.isNotEmpty
        ? user.name.substring(0, 1).toUpperCase()
        : '?';

    return CircleAvatar(
      radius: AppSizes.avatarSm / 2,
      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
      child: Text(
        initial,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  /// Map action strings to Spanish verb forms
  static String _actionVerb(String action) {
    return switch (action) {
      'created' => 'creo',
      'updated' => 'actualizo',
      'deleted' => 'elimino',
      'checked' => 'marco',
      'settled' => 'liquido',
      'favorited' => 'favorito',
      'rated' => 'califico',
      'voted' => 'voto',
      'archived' => 'archivo',
      _ => action,
    };
  }

  /// Map entity type strings to Spanish labels and icons
  static _EntityTypeInfo _entityTypeInfo(String entityType) {
    return switch (entityType) {
      'board' => const _EntityTypeInfo('un tablero', Icons.dashboard),
      'board_item' => const _EntityTypeInfo('un elemento', Icons.photo),
      'recipe' => const _EntityTypeInfo('una receta', Icons.restaurant_menu),
      'expense' => const _EntityTypeInfo('un gasto', Icons.attach_money),
      'wishlist' => const _EntityTypeInfo('un deseo', Icons.card_giftcard),
      'calendar' => const _EntityTypeInfo('un evento', Icons.event),
      'menu' => const _EntityTypeInfo('un menu', Icons.restaurant),
      'menu_item' => const _EntityTypeInfo('un plato', Icons.lunch_dining),
      'tag' => const _EntityTypeInfo('una etiqueta', Icons.label),
      'comment' => const _EntityTypeInfo('un comentario', Icons.comment),
      _ => _EntityTypeInfo(entityType, Icons.circle),
    };
  }

  /// Build a summary string from metadata if available
  static String? _buildMetadataSummary(Map<String, dynamic>? metadata) {
    if (metadata == null || metadata.isEmpty) return null;

    // Try common metadata keys for a useful summary
    final name = metadata['name'] ?? metadata['title'] ?? metadata['description'];
    if (name != null) return name.toString();

    return null;
  }

  /// Convert a DateTime to a Spanish relative time string
  static String _relativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'ahora';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return 'hace $minutes min';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return 'hace $hours h';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return 'hace $days d';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'hace $weeks sem';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return 'hace $months mes${months > 1 ? 'es' : ''}';
    } else {
      final years = (difference.inDays / 365).floor();
      return 'hace $years a${years > 1 ? 'nos' : 'no'}';
    }
  }
}

/// Helper class to hold entity type display information
class _EntityTypeInfo {
  final String label;
  final IconData icon;

  const _EntityTypeInfo(this.label, this.icon);
}
