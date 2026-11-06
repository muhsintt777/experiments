import 'package:flutter/material.dart';

import '../currency_converter.dart';

class CurrencyPicker extends StatelessWidget {
  const CurrencyPicker({
    super.key,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  final String value;
  final Map<String, Currency> currencies;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5EAE6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: currencies.keys
            .map(
              (code) => DropdownMenuItem(
                value: code,
                child: Text(
                  code,
                  style: const TextStyle(
                    color: Color(0xFF182B27),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (nextValue) {
          if (nextValue != null) onChanged(nextValue);
        },
      ),
    );
  }
}
