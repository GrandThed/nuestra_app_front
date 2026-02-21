import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/services/image_picker_service.dart';
import 'package:nuestra_app/core/utils/file_utils.dart';
import 'package:nuestra_app/features/boards/data/models/board_model.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_notifier.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

/// Parses a hex color string (with or without '#') into a [Color].
Color _parseColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

/// Screen to display board items in a grid
class BoardDetailScreen extends ConsumerStatefulWidget {
  final String boardId;

  const BoardDetailScreen({super.key, required this.boardId});

  @override
  ConsumerState<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends ConsumerState<BoardDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load board only if not already loaded
    Future.microtask(() {
      ref
          .read(boardDetailNotifierProvider(widget.boardId).notifier)
          .loadBoardIfNeeded();
    });
  }

  String get boardId => widget.boardId;

  @override
  Widget build(BuildContext context) {
    final boardState = ref.watch(boardDetailNotifierProvider(boardId));

    return Scaffold(
      appBar: AppBar(
        title: boardState.when(
          initial: () => const Text('Tablero'),
          loading: () => const Text('Cargando...'),
          loaded: (board) => Text(board.name),
          error: (_) => const Text('Error'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                  .read(boardDetailNotifierProvider(boardId).notifier)
                  .loadBoard();
            },
          ),
        ],
      ),
      body: boardState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded:
            (board) =>
                board.items?.isEmpty ?? true
                    ? _buildEmptyState(context)
                    : _buildItemsGrid(context, board),
        error: (message) => _buildErrorState(context, message),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemOptions(context),
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
            Icons.photo_library_outlined,
            size: 64,
            color: AppColors.boards.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            'Este tablero está vacío',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.sm),
          const Text('Agrega links o fotos'),
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
              ref
                  .read(boardDetailNotifierProvider(boardId).notifier)
                  .loadBoard();
            },
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsGrid(BuildContext context, BoardModel board) {
    final items = board.items ?? [];

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(boardDetailNotifierProvider(boardId).notifier)
            .loadBoard();
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _BoardItemCard(
            key: ValueKey(item.id),
            item: item,
            onTap: () => _showItemDetail(context, item),
            onLongPress: () => _showItemOptions(context, item),
          );
        },
      ),
    );
  }

  void _showAddItemOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (sheetContext) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(AppSizes.paddingMd),
                  child: Text(
                    'Agregar al tablero',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.link, color: AppColors.boards),
                  title: const Text('Agregar link'),
                  subtitle: const Text('Pega un enlace de cualquier sitio'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showAddLinkDialog(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: AppColors.boards,
                  ),
                  title: const Text('Agregar foto'),
                  subtitle: const Text(
                    'Toma una foto o selecciona de la galería',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showAddPhotoOptions(context);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showAddLinkDialog(BuildContext context) {
    final urlController = TextEditingController();
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Agregar link'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'URL',
                    hintText: 'https://...',
                    prefixIcon: Icon(Icons.link),
                  ),
                  keyboardType: TextInputType.url,
                  autofocus: true,
                ),
                const SizedBox(height: AppSizes.md),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título (opcional)',
                    hintText: 'Describe el enlace',
                    prefixIcon: Icon(Icons.title),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(AppStrings.cancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  final url = urlController.text.trim();
                  if (url.isNotEmpty) {
                    Navigator.pop(dialogContext);
                    final item = await ref
                        .read(boardDetailNotifierProvider(boardId).notifier)
                        .addLinkItem(
                          url: url,
                          title:
                              titleController.text.trim().isEmpty
                                  ? null
                                  : titleController.text.trim(),
                        );
                    if (item != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Link agregado'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boardsDark,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, AppSizes.buttonHeight),
                ),
                child: const Text('Agregar'),
              ),
            ],
          ),
    );
  }

  void _showAddPhotoOptions(BuildContext context) async {
    final choice = await ImagePickerService.showImageSourcePicker(context);
    if (choice == null || !context.mounted) return;

    final imagePickerService = ImagePickerService();
    List<File> photos = [];

    if (choice == ImagePickerChoice.galleryMultiple) {
      photos = await imagePickerService.pickMultipleImages();
    } else {
      final source =
          choice == ImagePickerChoice.camera
              ? ImageSource.camera
              : ImageSource.gallery;
      final photo = await imagePickerService.pickImage(source: source);
      if (photo != null) {
        photos = [photo];
      }
    }

    if (photos.isEmpty || !context.mounted) return;

    // Show loading
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Subiendo ${photos.length} foto${photos.length > 1 ? 's' : ''}...',
            ),
          ],
        ),
        duration: const Duration(seconds: 60),
        backgroundColor: AppColors.info,
      ),
    );

    int successCount = 0;
    for (final photo in photos) {
      final item = await ref
          .read(boardDetailNotifierProvider(boardId).notifier)
          .addPhotoItem(photo: photo);
      if (item != null) successCount++;
    }

    messenger.hideCurrentSnackBar();

    if (context.mounted) {
      final allSuccess = successCount == photos.length;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            allSuccess
                ? '${photos.length} foto${photos.length > 1 ? 's' : ''} agregada${photos.length > 1 ? 's' : ''}'
                : '$successCount de ${photos.length} fotos subidas',
          ),
          backgroundColor: allSuccess ? AppColors.success : AppColors.warning,
        ),
      );
    }
  }

  void _showItemDetail(BuildContext context, BoardItemModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (sheetContext) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder:
                (_, scrollController) => _ItemDetailSheet(
                  item: item,
                  scrollController: scrollController,
                  onClose: () => Navigator.pop(sheetContext),
                ),
          ),
    );
  }

  void _showItemOptions(BuildContext context, BoardItemModel item) {
    showModalBottomSheet(
      context: context,
      builder:
          (sheetContext) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.type == 'link' && item.url != null)
                  ListTile(
                    leading: const Icon(Icons.open_in_browser),
                    title: const Text('Abrir enlace'),
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      final url = Uri.parse(item.url!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                if (item.type == 'photo')
                  ListTile(
                    leading: const Icon(Icons.flip),
                    title: const Text('Ver reverso'),
                    subtitle: const Text('Editar notas, fecha y lugar'),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _showPhotoBack(context, item);
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.delete, color: AppColors.error),
                  title: const Text(
                    'Eliminar',
                    style: TextStyle(color: AppColors.error),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showDeleteConfirmation(context, item);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showPhotoBack(BuildContext context, BoardItemModel item) {
    final textController = TextEditingController(text: item.photoBack?.text);
    final dateController = TextEditingController(text: item.photoBack?.date);
    final placeController = TextEditingController(text: item.photoBack?.place);

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Reverso de la foto'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Nota',
                      hintText: 'Escribe algo sobre esta foto',
                      prefixIcon: Icon(Icons.note),
                    ),
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha',
                      hintText: '2024-01-15',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextField(
                    controller: placeController,
                    decoration: const InputDecoration(
                      labelText: 'Lugar',
                      hintText: 'Buenos Aires, Argentina',
                      prefixIcon: Icon(Icons.place),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(AppStrings.cancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  await ref
                      .read(boardDetailNotifierProvider(boardId).notifier)
                      .updateItem(
                        itemId: item.id,
                        photoBack: PhotoBackModel(
                          text:
                              textController.text.trim().isEmpty
                                  ? null
                                  : textController.text.trim(),
                          date:
                              dateController.text.trim().isEmpty
                                  ? null
                                  : dateController.text.trim(),
                          place:
                              placeController.text.trim().isEmpty
                                  ? null
                                  : placeController.text.trim(),
                        ),
                      );
                },
                child: const Text(AppStrings.save),
              ),
            ],
          ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, BoardItemModel item) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Eliminar item'),
            content: const Text('¿Estás seguro que deseas eliminar este item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(AppStrings.cancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  final success = await ref
                      .read(boardDetailNotifierProvider(boardId).notifier)
                      .deleteItem(item.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success ? 'Item eliminado' : 'Error al eliminar',
                        ),
                        backgroundColor:
                            success ? AppColors.success : AppColors.error,
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

/// Card widget for displaying a board item
class _BoardItemCard extends StatelessWidget {
  final BoardItemModel item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _BoardItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        item.type == 'photo'
            ? item.thumbnailUrl ?? item.url
            : item.linkPreviewImage ?? item.thumbnailUrl;

    return Card(
      margin: EdgeInsets.all(2),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image with caching, shimmer, and memory optimization
            if (imageUrl != null)
              LayoutBuilder(
                builder: (context, constraints) {
                  final pixelRatio = MediaQuery.devicePixelRatioOf(context);
                  return CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    memCacheWidth: (constraints.maxWidth * pixelRatio).round(),
                    memCacheHeight: (constraints.maxHeight * pixelRatio).round(),
                    placeholder:
                        (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.shimmerBase,
                          highlightColor: AppColors.shimmerHighlight,
                          child: Container(color: Colors.white),
                        ),
                    errorWidget: (context, url, error) => _buildPlaceholder(context),
                  );
                },
              )
            else
              _buildPlaceholder(context),

            // Type indicator
            Positioned(
              top: AppSizes.xs,
              right: AppSizes.xs,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  item.type == 'photo' ? Icons.photo : Icons.link,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),

            // Title overlay
            if (item.title != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.xs),
                  color: Colors.black54,
                  child: Text(
                    item.title!,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

            // Photo back indicator
            if (item.type == 'photo' && _hasPhotoBack)
              Positioned(
                top: AppSizes.xs,
                left: AppSizes.xs,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.boards,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.flip, size: 16, color: Colors.white),
                ),
              ),

            // Comment count badge
            if (item.comments.isNotEmpty)
              Positioned(
                top: _hasPhotoBack && item.type == 'photo'
                    ? AppSizes.xs + 24 + 4 // below photo-back indicator
                    : AppSizes.xs,
                left: AppSizes.xs,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.chat_bubble,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${item.comments.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Tag color dots
            if (item.tags.isNotEmpty)
              Positioned(
                bottom: item.title != null
                    ? AppSizes.xs + 28 // above title overlay
                    : AppSizes.xs,
                left: AppSizes.xs,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: item.tags
                      .take(3)
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _parseColor(tag.color),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool get _hasPhotoBack {
    final back = item.photoBack;
    if (back == null) return false;
    return back.text != null ||
        back.date != null ||
        back.place != null ||
        back.drawingUrl != null;
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          item.type == 'photo' ? Icons.photo : Icons.link,
          size: 32,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Bottom sheet for item detail view
class _ItemDetailSheet extends StatelessWidget {
  final BoardItemModel item;
  final ScrollController scrollController;
  final VoidCallback onClose;

  const _ItemDetailSheet({
    required this.item,
    required this.scrollController,
    required this.onClose,
  });

  void _openFullScreenPhoto(
    BuildContext context,
    String imageUrl,
    String? title,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => _FullScreenPhotoViewer(imageUrl: imageUrl, title: title),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imageUrl =
        item.type == 'photo'
            ? item.url
            : item.linkPreviewImage ?? item.thumbnailUrl;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSizes.md),
              decoration: BoxDecoration(
                color: colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Image (tappable for photos to open full-screen viewer)
          if (imageUrl != null)
            GestureDetector(
              onTap:
                  item.type == 'photo'
                      ? () =>
                          _openFullScreenPhoto(context, imageUrl, item.title)
                      : null,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
                        final cacheWidth = constraints.maxWidth.isFinite
                            ? (constraints.maxWidth * pixelRatio).round()
                            : null;
                        return CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                          memCacheWidth: cacheWidth,
                          memCacheHeight: (250 * pixelRatio).round(),
                          placeholder:
                              (context, url) => Shimmer.fromColors(
                                baseColor: colorScheme.surfaceContainerHighest,
                                highlightColor: colorScheme.surface,
                                child: Container(height: 250, color: colorScheme.surface),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                height: 250,
                                color: colorScheme.surfaceContainerHighest,
                                child: Icon(
                                  Icons.broken_image,
                                  size: 48,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                        );
                      },
                    ),
                  ),
                  // Zoom hint for photos
                  if (item.type == 'photo')
                    Positioned(
                      bottom: AppSizes.sm,
                      right: AppSizes.sm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm,
                          vertical: AppSizes.xs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSm,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.zoom_in, size: 16, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Ampliar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

          const SizedBox(height: AppSizes.md),

          // Title
          if (item.title != null)
            Text(item.title!, style: Theme.of(context).textTheme.titleLarge),

          // Description
          if (item.description != null) ...[
            const SizedBox(height: AppSizes.sm),
            Text(
              item.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],

          // URL for links
          if (item.type == 'link' && item.url != null) ...[
            const SizedBox(height: AppSizes.md),
            InkWell(
              onTap: () => _launchUrl(item.url!),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
                child: Row(
                  children: [
                    Icon(
                      Icons.link,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: AppSizes.xs),
                    Expanded(
                      child: Text(
                        item.url!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _launchUrl(item.url!),
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Abrir enlace'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boardsDark,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],

          // Photo back info
          if (item.type == 'photo' && item.photoBack != null) ...[
            const Divider(height: AppSizes.xl),
            const Text(
              'Reverso de la foto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSizes.sm),
            if (item.photoBack!.text != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sm),
                child: Text(item.photoBack!.text!),
              ),
            if (item.photoBack!.date != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.xs),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: AppSizes.xs),
                    Text(item.photoBack!.date!),
                  ],
                ),
              ),
            if (item.photoBack!.place != null)
              Row(
                children: [
                  const Icon(Icons.place, size: 16),
                  const SizedBox(width: AppSizes.xs),
                  Text(item.photoBack!.place!),
                ],
              ),
          ],

          // Comments section
          if (item.comments.isNotEmpty) ...[
            const Divider(height: AppSizes.xl),
            Row(
              children: [
                const Icon(Icons.chat_bubble_outline, size: 18),
                const SizedBox(width: AppSizes.xs),
                Text(
                  'Comentarios (${item.comments.length})',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            ...item.comments.map(
              (comment) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Text(
                        comment.user.name.isNotEmpty
                            ? comment.user.name[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                comment.user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: AppSizes.sm),
                              Text(
                                DateFormat('dd/MM/yy HH:mm')
                                    .format(comment.createdAt.toLocal()),
                                style:
                                    Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          if (comment.emoji != null)
                            Text(
                              comment.emoji!,
                              style: const TextStyle(fontSize: 20),
                            ),
                          if (comment.content != null)
                            Text(
                              comment.content!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Created by
          if (item.createdBy != null) ...[
            const SizedBox(height: AppSizes.lg),
            Text(
              'Agregado por ${item.createdBy!.name}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Full-screen photo viewer with pinch-to-zoom
class _FullScreenPhotoViewer extends StatelessWidget {
  final String imageUrl;
  final String? title;

  const _FullScreenPhotoViewer({required this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: title != null ? Text(title!) : null,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        initialScale: PhotoViewComputedScale.contained,
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder:
            (context, event) => Center(
              child: CircularProgressIndicator(
                value:
                    event == null
                        ? null
                        : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes ?? 1),
                color: Colors.white,
              ),
            ),
        errorBuilder:
            (context, error, stackTrace) => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, size: 64, color: Colors.white54),
                  SizedBox(height: 16),
                  Text(
                    'No se pudo cargar la imagen',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
