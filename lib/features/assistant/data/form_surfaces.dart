import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:a2ui_flutter/basic_catalog.dart';
import 'package:flutter/foundation.dart';

/// Renders the app's own A2UI forms (the food forms) inside the chat and
/// reports their buttons through [onAction]. The model never writes A2UI.
class FormSurfaces {
  final void Function(A2uiRendererAction action) onAction;

  final MessageProcessor<ComponentImplementation> _renderer = MessageProcessor<ComponentImplementation>(
    catalogs: [basicCatalog(locale: 'es-AR')],
    defaultVersion: A2uiProtocolVersion.v1_0,
  );

  final List<SurfaceModel<ComponentImplementation>> _created = [];
  late final List<Subscription> _subscriptions;
  int _counter = 0;

  FormSurfaces({required this.onAction}) {
    _subscriptions = [
      _renderer.model.onSurfaceCreated.subscribe(_created.add),
      _renderer.model.onAction.subscribe(onAction),
    ];
  }

  /// Build [form] on a new surface and return it (null if it was invalid).
  SurfaceModel<ComponentImplementation>? render(List<Map<String, Object?>> Function(String surfaceId) form) {
    _created.clear();
    try {
      _renderer.processMessages(form('form-${DateTime.now().millisecondsSinceEpoch}-${++_counter}'));
    } catch (e) {
      debugPrint('Form render error: $e');
    }
    final surface = _created.isEmpty ? null : _created.last;
    _created.clear();
    return surface;
  }

  /// Forget every form (new conversation).
  void reset() {
    for (final surface in _renderer.model.allSurfaces.toList()) {
      _renderer.model.deleteSurface(surface.id);
    }
  }

  void dispose() {
    for (final s in _subscriptions) {
      s.unsubscribe();
    }
    _renderer.dispose();
  }
}
