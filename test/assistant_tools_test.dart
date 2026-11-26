import 'package:flutter_test/flutter_test.dart';
import 'package:nuestra_app/features/assistant/data/assistant_tools.dart';

void main() {
  group('parseAmount', () {
    final cases = <Object?, double?>{
      '15000': 15000,
      '1029.50': 1029.5,
      '1029,50': 1029.5,
      '1.029,50': 1029.5,
      '1,029.50': 1029.5,
      '15.000': 15000,
      '1.029.000': 1029000,
      '15,000': 15000,
      r'$ 15.000': 15000,
      '2500 ARS': 2500,
      42: 42,
      12.5: 12.5,
      // Garbled or ambiguous model output must not become a number
      '1.0,293': null,
      'mil pesos': null,
      '': null,
      null: null,
      '-500': null,
    };
    cases.forEach((input, expected) {
      test('"$input" -> $expected', () {
        expect(AssistantToolExecutor.parseAmount(input), expected);
      });
    });
  });
}
