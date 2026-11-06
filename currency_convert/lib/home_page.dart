import 'package:flutter/material.dart';

import 'currency_converter.dart';
import 'widgets/amount_input.dart';
import 'widgets/convert_button.dart';
import 'widgets/conversion_result.dart';
import 'widgets/currency_pair_selector.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _amountController = TextEditingController();
  String _fromCurrency = 'AED';
  String _toCurrency = 'INR';
  double? _convertedAmount;
  double? _rate;
  String? _rateDate;
  bool _isLoadingRate = false;
  String? _rateError;
  int _rateRequestId = 0;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _convert() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        _convertedAmount = null;
        _rateError = 'Enter an amount greater than zero';
      });
      return;
    }

    final requestId = ++_rateRequestId;
    setState(() {
      _isLoadingRate = true;
      _convertedAmount = null;
      _rateError = null;
    });

    try {
      final rate = await CurrencyConverter.rate(
        fromCode: _fromCurrency,
        toCode: _toCurrency,
      );
      if (!mounted || requestId != _rateRequestId) return;
      setState(() {
        _rate = rate.value;
        _rateDate = rate.date;
        _convertedAmount = amount * rate.value;
        _isLoadingRate = false;
      });
    } catch (_) {
      if (!mounted || requestId != _rateRequestId) return;
      setState(() {
        _isLoadingRate = false;
        _rateError = 'Could not load the latest rate';
      });
    }
  }

  void _clearConversion() {
    _rateRequestId++;
    _rate = null;
    _rateDate = null;
    _convertedAmount = null;
    _isLoadingRate = false;
    _rateError = null;
  }

  void _swapCurrencies() {
    setState(() {
      final previousFrom = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = previousFrom;
      _clearConversion();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        ConversionResult(
                          amount: _convertedAmount,
                          currencyCode: _toCurrency,
                        ),
                        const SizedBox(height: 22),
                        CurrencyPairSelector(
                          currencies: CurrencyConverter.currencies,
                          fromCode: _fromCurrency,
                          toCode: _toCurrency,
                          onFromChanged: (value) {
                            setState(() {
                              _fromCurrency = value;
                              _clearConversion();
                            });
                          },
                          onToChanged: (value) {
                            setState(() {
                              _toCurrency = value;
                              _clearConversion();
                            });
                          },
                          onSwap: _swapCurrencies,
                        ),
                        const SizedBox(height: 18),
                        AmountInput(
                          controller: _amountController,
                          currencyCode: _fromCurrency,
                          onChanged: (_) => setState(() {
                            _convertedAmount = null;
                          }),
                        ),
                        const SizedBox(height: 20),
                        ConvertButton(
                          onPressed: _isLoadingRate ? null : _convert,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _isLoadingRate
                        ? 'Fetching latest rate...'
                        : _rateError ??
                              (_rate == null
                                  ? 'Press Convert to load the rate'
                                  : '1 $_fromCurrency = ${_rate!.toStringAsFixed(4)} $_toCurrency  ·  Rate date: $_rateDate'),
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
