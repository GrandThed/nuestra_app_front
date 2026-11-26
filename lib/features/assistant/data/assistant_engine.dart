import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_edge_ai/flutter_edge_ai.dart';
import 'package:flutter_edge_ai_litertlm/flutter_edge_ai_litertlm.dart';
import 'package:nuestra_app/features/assistant/data/assistant_tools.dart';

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

  /// Context window (prompt + history + reply), in tokens.
  static const _contextTokens = 4096;

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

  /// Download (or resume) the model. [onProgress] gets 0-100.
  /// Throws [DownloadCancelledException] when [cancelToken] is cancelled.
  Future<void> install({
    required void Function(int percent) onProgress,
    CancelToken? cancelToken,
  }) async {
    await _ensureInitialized();
    var builder =
        FlutterEdgeAi.installModelFromCatalog(_variant).withProgress(onProgress);
    if (cancelToken != null) builder = builder.withCancelToken(cancelToken);
    await builder.install();
  }

  /// Delete the downloaded model to free space.
  Future<void> uninstall() async {
    await _ensureInitialized();
    await _closeModel();
    await FlutterEdgeAi.uninstallModel(_modelId);
  }

  /// Open a new conversation. Close it with [InferenceChat.close] when done.
  Future<InferenceChat> openChat({
    required String systemInstruction,
    List<AssistantToolSpec> tools = assistantToolSpecs,
  }) async {
    await _ensureInitialized();
    _model ??= await FlutterEdgeAi.getActiveModel(
      maxTokens: _contextTokens,
      preferredBackend: PreferredBackend.gpu,
    );
    return _model!.openChat(
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
      modelType: ModelType.gemma4,
      // Low temperature: answers are about numbers, not creativity
      temperature: 0.3,
      topK: 40,
    );
  }

  Future<void> _closeModel() async {
    final model = _model;
    _model = null;
    await model?.close();
  }
}
