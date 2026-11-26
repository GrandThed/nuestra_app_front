import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuestra_app/features/assistant/data/a2ui_bridge.dart';

/// The worked example from the prompt, as the model would echo it.
String _exampleBlock() {
  final instructions = A2uiBridge.compactInstructions;
  return instructions.substring(instructions.lastIndexOf('<a2ui-json>'));
}

void main() {
  test('compact UI instructions stay small for the on-device context', () {
    // ~4 chars per token: keep it under ~700 tokens
    expect(A2uiBridge.compactInstructions.length, lessThan(2800),
        reason: 'chars: ${A2uiBridge.compactInstructions.length}');
    // The library's own prompt is far larger; this is why it is not used.
    final bridge = A2uiBridge(onAction: (_) {});
    expect(bridge.fullSchemaPrompt.length, greaterThan(10000));
    bridge.dispose();
  });

  test('strips UI blocks while streaming and after errors', () {
    expect(A2uiBridge.visibleWhileStreaming('Hola! <a2ui-json>{"crea'), 'Hola!');
    expect(
      A2uiBridge.stripUiBlocks('Antes <a2ui-json>{}</a2ui-json> después'),
      'Antes  después',
    );
    expect(A2uiBridge.stripUiBlocks('Texto <a2ui-json>{"cortado'), 'Texto');
  });

  test('plain text reply passes through', () {
    final bridge = A2uiBridge(onAction: (_) {});
    final parts = bridge.parseReply('Gastaste \$ 120.000 este mes.');
    expect(parts, hasLength(1));
    expect((parts.single as ReplyText).text, 'Gastaste \$ 120.000 este mes.');
    bridge.dispose();
  });

  test('broken UI JSON keeps the text and never throws', () {
    final bridge = A2uiBridge(onAction: (_) {});
    final parts =
        bridge.parseReply('Mirá: <a2ui-json>{"version": "1.0", "createSurf');
    expect(parts.whereType<ReplySurface>(), isEmpty);
    expect(parts.whereType<ReplyText>().map((p) => p.text).join(), contains('Mirá'));
    bridge.dispose();
  });

  test('the prompt example is valid A2UI and creates one surface', () {
    final bridge = A2uiBridge(onAction: (_) {});
    final parts = bridge.parseReply('Este mes gastaron esto:\n${_exampleBlock()}');
    expect(parts.first, isA<ReplyText>());
    expect(parts.whereType<ReplySurface>(), hasLength(1));
    bridge.dispose();
  });

  test('the model reusing a surface id still renders a new card', () {
    final bridge = A2uiBridge(onAction: (_) {});
    bridge.parseReply(_exampleBlock());
    final again = bridge.parseReply('Otra vez ${_exampleBlock()}');
    expect(again.whereType<ReplyText>(), isNotEmpty);
    expect(again.whereType<ReplySurface>(), hasLength(1));
    bridge.dispose();
  });

  testWidgets('the example renders and its button reports an action',
      (tester) async {
    A2uiRendererAction? tapped;
    final bridge = A2uiBridge(onAction: (a) => tapped = a);
    final surface = bridge
        .parseReply(_exampleBlock())
        .whereType<ReplySurface>()
        .single
        .surface;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: A2uiSurface(key: ObjectKey(surface), surface: surface),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Supermercado'), findsOneWidget);
    expect(find.text('Total: \$ 158.600'), findsOneWidget);

    await tester.tap(find.text('Ver gastos'));
    await tester.pumpAndSettle();
    expect(tapped?.name, 'listar_gastos');
    expect(tapped?.context['mes'], '2026-11');
    bridge.dispose();
  });
}
