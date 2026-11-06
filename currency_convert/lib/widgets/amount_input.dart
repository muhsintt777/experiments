import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({
    super.key,
    required this.controller,
    required this.currencySymbol,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String currencySymbol;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'ENTER AMOUNT',
          style: TextStyle(
            color: Color(0xFF78847F),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          key: const Key('amount-input'),
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          onChanged: onChanged,
          style: const TextStyle(
            color: Color(0xFF182B27),
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: '0.00',
            prefixText: '$currencySymbol ',
            prefixStyle: const TextStyle(
              color: Color(0xFF82908A),
              fontSize: 28,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
