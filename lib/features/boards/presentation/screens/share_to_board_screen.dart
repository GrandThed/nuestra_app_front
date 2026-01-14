import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/services/share_intent_service.dart';
import 'package:nuestra_app/features/boards/data/models/board_model.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_notifier.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_state.dart';

/// Screen to select which board to save shared content to
class ShareToBoardScreen extends ConsumerStatefulWidget {
  const ShareToBoardScreen({super.key});

  @override
  ConsumerState<ShareToBoardScreen> createState() => _ShareToBoardScreenState();
}

class _ShareToBoardScreenState extends ConsumerState<ShareToBoardScreen> {
  bool _isSaving = false;
  String? _selectedBoardId;

  @override
  void initState() {
    super.initState();
    // Load boards when screen opens
    Future.microtask(() {
      ref.read(boardsNotifierProvider.notifier).loadBoards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sharedContent = ref.watch(sharedContentProvider);
    final boardsState = ref.watch(boardsNotifierProvider);

    // If no shared content, close
    if (sharedContent == null || sharedContent.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardar en tablero'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _cancel,
        ),
      ),
      body: Column(
        children: [
          // Preview of shared content
          _buildContentPreview(sharedContent),
          const Divider(),
          // Board selection
          Expanded(
            child: boardsState.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (boards) => boards.isEmpty
                  ? _buildEmptyBoards()
                  : _buildBoardsList(boards),
              error: (message) => _buildError(message),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(sharedContent),
    );
  }

  Widget _buildContentPreview(SharedContent content) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      child: Row(
        children: [
          // Preview icon/image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: content.hasImages
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    child: Image.file(
                      File(content.imagePaths.first),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.link, color: AppColors.boards),
          ),
          const SizedBox(width: AppSizes.md),
          // Content info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content.hasImages
                      ? '${content.imagePaths.length} foto${content.imagePaths.length > 1 ? 's' : ''}'
                      : 'Link compartido',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (content.hasUrl)
                  Text(
                    content.url!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoardsList(List<BoardModel> boards) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      itemCount: boards.length + 1, // +1 for "Create new board" option
      itemBuilder: (context, index) {
        if (index == boards.length) {
          return _buildCreateNewBoardTile();
        }
        final board = boards[index];
        final isSelected = _selectedBoardId == board.id;
        return ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.boards.withValues(alpha: 0.2)
                  : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Icon(
              Icons.dashboard,
              color: isSelected ? AppColors.boards : AppColors.textSecondary,
            ),
          ),
          title: Text(board.name),
          subtitle: Text('${board.itemCount} items'),
          trailing: isSelected
              ? const Icon(Icons.check_circle, color: AppColors.boards)
              : null,
          selected: isSelected,
          onTap: () {
            setState(() {
              _selectedBoardId = board.id;
            });
          },
        );
      },
    );
  }

  Widget _buildCreateNewBoardTile() {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          border: Border.all(
            color: AppColors.border,
            style: BorderStyle.solid,
          ),
        ),
        child: const Icon(Icons.add, color: AppColors.boards),
      ),
      title: const Text('Crear nuevo tablero'),
      onTap: _showCreateBoardDialog,
    );
  }

  Widget _buildEmptyBoards() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_outlined,
            size: 64,
            color: AppColors.boards.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSizes.md),
          const Text(
            'No tienes tableros',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.sm),
          const Text('Crea uno para guardar este contenido'),
          const SizedBox(height: AppSizes.lg),
          ElevatedButton.icon(
            onPressed: _showCreateBoardDialog,
            icon: const Icon(Icons.add),
            label: const Text('Crear tablero'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.boards,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
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

  Widget _buildBottomBar(SharedContent content) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                _selectedBoardId != null && !_isSaving ? () => _save(content) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.boards,
              padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
            ),
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Guardar', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }

  void _showCreateBoardDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nuevo tablero'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Nombre del tablero',
            hintText: 'ej: Inspiración, Viajes, etc.',
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isEmpty) return;
              Navigator.pop(dialogContext);

              final board = await ref
                  .read(boardsNotifierProvider.notifier)
                  .createBoard(name);

              if (board != null && mounted) {
                setState(() {
                  _selectedBoardId = board.id;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.boards,
            ),
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  Future<void> _save(SharedContent content) async {
    if (_selectedBoardId == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final notifier = ref.read(
        boardDetailNotifierProvider(_selectedBoardId!).notifier,
      );

      bool success = false;

      if (content.hasUrl) {
        // Save as link
        final item = await notifier.addLinkItem(url: content.url!);
        success = item != null;
      } else if (content.hasImages) {
        // Save images
        for (final path in content.imagePaths) {
          final file = File(path);
          if (await file.exists()) {
            final item = await notifier.addPhotoItem(photo: file);
            success = item != null;
          }
        }
      }

      if (mounted) {
        if (success) {
          // Clear shared content
          ref.read(shareIntentServiceProvider).clearSharedContent();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Guardado correctamente'),
              backgroundColor: AppColors.success,
            ),
          );

          // Navigate to the board
          context.go('/boards/$_selectedBoardId');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al guardar'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _cancel() {
    ref.read(shareIntentServiceProvider).clearSharedContent();
    context.go('/');
  }
}
