import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';

/// Service for picking and cropping images
class ImagePickerService {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  /// Pick an image from gallery or camera
  Future<File?> pickImage({
    required ImageSource source,
    bool crop = true,
    CropAspectRatio? aspectRatio,
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

      if (crop) {
        return await _cropImage(
          File(pickedFile.path),
          aspectRatio: aspectRatio,
        );
      }

      return File(pickedFile.path);
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  /// Crop an image file
  Future<File?> _cropImage(
    File imageFile, {
    CropAspectRatio? aspectRatio,
  }) async {
    try {
      final croppedFile = await _cropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recortar imagen',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: aspectRatio != null,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: 'Recortar imagen',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );

      if (croppedFile == null) return null;
      return File(croppedFile.path);
    } catch (e) {
      debugPrint('Error cropping image: $e');
      return imageFile; // Return original if crop fails
    }
  }

  /// Show a bottom sheet to choose image source
  static Future<ImageSource?> showImageSourcePicker(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galería'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Cámara'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }
}
