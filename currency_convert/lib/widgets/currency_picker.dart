import 'package:flutter/material.dart';

import '../currency_converter.dart';

class CurrencyPicker extends StatelessWidget {
  const CurrencyPicker({
    super.key,
    required this.label,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  final String label;
  final String value;
  final Map<String, Currency> currencies;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final currency = currencies[value]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5EAE6)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F6F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              currency.symbol,
              style: const TextStyle(
                color: Color(0xFF176B5B),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF78847F),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  currency.name,
                  style: const TextStyle(
                    color: Color(0xFF182B27),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: value,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: currencies.keys
                .map(
                  (code) => DropdownMenuItem(
                    value: code,
                    child: Text(
                      code,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                )
                .toList(),
            onChanged: (nextValue) {
              if (nextValue != null) onChanged(nextValue);
            },
          ),
        ],
      ),
    );
  }
}
