import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuestra_app/features/assistant/data/assistant_engine.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';
import 'package:nuestra_app/features/food/presentation/food_form_sheet.dart';

/// Turn the model's JSON into the "Nueva receta" form fields.
List<Map<String, Object?>> recipeFormFromExtraction(String surfaceId, Map<String, dynamic> json) {
  int? asInt(Object? v) => v is num ? v.round() : int.tryParse('${v ?? ''}');
  List<String> asLines(Object? v) => (v as List<dynamic>? ?? const [])
      .map((e) => '$e'.trim())
      .where((e) => e.isNotEmpty)
      .toList();
  return FoodForms.nuevaReceta(
    surfaceId,
    title: '${json['titulo'] ?? ''}'.trim(),
    servings: (asInt(json['porciones']) ?? 4).clamp(1, 20),
    ingredientLines: asLines(json['ingredientes']),
    steps: asLines(json['pasos']),
    prepMinutes: asInt(json['minutos_preparacion']),
    cookMinutes: asInt(json['minutos_coccion']),
    fromPhoto: true,
  );
}

/// Pick a photo or screenshot of a recipe, read it on the phone with Gemma
/// and open the pre-filled form to review and save it.
Future<void> addRecipeFromPhoto(BuildContext context, WidgetRef ref) async {
  final engine = AssistantEngine.instance;
  final messenger = ScaffoldMessenger.of(context);
  if (!engine.isSupportedPlatform || !await engine.isInstalled()) {
    messenger.showSnackBar(const SnackBar(
      content: Text('Para leer fotos primero descarga el asistente (pestaña Asistente).'),
    ));
    return;
  }
  if (!context.mounted) return;
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (ctx) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(leading: const Icon(Icons.photo_library_outlined), title: const Text('Elegir de la galería'),
            subtitle: const Text('Una captura de pantalla o foto'), onTap: () => Navigator.pop(ctx, ImageSource.gallery)),
        ListTile(leading: const Icon(Icons.photo_camera_outlined), title: const Text('Sacar una foto'),
            onTap: () => Navigator.pop(ctx, ImageSource.camera)),
      ]),
    ),
  );
  if (source == null) return;
  // Downscale: a recipe stays legible and the model works faster
  final file = await ImagePicker().pickImage(source: source, maxWidth: 1280, maxHeight: 1280, imageQuality: 85);
  if (file == null || !context.mounted) return;
  final Uint8List bytes = await file.readAsBytes();

  if (!context.mounted) return;
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const AlertDialog(
      content: Row(children: [
        CircularProgressIndicator(),
        SizedBox(width: 16),
        Expanded(child: Text('Leyendo la receta…')),
      ]),
    ),
  );
  Map<String, dynamic>? recipe;
  String? problem;
  try {
    recipe = await engine.extractRecipeFromImage(bytes);
  } catch (e) {
    problem = switch (e) {
      FormatException(:final message) => message,
      AssistantUnavailableException() => AssistantUnavailableException.message,
      _ => 'No pude leer la imagen: $e',
    };
  }
  if (!context.mounted) return;
  Navigator.of(context, rootNavigator: true).pop();
  if (recipe == null) {
    messenger.showSnackBar(SnackBar(content: Text(problem ?? 'No pude leer la receta')));
    return;
  }
  await showFoodFormSheet(context, ref, (id) => recipeFormFromExtraction(id, recipe!));
}
