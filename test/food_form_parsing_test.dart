import 'package:flutter_test/flutter_test.dart';
import 'package:nuestra_app/features/food/forms/food_form_handler.dart';

void main() {
  test('names split on commas, "y" and new lines', () {
    expect(splitNames('remolacha, hongos y coliflor'), ['remolacha', 'hongos', 'coliflor']);
    expect(splitNames('ajo\npuerro;  apio '), ['ajo', 'puerro', 'apio']);
    expect(splitNames('  '), isEmpty);
  });

  group('ingredient lines', () {
    final cases = {
      '200 g de azúcar': {'quantity': '200', 'unit': 'g', 'name': 'azúcar'},
      '4 huevos': {'quantity': '4', 'unit': '', 'name': 'huevos'},
      '1 1/2 tazas de harina leudante': {'quantity': '1 1/2', 'unit': 'tazas', 'name': 'harina leudante'},
      '½ cebolla': {'quantity': '½', 'unit': '', 'name': 'cebolla'},
      '2 dientes de ajo picados': {'quantity': '2', 'unit': 'dientes', 'name': 'ajo picados'},
      '1,5 kg de papas': {'quantity': '1,5', 'unit': 'kg', 'name': 'papas'},
      '- 3 cucharadas de aceite': {'quantity': '3', 'unit': 'cucharadas', 'name': 'aceite'},
      'sal a gusto': {'quantity': null, 'unit': 'a gusto', 'name': 'sal'},
      'pimienta c/n': {'quantity': null, 'unit': 'a gusto', 'name': 'pimienta'},
      'perejil': {'quantity': null, 'unit': 'a gusto', 'name': 'perejil'},
    };
    cases.forEach((line, expected) {
      test(line, () => expect(parseIngredientLine(line), expected));
    });
  });
}
