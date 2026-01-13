import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';
import 'package:nuestra_app/shared/widgets/app_network_image.dart';

class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  ConsumerState<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends ConsumerState<RecipesScreen> {
  final _searchController = TextEditingController();
  String? _selectedSeason;

  static const _seasons = ['Primavera', 'Verano', 'Otoño', 'Invierno'];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(recipesNotifierProvider.notifier).loadRecipes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    ref.read(recipesNotifierProvider.notifier).loadRecipes(
          search: _searchController.text.isEmpty ? null : _searchController.text,
          season: _selectedSeason,
        );
  }

  void _onSeasonChanged(String? season) {
    setState(() {
      _selectedSeason = season;
    });
    _onSearch();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipesNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Recetas'),
        backgroundColor: AppColors.recipes,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.surface,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar recetas...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearch();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.recipes, width: 2),
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
              ),
              onSubmitted: (_) => _onSearch(),
            ),
          ),

          // Season filter chips
          if (_selectedSeason != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.surface,
              child: Row(
                children: [
                  Chip(
                    label: Text(_selectedSeason!),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => _onSeasonChanged(null),
                    backgroundColor: AppColors.recipes.withValues(alpha: 0.1),
                    labelStyle: const TextStyle(color: AppColors.recipes),
                    deleteIconColor: AppColors.recipes,
                  ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: switch (state) {
              RecipesStateInitial() => const Center(
                  child: Text('Cargando recetas...'),
                ),
              RecipesStateLoading() => const Center(
                  child: CircularProgressIndicator(color: AppColors.recipes),
                ),
              RecipesStateError(:final message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                      const SizedBox(height: 16),
                      Text(message, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(recipesNotifierProvider.notifier).loadRecipes(),
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              RecipesStateLoaded(:final recipes) => recipes.isEmpty
                  ? _buildEmptyState()
                  : _buildRecipesList(recipes),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/recipes/new'),
        backgroundColor: AppColors.recipes,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 80,
            color: AppColors.recipes.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'No hay recetas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Agrega tu primera receta',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesList(List<RecipeModel> recipes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return _RecipeCard(
          recipe: recipe,
          onTap: () => context.push('/recipes/${recipe.id}'),
          onDelete: () => _confirmDelete(recipe),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtrar por temporada',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Todas'),
                  selected: _selectedSeason == null,
                  onSelected: (_) {
                    Navigator.pop(context);
                    _onSeasonChanged(null);
                  },
                  selectedColor: AppColors.recipes.withValues(alpha: 0.2),
                  checkmarkColor: AppColors.recipes,
                ),
                ..._seasons.map((season) => FilterChip(
                      label: Text(season),
                      selected: _selectedSeason == season,
                      onSelected: (_) {
                        Navigator.pop(context);
                        _onSeasonChanged(season);
                      },
                      selectedColor: AppColors.recipes.withValues(alpha: 0.2),
                      checkmarkColor: AppColors.recipes,
                    )),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(RecipeModel recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar receta'),
        content: Text('¿Seguro que quieres eliminar "${recipe.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(recipesNotifierProvider.notifier).deleteRecipe(recipe.id);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _RecipeCard({
    required this.recipe,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Recipe image
            SizedBox(
              width: 100,
              height: 100,
              child: recipe.imageUrl != null
                  ? AppNetworkImage(
                      imageUrl: recipe.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: AppColors.recipes.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.restaurant,
                        size: 40,
                        color: AppColors.recipes,
                      ),
                    ),
            ),

            // Recipe info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (recipe.servings != null)
                      Row(
                        children: [
                          const Icon(Icons.people, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.servings} porciones',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    if (recipe.ingredients != null && recipe.ingredients!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${recipe.ingredients!.length} ingredientes',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Delete button
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.textSecondary),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
