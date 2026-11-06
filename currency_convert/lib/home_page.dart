import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'currency_converter.dart';
import 'widgets/convert_button.dart';
import 'widgets/currency_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'AED';
  double? _convertedAmount;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _convert() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      setState(() => _convertedAmount = null);
      return;
    }

    setState(() {
      _convertedAmount = CurrencyConverter.convert(
        amount: amount,
        fromCode: _fromCurrency,
        toCode: _toCurrency,
      );
    });
  }

  void _swapCurrencies() {
    setState(() {
      final previousFrom = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = previousFrom;
      _convertedAmount = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final from = CurrencyConverter.currencies[_fromCurrency]!;
    final to = CurrencyConverter.currencies[_toCurrency]!;
    final rate = CurrencyConverter.rate(
      fromCode: _fromCurrency,
      toCode: _toCurrency,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCECE5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.currency_exchange_rounded,
                          color: Color(0xFF176B5B),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'EXCHANGE',
                        style: TextStyle(
                          color: Color(0xFF176B5B),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Currency\nconverter',
                    style: TextStyle(
                      color: Color(0xFF182B27),
                      fontSize: 38,
                      height: 1.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A clearer view of your money, wherever it goes.',
                    style: TextStyle(color: Color(0xFF6D7B76), fontSize: 15),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFE5EAE6)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x10182B27),
                          blurRadius: 28,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'AMOUNT',
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
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          onChanged: (_) => setState(() {
                            _convertedAmount = null;
                          }),
                          style: const TextStyle(
                            color: Color(0xFF182B27),
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            prefixText: '${from.symbol} ',
                            prefixStyle: const TextStyle(
                              color: Color(0xFF82908A),
                              fontSize: 28,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(height: 18),
                        CurrencyPicker(
                          label: 'FROM',
                          value: _fromCurrency,
                          currencies: CurrencyConverter.currencies,
                          onChanged: (value) => setState(() {
                            _fromCurrency = value;
                            _convertedAmount = null;
                          }),
                        ),
                        Align(
                          heightFactor: 1,
                          child: IconButton.filledTonal(
                            key: const Key('swap-currencies'),
                            tooltip: 'Swap currencies',
                            onPressed: _swapCurrencies,
                            icon: const Icon(Icons.swap_vert_rounded),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFFEAF2EE),
                              foregroundColor: const Color(0xFF176B5B),
                            ),
                          ),
                        ),
                        CurrencyPicker(
                          label: 'TO',
                          value: _toCurrency,
                          currencies: CurrencyConverter.currencies,
                          onChanged: (value) => setState(() {
                            _toCurrency = value;
                            _convertedAmount = null;
                          }),
                        ),
                        const SizedBox(height: 20),
                        ConvertButton(onPressed: _convert),
                        if (_convertedAmount != null) ...[
                          const SizedBox(height: 22),
                          Container(
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
                                  '${to.symbol} ${_convertedAmount!.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Color(0xFF176B5B),
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '1 $_fromCurrency = ${rate.toStringAsFixed(4)} $_toCurrency  ·  Indicative rates',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF78847F),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
