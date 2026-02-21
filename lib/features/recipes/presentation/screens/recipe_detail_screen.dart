import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';
import 'package:nuestra_app/shared/widgets/app_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailScreen extends ConsumerStatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  ConsumerState<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load recipe only if not already loaded
    Future.microtask(() {
      ref
          .read(recipeDetailProvider(widget.recipeId).notifier)
          .loadRecipeIfNeeded();
    });
  }

  String get recipeId => widget.recipeId;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeDetailProvider(recipeId));

    return Scaffold(
      body: switch (state) {
        RecipeDetailStateInitial() => const Center(
            child: CircularProgressIndicator(color: AppColors.recipes),
          ),
        RecipeDetailStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.recipes),
          ),
        RecipeDetailStateError(:final message) => _buildErrorState(context, message),
        RecipeDetailStateLoaded(:final recipe) => _buildContent(context, recipe),
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: AppColors.recipes,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppSizes.md),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSizes.md),
            ElevatedButton(
              onPressed: () {
                ref.read(recipeDetailProvider(recipeId).notifier).loadRecipe();
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RecipeModel recipe) {
    return CustomScrollView(
      slivers: [
        // App bar with image
        SliverAppBar(
          expandedHeight: recipe.imageUrl != null ? 250 : 0,
          pinned: true,
          backgroundColor: AppColors.recipes,
          foregroundColor: Colors.white,
          flexibleSpace: recipe.imageUrl != null
              ? FlexibleSpaceBar(
                  background: AppNetworkImage(
                    imageUrl: recipe.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          title: Text(
            recipe.title,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            // Favorite toggle button
            IconButton(
              icon: Icon(
                recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: recipe.isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                ref
                    .read(recipeDetailProvider(recipeId).notifier)
                    .toggleFavorite();
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => context.push('/recipes/${recipe.id}/edit'),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  _confirmDelete(context, recipe);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Eliminar', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meta info row
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (recipe.servings != null)
                      _InfoChip(
                        icon: Icons.people,
                        label: '${recipe.servings} porciones',
                      ),
                    if (recipe.ingredients != null && recipe.ingredients!.isNotEmpty)
                      _InfoChip(
                        icon: Icons.restaurant,
                        label: '${recipe.ingredients!.length} ingredientes',
                      ),
                    if (recipe.prepTimeMinutes != null)
                      _InfoChip(
                        icon: Icons.timer,
                        label: '${recipe.prepTimeMinutes} min prep',
                      ),
                    if (recipe.cookTimeMinutes != null)
                      _InfoChip(
                        icon: Icons.whatshot,
                        label: '${recipe.cookTimeMinutes} min coccion',
                      ),
                  ],
                ),

                // Average rating display
                if (recipe.averageRating != null) ...[
                  const SizedBox(height: AppSizes.md),
                  _RatingDisplay(
                    averageRating: recipe.averageRating!,
                    ratingsCount: recipe.ratings.length,
                  ),
                ],

                // Source URL
                if (recipe.sourceUrl != null) ...[
                  const SizedBox(height: AppSizes.md),
                  InkWell(
                    onTap: () => _openUrl(recipe.sourceUrl!),
                    child: Row(
                      children: [
                        const Icon(Icons.link, size: 16, color: AppColors.recipes),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            recipe.sourceUrl!,
                            style: const TextStyle(
                              color: AppColors.recipes,
                              decoration: TextDecoration.underline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Ingredients section
                if (recipe.ingredients != null && recipe.ingredients!.isNotEmpty) ...[
                  const SizedBox(height: AppSizes.xl),
                  const Text(
                    'Ingredientes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ...recipe.ingredients!.map((ingredient) => _IngredientTile(
                        ingredient: ingredient,
                      )),
                ],

                // Instructions section
                if (recipe.instructions != null && recipe.instructions!.isNotEmpty) ...[
                  const SizedBox(height: AppSizes.xl),
                  const Text(
                    'Instrucciones',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ...recipe.instructions!.asMap().entries.map((entry) => _InstructionStep(
                        stepNumber: entry.key + 1,
                        instruction: entry.value,
                      )),
                ],

                // Cooking mode button (only if recipe has instructions)
                if (recipe.instructions != null && recipe.instructions!.isNotEmpty) ...[
                  const SizedBox(height: AppSizes.xl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          context.push(AppRoutes.cookingModeFor(recipe.id)),
                      icon: const Icon(Icons.local_fire_department),
                      label: const Text('Modo cocina'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.recipesDark,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],

                // Created by info
                if (recipe.createdBy != null) ...[
                  const SizedBox(height: AppSizes.xl),
                  const Divider(),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    'Creada por ${recipe.createdBy!.name}',
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],

                const SizedBox(height: AppSizes.xl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _confirmDelete(BuildContext context, RecipeModel recipe) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar receta'),
        content: Text('¿Seguro que quieres eliminar "${recipe.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final success = await ref
                  .read(recipesProvider.notifier)
                  .deleteRecipe(recipe.id);
              if (success && context.mounted) {
                context.pop();
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.recipes.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.recipes),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.recipes,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingDisplay extends StatelessWidget {
  final double averageRating;
  final int ratingsCount;

  const _RatingDisplay({
    required this.averageRating,
    required this.ratingsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final starPosition = index + 1;
          if (averageRating >= starPosition) {
            return const Icon(Icons.star, color: Colors.amber, size: 20);
          } else if (averageRating >= starPosition - 0.5) {
            return const Icon(Icons.star_half, color: Colors.amber, size: 20);
          } else {
            return const Icon(Icons.star_border, color: Colors.grey, size: 20);
          }
        }),
        const SizedBox(width: 8),
        Text(
          averageRating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($ratingsCount valoraciones)',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _IngredientTile extends StatelessWidget {
  final IngredientModel ingredient;

  const _IngredientTile({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.recipes,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                ),
                children: [
                  if (ingredient.quantity != null)
                    TextSpan(
                      text: '${ingredient.quantity} ',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  if (ingredient.unit != null)
                    TextSpan(
                      text: '${ingredient.unit} ',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  TextSpan(text: ingredient.name),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final int stepNumber;
  final String instruction;

  const _InstructionStep({
    required this.stepNumber,
    required this.instruction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppColors.recipes,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
