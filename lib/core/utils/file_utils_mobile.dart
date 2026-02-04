import 'dart:io' as io;
import 'package:flutter/material.dart';

/// Re-export File from dart:io for mobile
typedef File = io.File;

/// Creates a File from path (mobile only)
File createFile(String path) => io.File(path);

/// Check if file exists (mobile only)
Future<bool> fileExists(String path) => io.File(path).exists();

/// Widget to display a file image
Widget fileImage(String path, {BoxFit fit = BoxFit.cover}) {
  return Image.file(
    io.File(path),
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.broken_image);
    },
  );
}
