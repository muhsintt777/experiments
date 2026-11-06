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
    return Column(
      children: [
        CurrencyPicker(
          label: 'FROM',
          value: fromCode,
          currencies: currencies,
          onChanged: onFromChanged,
        ),
        Align(
          heightFactor: 1,
          child: IconButton.filledTonal(
            key: const Key('swap-currencies'),
            tooltip: 'Swap currencies',
            onPressed: onSwap,
            icon: const Icon(Icons.swap_vert_rounded),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFEAF2EE),
              foregroundColor: const Color(0xFF176B5B),
            ),
          ),
        ),
        CurrencyPicker(
          label: 'TO',
          value: toCode,
          currencies: currencies,
          onChanged: onToChanged,
        ),
      ],
    );
  }
}
