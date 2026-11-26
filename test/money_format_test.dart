import 'package:flutter_test/flutter_test.dart';
import 'package:nuestra_app/core/utils/money_format.dart';

void main() {
  const money = MoneyFormat();
  const nbsp = ' ';

  test('whole amounts have no cents, sign first', () {
    expect(money.format(48210), '\$${nbsp}48.210');
    expect(money.format(100000.0), '\$${nbsp}100.000');
    expect(money.format(0), '\$${nbsp}0');
  });

  test('cents use a comma', () {
    expect(money.format(12500.5), '\$${nbsp}12.500,50');
    expect(money.format(1029.05), '\$${nbsp}1.029,05');
  });

  test('negative amounts', () {
    expect(money.format(-300), '-\$${nbsp}300');
  });
}
