import 'package:flutter/material.dart';

class ConversionResult extends StatelessWidget {
  const ConversionResult({
    super.key,
    required this.amount,
    required this.currencyCode,
  });

  final double? amount;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('conversion-result'),
      // height: 100,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F6F2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 44,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    amount == null
                        ? '--'
                        : '$currencyCode ${amount!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF176B5B),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
