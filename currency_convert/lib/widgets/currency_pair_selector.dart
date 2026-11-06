import 'package:flutter/material.dart';

import '../currency_converter.dart';
import 'currency_picker.dart';

class CurrencyPairSelector extends StatelessWidget {
  const CurrencyPairSelector({
    super.key,
    required this.currencies,
    required this.fromCode,
    required this.toCode,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onSwap,
  });

  final Map<String, Currency> currencies;
  final String fromCode;
  final String toCode;
  final ValueChanged<String> onFromChanged;
  final ValueChanged<String> onToChanged;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CurrencyPicker(
            value: fromCode,
            currencies: currencies,
            onChanged: onFromChanged,
          ),
        ),
        IconButton.filledTonal(
          key: const Key('swap-currencies'),
          tooltip: 'Swap currencies',
          onPressed: onSwap,
          icon: const Icon(Icons.swap_horiz_rounded),
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFEAF2EE),
            foregroundColor: const Color(0xFF176B5B),
          ),
        ),
        Expanded(
          child: CurrencyPicker(
            value: toCode,
            currencies: currencies,
            onChanged: onToChanged,
          ),
        ),
      ],
    );
  }
}
