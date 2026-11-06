import 'package:flutter/material.dart';

class ConversionResult extends StatelessWidget {
  const ConversionResult({
    super.key,
    required this.amount,
    required this.currencySymbol,
  });

  final double amount;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('conversion-result'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F6F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOU RECEIVE',
            style: TextStyle(
              color: Color(0xFF6D7B76),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$currencySymbol ${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Color(0xFF176B5B),
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
