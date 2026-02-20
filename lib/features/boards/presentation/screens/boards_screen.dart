import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/boards/data/models/board_model.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_notifier.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_state.dart';

/// Boards screen - Pinterest-style boards list
class BoardsScreen extends ConsumerStatefulWidget {
  const BoardsScreen({super.key});

  @override
  ConsumerState<BoardsScreen> createState() => _BoardsScreenState();
}

class _BoardsScreenState extends ConsumerState<BoardsScreen> {
  @override
  void initState() {
    super.initState();
    // Load boards only if not already loaded
    Future.microtask(() {
      ref.read(boardsNotifierProvider.notifier).loadBoardsIfNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardsState = ref.watch(boardsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.boards),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_customize_outlined),
            tooltip: 'Plantillas',
            onPressed: () => _showTemplatesBottomSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(boardsNotifierProvider.notifier).loadBoards();
            },
          ),
        ],
      ),
      body: boardsState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (boards) => boards.isEmpty
            ? _buildEmptyState(context)
            : _buildBoardsGrid(context, boards),
        error: (message) => _buildErrorState(context, message),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateBoardDialog(context),
        backgroundColor: AppColors.boardsDark,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_outlined,
            size: 64,
            color: AppColors.boards,
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            AppStrings.emptyBoards,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.sm),
          const Text('Crea tu primer tablero'),
          const SizedBox(height: AppSizes.lg),
          ElevatedButton.icon(
            onPressed: () => _showCreateBoardDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Crear tablero'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.boardsDark,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: AppSizes.md),
          Text(message),
          const SizedBox(height: AppSizes.md),
          ElevatedButton(
            onPressed: () {
              ref.read(boardsNotifierProvider.notifier).loadBoards();
            },
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildBoardsGrid(BuildContext context, List<BoardModel> boards) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(boardsNotifierProvider.notifier).loadBoards();
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(AppSizes.paddingSm),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.sm,
          mainAxisSpacing: AppSizes.sm,
          childAspectRatio: 1.0,
        ),
        itemCount: boards.length,
        itemBuilder: (context, index) {
          final board = boards[index];
          return _BoardCard(
            board: board,
            onTap: () => context.push('${AppRoutes.boards}/${board.id}'),
            onLongPress: () => _showBoardOptions(context, board),
          );
        },
      ),
    );
  }

  void _showTemplatesBottomSheet(BuildContext context) {
    const templates = <({String name, IconData icon})>[
      (name: 'Ideas de decoracion', icon: Icons.home),
      (name: 'Inspiracion de moda', icon: Icons.checkroom),
      (name: 'Recetas favoritas', icon: Icons.restaurant),
      (name: 'Viajes soñados', icon: Icons.flight),
      (name: 'Proyectos DIY', icon: Icons.build),
      (name: 'Regalos', icon: Icons.card_giftcard),
    ];

    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.md,
                AppSizes.md,
                AppSizes.md,
                AppSizes.sm,
              ),
              child: Text(
                'Crear desde plantilla',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ...templates.map(
              (template) => ListTile(
                leading: Icon(template.icon, color: AppColors.boardsDark),
                title: Text(template.name),
                onTap: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  Navigator.pop(sheetContext);
                  final board = await ref
                      .read(boardsNotifierProvider.notifier)
                      .createBoard(template.name);
                  if (board != null && mounted) {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Tablero "${template.name}" creado',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: AppSizes.sm),
          ],
        ),
      ),
    );
  }

  void _showCreateBoardDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nuevo tablero'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nombre del tablero',
            hintText: 'Ej: Ideas de viaje',
            prefixIcon: Icon(Icons.dashboard),
          ),
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pop(dialogContext);
                final board = await ref
                    .read(boardsNotifierProvider.notifier)
                    .createBoard(name);
                if (board != null && mounted) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('Tablero creado'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.boardsDark,
              foregroundColor: Colors.white,
            ),
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  void _showBoardOptions(BuildContext context, BoardModel board) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Renombrar'),
              onTap: () {
                Navigator.pop(sheetContext);
                _showRenameBoardDialog(context, board);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title: const Text('Eliminar', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(sheetContext);
                _showDeleteConfirmation(context, board);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameBoardDialog(BuildContext context, BoardModel board) {
    final controller = TextEditingController(text: board.name);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Renombrar tablero'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nombre del tablero',
            prefixIcon: Icon(Icons.dashboard),
          ),
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty && name != board.name) {
                Navigator.pop(dialogContext);
                ref.read(boardsNotifierProvider.notifier).renameBoard(board.id, name);
              }
            },
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, BoardModel board) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar tablero'),
        content: Text(
          '¿Estás seguro que deseas eliminar "${board.name}"? '
          'Se eliminarán todos los items del tablero.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(dialogContext);
              final success = await ref
                  .read(boardsNotifierProvider.notifier)
                  .deleteBoard(board.id);
              if (mounted) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? 'Tablero eliminado' : 'Error al eliminar',
                    ),
                    backgroundColor: success ? AppColors.success : AppColors.error,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }
}

/// Card widget for displaying a board with 2x2 preview grid
class _BoardCard extends StatelessWidget {
  final BoardModel board;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _BoardCard({
    required this.board,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Preview grid or placeholder
            _buildPreviewGrid(),

            // Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
            ),

            // Board info
            Positioned(
              left: AppSizes.sm,
              right: AppSizes.sm,
              bottom: AppSizes.sm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    board.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${board.itemCount} items',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewGrid() {
    final previews = board.previewItems;

    if (previews.isEmpty) {
      return _buildPlaceholder();
    }

    // 2x2 grid layout
    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      children: List.generate(4, (index) {
        if (index < previews.length) {
          return Image.network(
            previews[index],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildGridPlaceholder(),
          );
        }
        return _buildGridPlaceholder();
      }),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.boards.withValues(alpha: 0.2),
      child: Center(
        child: Icon(
          Icons.dashboard,
          size: 48,
          color: AppColors.boards.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildGridPlaceholder() {
    return Container(
      color: AppColors.boards.withValues(alpha: 0.15),
    );
  }
}
