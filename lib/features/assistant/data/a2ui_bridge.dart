import 'package:a2ui_agent/a2ui_agent.dart';
import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:a2ui_flutter/basic_catalog.dart';
import 'package:flutter/foundation.dart';

/// One piece of an assistant reply, in order: plain text or a UI surface.
sealed class ReplyPart {
  const ReplyPart();
}

class ReplyText extends ReplyPart {
  final String text;
  const ReplyText(this.text);
}

class ReplySurface extends ReplyPart {
  final SurfaceModel<ComponentImplementation> surface;
  const ReplySurface(this.surface);
}

/// Connects the model's text output to the A2UI renderer, all on device:
/// - [promptSnippet] tells the model how to write A2UI (goes in the system
///   prompt);
/// - [parseReply] splits a finished reply into text and rendered surfaces;
/// - taps on surface buttons arrive through [onAction].
class A2uiBridge {
  /// Components the model may use. Few on purpose: the catalog description
  /// goes into the prompt, and the on-device context window is small.
  static const allowedComponents = [
    'Text',
    'Row',
    'Column',
    'Card',
    'List',
    'Divider',
    'Icon',
    'Button',
  ];

  final void Function(A2uiRendererAction action) onAction;

  late final CatalogImplementation _catalog = basicCatalog(locale: 'es-AR');

  late final MessageProcessor<ComponentImplementation> renderer =
      MessageProcessor<ComponentImplementation>(
    catalogs: [_catalog],
    defaultVersion: A2uiProtocolVersion.v1_0,
  );

  late final A2uiRequestProcessor _agent = A2uiGenerator(
    catalogs: [
      CatalogConfig(
        _catalog,
        transformers: [ComponentPruningTransformer(allowedComponents)],
      ),
    ],
    // Plain JSON in <a2ui-json> tags: a base model knows JSON far better
    // than the compact Express DSL. Only new surfaces, no later updates.
    inferenceFormatFactory: const DirectJsonFormatFactory(
      allowedMessages: ['createSurface'],
    ),
  ).createProcessor(
    renderer.getRendererCapabilities(
      const CapabilitiesOptions(versions: [A2uiProtocolVersion.v1_0]),
    ),
  );

  /// Agent-side view of the surfaces created so far in this conversation,
  /// so a reused surface id is caught as an error instead of breaking.
  late RendererState _state = _agent.createState();

  final List<SurfaceModel<ComponentImplementation>> _created = [];
  late final List<Subscription> _subscriptions;

  A2uiBridge({required this.onAction}) {
    _subscriptions = [
      renderer.model.onSurfaceCreated.subscribe(_created.add),
      renderer.model.onAction.subscribe(onAction),
    ];
  }

  /// The library's generated prompt (full JSON schemas). Even pruned it is
  /// ~31k characters (~8k tokens), more than the on-device context, so the
  /// model gets [compactInstructions] instead. Kept for debugging.
  String get fullSchemaPrompt => _agent.promptSnippet;

  /// Short instructions plus one worked example: a 2B model follows an
  /// example far better than a JSON schema, and every block is still
  /// validated against the catalog by [parseReply].
  static String get compactInstructions => '''
TARJETAS VISUALES (opcional)
Para resúmenes o listas de montos podés agregar una tarjeta visual después del texto, con un bloque <a2ui-json>...</a2ui-json> que contiene un array JSON con UN mensaje "createSurface". Para respuestas cortas usá solo texto.
Reglas del bloque:
- "surfaceId" nuevo en cada tarjeta ("t1", "t2", "t3"...), nunca repetido.
- "components" es una lista plana. Cada componente tiene "id" y "component". El primero se llama "root". Los padres van antes que los hijos y los referencian por id.
- Componentes: Card ("child"), Column y List ("children"), Row ("children", "justify": "spaceBetween"), Text ("text", "variant": "body" o "caption"), Divider, Button ("child": id de un Text, "action": {"event": {"name": "...", "context": {...}}}).
- Los montos van como texto ya formateado, por ejemplo "\$ 101.600".
Ejemplo:
<a2ui-json>[{"version":"1.0","createSurface":{"surfaceId":"t1","catalogId":"${BasicCatalog.v1_0Id}","components":[{"id":"root","component":"Card","child":"col"},{"id":"col","component":"Column","children":["titulo","f1","f2","div","total","ver"]},{"id":"titulo","component":"Text","text":"Noviembre 2026"},{"id":"f1","component":"Row","justify":"spaceBetween","children":["f1c","f1m"]},{"id":"f1c","component":"Text","text":"Supermercado"},{"id":"f1m","component":"Text","text":"\$ 101.600"},{"id":"f2","component":"Row","justify":"spaceBetween","children":["f2c","f2m"]},{"id":"f2c","component":"Text","text":"Servicios"},{"id":"f2m","component":"Text","text":"\$ 57.000"},{"id":"div","component":"Divider"},{"id":"total","component":"Text","text":"Total: \$ 158.600"},{"id":"ver","component":"Button","child":"verTxt","action":{"event":{"name":"listar_gastos","context":{"mes":"2026-11"}}}},{"id":"verTxt","component":"Text","text":"Ver gastos"}]}}]</a2ui-json>''';

  /// Split a finished model reply into ordered text and surface parts.
  /// Invalid A2UI never throws: its text is kept and the UI block dropped.
  List<ReplyPart> parseReply(String reply) {
    List<ResponsePart> parts;
    try {
      parts = _agent.parseResponse(_uniqueSurfaceIds(reply), state: _state);
    } on A2uiError catch (e) {
      debugPrint('A2UI parse error ${e.code}: ${e.message}');
      return [
        if (stripUiBlocks(reply).isNotEmpty) ReplyText(stripUiBlocks(reply)),
      ];
    }

    final result = <ReplyPart>[];
    for (final part in parts) {
      switch (part) {
        case TextPart(:final text):
          if (text.trim().isNotEmpty) result.add(ReplyText(text.trim()));
        case A2uiPart(:final a2ui):
          _created.clear();
          try {
            renderer.processMessages(a2ui);
          } catch (e) {
            debugPrint('A2UI render error: $e');
          }
          result.addAll(_created.map(ReplySurface.new));
          _created.clear();
      }
    }
    return result;
  }

  int _surfaceCounter = 0;

  /// The model tends to reuse ids like "t1" in every reply, and A2UI rejects
  /// a second surface with the same id. Make every id unique on our side.
  String _uniqueSurfaceIds(String reply) => reply.replaceAllMapped(
        RegExp(r'"surfaceId"\s*:\s*"([^"]*)"'),
        (m) => '"surfaceId":"s${++_surfaceCounter}-${m[1]}"',
      );

  /// Text to show while the reply is still streaming: everything before the
  /// first UI block, so raw JSON never flashes on screen.
  static String visibleWhileStreaming(String partial) {
    final start = partial.indexOf('<a2ui');
    return (start < 0 ? partial : partial.substring(0, start)).trim();
  }

  /// Remove UI blocks (complete or cut off) from a reply.
  static String stripUiBlocks(String reply) => reply
      .replaceAll(RegExp(r'<a2ui[\s\S]*?</a2ui[^>]*>'), '')
      .replaceAll(RegExp(r'<a2ui[\s\S]*$'), '')
      .trim();

  /// Forget all surfaces (new conversation).
  void reset() {
    for (final surface in renderer.model.allSurfaces.toList()) {
      renderer.model.deleteSurface(surface.id);
    }
    _state = _agent.createState();
  }

  void dispose() {
    for (final s in _subscriptions) {
      s.unsubscribe();
    }
    renderer.dispose();
  }
}
