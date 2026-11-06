import 'package:flutter_test/flutter_test.dart';

import 'package:currency_convert/currency_converter.dart';

void main() {
  test('converts between supported currencies', () {
    expect(
      CurrencyConverter.convert(amount: 10, fromCode: 'USD', toCode: 'AED'),
      closeTo(36.725, 0.0001),
    );
  });

  test('supports only USD, AED, and INR', () {
    expect(
      CurrencyConverter.currencies.keys,
      unorderedEquals(['USD', 'AED', 'INR']),
    );
  });
}
