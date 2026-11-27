import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_edge_ai/flutter_edge_ai.dart';
import 'package:flutter_edge_ai_litertlm/flutter_edge_ai_litertlm.dart';
import 'package:nuestra_app/features/assistant/domain/assistant_request.dart';
import 'package:nuestra_app/features/assistant/data/resumable_download.dart';
import 'package:path_provider/path_provider.dart';

/// The on-device engine failed and is not used again until the app restarts.
/// A native engine that failed once can abort the whole app when it is called
/// again (seen on an iPhone 14), so a restart is the only safe retry.
class AssistantUnavailableException implements Exception {
  const AssistantUnavailableException();

  static const message =
      'El asistente tuvo un problema. Cierra la app y vuelve a abrirla para usarlo de nuevo.';

  @override
  String toString() => message;
}

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

  /// The load in progress, shared by every caller: two loads of the 2.6 GB
  /// model at once would not fit in memory.
  Future<InferenceModel>? _loading;

  /// Set after the engine failed; every later call throws
  /// [AssistantUnavailableException] instead of touching the engine.
  bool _failed = false;

  /// True while [stop] is interrupting a generation: the error that follows
  /// is the user's stop, not a failure.
  bool _stopping = false;

  /// One engine operation at a time (chat, JSON, recipe photo, uninstall):
  /// sessions never open or close while another one is running.
  Future<void> _queue = Future.value();

  /// Wait for the previous operation, then run. Call the returned function
  /// when done.
  Future<void Function()> _acquire() async {
    final previous = _queue;
    final done = Completer<void>();
    _queue = done.future;
    await previous;
    return done.complete;
  }

  /// Whether the engine failed in this run of the app.
  bool get isUnavailable => _failed;

  /// Errors about the input or the answer, not about the engine: the engine
  /// is still fine after them.
  static bool _isInputError(Object e) =>
      e is FormatException ||
      e is ContextLimitException ||
      e is IncompleteStructuredOutputException ||
      e is NonConformingStructuredOutputException ||
      e is ResponseFormatUnsupportedException ||
      e is ImageProcessingException ||
      e is ImageTokenizationException ||
      e is AssistantUnavailableException;

  /// Run [task] alone, after the previous operation. An engine error marks
  /// the engine as failed and is rethrown as [AssistantUnavailableException].
  Future<T> _guarded<T>(String what, Future<T> Function() task) async {
    if (_failed) throw const AssistantUnavailableException();
    final release = await _acquire();
    try {
      if (_failed) throw const AssistantUnavailableException();
      return await task();
    } catch (e, st) {
      throw _onError(what, e, st);
    } finally {
      release();
    }
  }

  Object _onError(String what, Object e, StackTrace st) {
    if (_isInputError(e) || _stopping) return e;
    debugPrint('AssistantEngine: $what failed, disabling the engine: $e\n$st');
    _failed = true;
    return const AssistantUnavailableException();
  }

  Future<void> _ensureInitialized() {
    return _initializing ??= FlutterEdgeAi.initialize(
      inferenceEngines: const [LiteRtLmEngine()],
    ).catchError((Object e) {
      // Let a later call try again instead of keeping the failed future
      _initializing = null;
      throw e;
    });
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
  /// Works even after the engine failed (it never loads the model).
  Future<void> uninstall() async {
    final release = await _acquire();
    try {
      await _ensureInitialized();
      try {
        await _closeModel();
      } catch (e) {
        debugPrint('AssistantEngine: could not close the model: $e');
      }
      await FlutterEdgeAi.uninstallModel(_modelId);
      // A file registered with fromFile is ours to delete
      await (await _download()).delete();
    } finally {
      release();
    }
  }

  /// Open a new conversation. Close it with [InferenceChat.close] when done.
  /// Load the model once, with image input enabled: changing these settings
  /// later would close and reload the whole model.
  Future<InferenceModel> _loadModel() async {
    final model = _model;
    if (model != null) return model;
    return _loading ??= () async {
      try {
        await _ensureInitialized();
        final loaded = await FlutterEdgeAi.getActiveModel(
          maxTokens: _contextTokens,
          preferredBackend: PreferredBackend.gpu,
          supportImage: true,
          maxNumImages: 1,
        );
        _model = loaded;
        return loaded;
      } finally {
        _loading = null;
      }
    }();
  }

  /// Answer with JSON that follows [schema]: one short, separate session per
  /// call (nothing from earlier calls leaks in). Constrained decoding makes
  /// the model unable to write anything else; on GPUs that can't constrain,
  /// the prompt asks for JSON and the answer is read leniently.
  Future<Map<String, dynamic>?> readJson({
    required String instructions,
    required String message,
    required Map<String, Object?> schema,
    String name = 'respuesta',
  }) =>
      _guarded('readJson', () => _readJson(instructions, message, schema, name));

  Future<Map<String, dynamic>?> _readJson(
    String instructions,
    String message,
    Map<String, Object?> schema,
    String name,
  ) async {
    final model = await _loadModel();
    final format = ResponseFormat.jsonSchema(schema, name: name);
    final constrained = model.refusalFor(format) == null;
    final chat = await model.openChat(
      systemInstruction: instructions,
      responseFormat: constrained ? format : null,
      modelType: ModelType.gemma4,
      temperature: _temperature,
      topK: _topK,
    );
    _current = chat;
    try {
      await chat.addQueryChunk(Message.text(text: message, isUser: true));
      final buffer = StringBuffer();
      await for (final response in chat.generateChatResponseAsync()) {
        if (response is TextResponse) buffer.write(response.token);
      }
      return decodeJsonObject('$buffer');
    } finally {
      _current = null;
      try {
        await chat.close();
      } catch (e) {
        debugPrint('AssistantEngine: could not close the chat: $e');
      }
    }
  }

  /// A free-text answer, streamed token by token. [history] is the recent
  /// conversation as (isUser, text), oldest first.
  Stream<String> reply({
    required String instructions,
    required List<(bool, String)> history,
    required String message,
  }) async* {
    if (_failed) throw const AssistantUnavailableException();
    final release = await _acquire();
    InferenceChat? chat;
    try {
      if (_failed) throw const AssistantUnavailableException();
      final model = await _loadModel();
      chat = await model.openChat(
        systemInstruction: instructions,
        modelType: ModelType.gemma4,
        temperature: _temperature,
        topK: _topK,
      );
      _current = chat;
      if (history.isNotEmpty) {
        await chat.clearHistory(replayHistory: [
          for (final (isUser, text) in history) Message.text(text: text, isUser: isUser),
        ]);
      }
      await chat.addQueryChunk(Message.text(text: message, isUser: true));
      await for (final response in chat.generateChatResponseAsync()) {
        if (response is TextResponse) yield response.token;
      }
    } catch (e, st) {
      throw _onError('reply', e, st);
    } finally {
      _current = null;
      try {
        await chat?.close();
      } catch (e) {
        debugPrint('AssistantEngine: could not close the chat: $e');
      }
      release();
    }
  }

  /// The session generating right now, to stop it.
  InferenceChat? _current;

  /// Stop whatever is being generated.
  Future<void> stop() async {
    final chat = _current;
    if (chat == null) return;
    _stopping = true;
    try {
      await chat.stopGeneration();
    } catch (e) {
      debugPrint('Could not stop generation: $e');
    } finally {
      // The stopped turn ends on the engine's thread; give its error time to
      // arrive before errors count as failures again.
      unawaited(Future<void>.delayed(const Duration(seconds: 2), () => _stopping = false));
    }
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
  Future<Map<String, dynamic>> extractRecipeFromImage(Uint8List imageBytes) =>
      _guarded('extractRecipeFromImage', () => _extractRecipe(imageBytes));

  Future<Map<String, dynamic>> _extractRecipe(Uint8List imageBytes) async {
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
      systemInstruction: 'Lee recetas de cocina en imágenes y devuelve solo JSON con: '
          'titulo, porciones (número), minutos_preparacion, minutos_coccion, '
          'ingredientes (lista de textos tal como aparecen) y pasos (lista de textos). '
          'Escribe en español neutro. $argentineWords No inventes datos que no estén en la imagen.',
    );
    try {
      await chat.addQueryChunk(Message.withImage(
        text: 'Extrae la receta de esta imagen.',
        imageBytes: imageBytes,
        isUser: true,
      ));
      final buffer = StringBuffer();
      await for (final response in chat.generateChatResponseAsync()) {
        if (response is TextResponse) buffer.write(response.token);
      }
      return decodeRecipeJson('$buffer');
    } finally {
      try {
        await chat.close();
      } catch (e) {
        debugPrint('AssistantEngine: could not close the chat: $e');
      }
    }
  }

  /// Parse the model's JSON, tolerating text or code fences around it.
  static Map<String, dynamic> decodeRecipeJson(String text) =>
      decodeJsonObject(text) ?? (throw const FormatException('No encontré una receta en la imagen'));

  Future<void> _closeModel() async {
    final model = _model;
    _model = null;
    await model?.close();
  }
}
