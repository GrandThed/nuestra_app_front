import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_edge_ai/flutter_edge_ai.dart';
import 'package:flutter_edge_ai_litertlm/flutter_edge_ai_litertlm.dart';
import 'package:nuestra_app/features/assistant/data/assistant_tools.dart';
import 'package:nuestra_app/features/assistant/data/resumable_download.dart';
import 'package:path_provider/path_provider.dart';

/// Runs Gemma 4 E2B on the phone through LiteRT-LM (flutter_edge_ai).
///
/// The model (~2.6 GB, Apache-2.0, no Hugging Face token needed) is
/// downloaded once on first use and stays on the device.
/// Android 11+ (arm64) and iOS 15+ only; the web build is a preview of the
/// plugin and is not enabled in this app.
class AssistantEngine {
  AssistantEngine._();

  static final instance = AssistantEngine._();

  /// Android/iOS build of Gemma 4 E2B instruction-tuned.
  static final _variant = LiteRtLmModels.gemma4E2bIt.generic;

  /// Approximate download size, for the UI.
  static const downloadSizeLabel = '2,6 GB';

  /// Context window (prompt + history + reply), in tokens. 8k leaves room
  /// for the food and expense tools plus an image (~257 tokens).
  static const _contextTokens = 8192;

  /// Sampling shared by every chat: LiteRT-LM fixes the sampler on the first
  /// generation of a model, so all sessions must use the same values.
  static const _temperature = 0.3;
  static const _topK = 40;

  bool get isSupportedPlatform =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  String get _modelId => _variant.file.installFilename;

  Future<void>? _initializing;
  InferenceModel? _model;

  Future<void> _ensureInitialized() {
    return _initializing ??= FlutterEdgeAi.initialize(
      inferenceEngines: const [LiteRtLmEngine()],
    );
  }

  Future<bool> isInstalled() async {
    await _ensureInitialized();
    return FlutterEdgeAi.isModelInstalled(_modelId);
  }

  /// The model file is downloaded by the app itself (not by the plugin): the
  /// plugin can't resume downloads from Hugging Face and starts 2.6 GB over
  /// on any error. See [ResumableDownload].
  Future<ResumableDownload> _download() async {
    final dir = await getApplicationSupportDirectory();
    return ResumableDownload(
      url: Uri.parse(_variant.file.url),
      target: File('${dir.path}/models/$_modelId'),
      expectedBytes: _variant.file.sizeBytes,
    );
  }

  /// How much of the model is already on the phone (0-100), to offer
  /// continuing an interrupted download.
  Future<int> downloadedPercent() async {
    if (!isSupportedPlatform) return 0;
    final download = await _download();
    return (await download.downloadedBytes()) * 100 ~/ download.expectedBytes;
  }

  /// Download the model, continuing from what is already on the phone, then
  /// register it with the plugin. [onProgress] gets 0-100.
  /// Throws [DownloadCancelledException] when [cancelToken] is cancelled; the
  /// downloaded part is kept.
  Future<void> install({
    required void Function(int percent) onProgress,
    CancelToken? cancelToken,
  }) async {
    await _ensureInitialized();
    final download = await _download();
    var lastPercent = -1;
    try {
      await download.run(
        cancelled: cancelToken?.whenCancelled,
        onProgress: (received, total) {
          final percent = received * 100 ~/ total;
          if (percent != lastPercent) onProgress(lastPercent = percent);
        },
      );
    } on DownloadCancelled {
      throw DownloadCancelledException('Descarga cancelada', StackTrace.current);
    }
    await FlutterEdgeAi.installModel(
      modelType: _variant.modelType,
      fileType: _variant.fileType,
    ).fromFile(download.target.path).install();
  }

  /// Delete the downloaded model to free space.
  Future<void> uninstall() async {
    await _ensureInitialized();
    await _closeModel();
    await FlutterEdgeAi.uninstallModel(_modelId);
    // A file registered with fromFile is ours to delete
    await (await _download()).delete();
  }

  /// Open a new conversation. Close it with [InferenceChat.close] when done.
  /// Load the model once, with image input enabled: changing these settings
  /// later would close and reload the whole model.
  Future<InferenceModel> _loadModel() async {
    await _ensureInitialized();
    return _model ??= await FlutterEdgeAi.getActiveModel(
      maxTokens: _contextTokens,
      preferredBackend: PreferredBackend.gpu,
      supportImage: true,
      maxNumImages: 1,
    );
  }

  Future<InferenceChat> openChat({
    required String systemInstruction,
    List<AssistantToolSpec> tools = assistantToolSpecs,
  }) async {
    final model = await _loadModel();
    return model.openChat(
      systemInstruction: systemInstruction,
      tools: [
        for (final t in tools)
          Tool(
            name: t.name,
            description: t.description,
            parameters: t.parameters,
          ),
      ],
      // Without this the tool-call JSON comes back as plain text
      supportsFunctionCalls: true,
      supportImage: true,
      modelType: ModelType.gemma4,
      temperature: _temperature,
      topK: _topK,
    );
  }

  /// JSON shape of a recipe read from a photo.
  static final _recipeFormat = ResponseFormat.jsonSchema({
    'type': 'object',
    'properties': {
      'titulo': {'type': 'string'},
      'porciones': {'type': 'integer'},
      'minutos_preparacion': {'type': 'integer'},
      'minutos_coccion': {'type': 'integer'},
      'ingredientes': {
        'type': 'array',
        'items': {'type': 'string', 'description': 'Un ingrediente como en la imagen, ej: "200 g de azúcar"'},
      },
      'pasos': {'type': 'array', 'items': {'type': 'string'}},
    },
    'required': ['titulo', 'porciones', 'ingredientes', 'pasos'],
    'additionalProperties': false,
  }, name: 'receta');

  /// Read a recipe from a photo or screenshot, on the phone. Uses a separate
  /// one-off chat with structured output (no tools). Returns the decoded JSON
  /// ({titulo, porciones, ingredientes, pasos, ...}) for the user to review.
  Future<Map<String, dynamic>> extractRecipeFromImage(Uint8List imageBytes) async {
    final model = await _loadModel();
    // Constrained decoding is not available on every GPU: then ask for JSON
    // in the prompt and parse it leniently.
    final constrained = model.refusalFor(_recipeFormat) == null;
    final chat = await model.openChat(
      supportImage: true,
      responseFormat: constrained ? _recipeFormat : null,
      modelType: ModelType.gemma4,
      temperature: _temperature,
      topK: _topK,
      systemInstruction: 'Leés recetas de cocina en imágenes y devolvés solo JSON con: '
          'titulo, porciones (número), minutos_preparacion, minutos_coccion, '
          'ingredientes (lista de textos tal como aparecen) y pasos (lista de textos). '
          'Respondé en español. No inventes datos que no estén en la imagen.',
    );
    try {
      await chat.addQueryChunk(Message.withImage(
        text: 'Extraé la receta de esta imagen.',
        imageBytes: imageBytes,
        isUser: true,
      ));
      final buffer = StringBuffer();
      await for (final response in chat.generateChatResponseAsync()) {
        if (response is TextResponse) buffer.write(response.token);
      }
      return decodeRecipeJson('$buffer');
    } finally {
      await chat.close();
    }
  }

  /// Parse the model's JSON, tolerating text or code fences around it.
  static Map<String, dynamic> decodeRecipeJson(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start < 0 || end <= start) {
      throw const FormatException('No encontré una receta en la imagen');
    }
    final decoded = jsonDecode(text.substring(start, end + 1));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('No encontré una receta en la imagen');
    }
    return decoded;
  }

  Future<void> _closeModel() async {
    final model = _model;
    _model = null;
    await model?.close();
  }
}
