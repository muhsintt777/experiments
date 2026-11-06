import 'package:flutter_test/flutter_test.dart';

import 'package:currency_convert/currency_converter.dart';

void main() {
  test('supports only USD, AED, and INR', () {
    expect(
      CurrencyConverter.currencies.keys,
      unorderedEquals(['USD', 'AED', 'INR']),
    );
  });
}
