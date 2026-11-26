import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:a2ui_flutter/basic_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';

const _members = <FormMember>[(id: 'u-ana', name: 'Ana'), (id: 'u-beto', name: 'Beto')];
const _recipes = [
  RecipeSummary(slug: 'locro', title: 'Locro', totalMinutes: 210, countryName: 'argentina'),
  RecipeSummary(slug: 'tortilla-de-papas', title: 'Tortilla de papas', totalMinutes: 50, omit: ['cebolla']),
];
const _prefs = [
  FoodPreference(id: 'p1', kind: 'dislike', ingredientId: 'remolacha', ingredientName: 'remolacha'),
  FoodPreference(id: 'p2', kind: 'allergy', allergen: 'gluten', memberId: 'u-beto', memberName: 'Beto'),
  FoodPreference(id: 'p3', kind: 'diet', dietTag: 'vegetariana'),
];

/// Every form the app can show, built with realistic data.
Map<String, List<Map<String, Object?>>> _allForms() => {
      'perfil': FoodForms.perfil('s1', members: _members, prefs: _prefs),
      'armarSemana': FoodForms.armarSemana('s2', weekStart: DateTime(2026, 11, 23)),
      'confirmarPreferencia': FoodForms.confirmarPreferencia('s3', members: _members, ingredient: 'remolacha'),
      'heladera': FoodForms.heladera('s4'),
      'aclararPedido': FoodForms.aclararPedido('s5'),
      'elegirReceta': FoodForms.elegirReceta('s6', recipes: _recipes),
      'elegirRecetaMenu': FoodForms.elegirReceta('s7', recipes: _recipes, day: DateTime(2026, 11, 26), meal: 'cena'),
      'cambiarComida': FoodForms.cambiarComida('s8', day: DateTime(2026, 11, 26), meal: 'cena', candidates: _recipes),
      'comensales': FoodForms.comensales('s9', slug: 'locro'),
      'valorar': FoodForms.valorar('s10', entryId: 'e1', title: 'Locro'),
      'invitados': FoodForms.invitados('s11'),
      'nuevaReceta': FoodForms.nuevaReceta('s12', title: 'Bizcochuelo', ingredientLines: ['4 huevos'], steps: ['Batir'], fromPhoto: true),
      'repasarPreferencias': FoodForms.repasarPreferencias('s13', prefs: _prefs),
      'repasarVacio': FoodForms.repasarPreferencias('s14', prefs: const []),
      'confirmar': FoodForms.confirmar('s15', message: '¿Borro el menú de la semana?', action: 'vaciar_semana', payload: {'fecha': '2026-11-23'}),
      'deEstacion': FoodForms.deEstacion('s16', ingredients: {'tomate': 'tomate', 'durazno': 'durazno'}),
    };

void main() {
  for (final entry in _allForms().entries) {
    test('form "${entry.key}" is valid A2UI and creates a surface', () {
      final created = <SurfaceModel<ComponentImplementation>>[];
      final errors = <Object>[];
      final renderer = MessageProcessor<ComponentImplementation>(
        catalogs: [basicCatalog(locale: 'es-AR')],
        defaultVersion: A2uiProtocolVersion.v1_0,
        onError: errors.add,
      );
      renderer.model.onSurfaceCreated.subscribe(created.add);
      renderer.processMessages(entry.value);
      expect(errors, isEmpty, reason: '$errors');
      expect(created, hasLength(1));
      renderer.dispose();
    });
  }

  testWidgets('the profile form renders, edits values and sends them on save', (tester) async {
    A2uiRendererAction? sent;
    final renderer = MessageProcessor<ComponentImplementation>(
      catalogs: [basicCatalog(locale: 'es-AR')],
      defaultVersion: A2uiProtocolVersion.v1_0,
    );
    final created = <SurfaceModel<ComponentImplementation>>[];
    renderer.model.onSurfaceCreated.subscribe(created.add);
    renderer.model.onAction.subscribe((a) => sent = a);
    renderer.processMessages(FoodForms.perfil('p', members: _members));

    tester.view.physicalSize = const Size(800, 3200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: A2uiSurface(surface: created.single))),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sin TACC'));
    await tester.tap(find.text('Maní'));
    await tester.tap(find.text('Beto'));
    await tester.enterText(find.widgetWithText(TextField, 'No nos gusta'), 'remolacha, hongos');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Guardar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    expect(sent?.name, FoodFormAction.perfil);
    expect(sent!.context['dietas'], ['sin_tacc']);
    expect(sent!.context['alergias'], ['mani']);
    expect(sent!.context['quien'], ['u-beto']);
    expect(sent!.context['no_gusta'], 'remolacha, hongos');
    expect(sent!.context['porciones'], 2);
    renderer.dispose();
  });
}
