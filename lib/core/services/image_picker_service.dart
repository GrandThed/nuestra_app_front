import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuestra_app/core/utils/file_utils.dart';

/// Service for picking images
class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick a single image from gallery or camera
  Future<File?> pickImage({
    required ImageSource source,
    int maxWidth = 1920,
    int maxHeight = 1920,
    int imageQuality = 85,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );

      if (pickedFile == null) return null;
      return createFile(pickedFile.path);
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  /// Pick multiple images from gallery
  Future<List<File>> pickMultipleImages({
    int maxWidth = 1920,
    int maxHeight = 1920,
    int imageQuality = 85,
    int? limit,
  }) async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
        limit: limit,
      );

      return pickedFiles.map((xFile) => createFile(xFile.path)).toList();
    } catch (e) {
      debugPrint('Error picking images: $e');
      return [];
    }
  }

  /// Show a bottom sheet to choose image source (single or multiple)
  static Future<ImagePickerChoice?> showImageSourcePicker(
    BuildContext context, {
    bool allowMultiple = true,
  }) {
    return showModalBottomSheet<ImagePickerChoice>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (allowMultiple)
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar fotos'),
                subtitle: const Text('Elige varias de la galería'),
                onTap: () => Navigator.pop(ctx, ImagePickerChoice.galleryMultiple),
              ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Una foto de galería'),
              onTap: () => Navigator.pop(ctx, ImagePickerChoice.gallerySingle),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar foto'),
              onTap: () => Navigator.pop(ctx, ImagePickerChoice.camera),
            ),
          ],
        ),
      ),
    );
  }
}

/// Options for image picker
enum ImagePickerChoice {
  gallerySingle,
  galleryMultiple,
  camera,
}
