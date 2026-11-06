// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:currency_convert/main.dart';

void main() {
  testWidgets('converts an amount using the selected currencies', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('amount-input')), '10');
    final convertButton = find.widgetWithText(FilledButton, 'Convert');
    await tester.ensureVisible(convertButton);
    await tester.tap(convertButton);
    await tester.pumpAndSettle();

    expect(find.text('د.إ 36.73'), findsOneWidget);
    expect(find.byKey(const Key('conversion-result')), findsOneWidget);
  });

  testWidgets('amount input allows no more than two decimal places', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final input = find.byKey(const Key('amount-input'));

    await tester.enterText(input, '12.345');

    expect(tester.widget<TextField>(input).controller!.text, '12.34');
  });
}
