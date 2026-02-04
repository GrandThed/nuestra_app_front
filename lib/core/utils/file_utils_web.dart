import 'dart:typed_data';
import 'package:flutter/material.dart';

/// Stub File class for web - mirrors dart:io File interface
class File {
  final String path;

  File(this.path);

  Future<bool> exists() async => false;

  Future<Uint8List> readAsBytes() async => Uint8List(0);

  Future<String> readAsString() async => '';

  int lengthSync() => 0;

  String get uri => path;
}

/// Creates a File stub from path (web - does nothing useful)
File createFile(String path) => File(path);

/// Check if file exists (web - always false)
Future<bool> fileExists(String path) async => false;

/// Widget to display a file image (web - shows placeholder)
Widget fileImage(String path, {BoxFit fit = BoxFit.cover}) {
  return const Icon(Icons.image_not_supported);
}
