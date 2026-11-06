class Currency {
  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.unitsPerUsd,
  });

  final String code;
  final String name;
  final String symbol;
  final double unitsPerUsd;
}

class CurrencyConverter {
  static const currencies = <String, Currency>{
    'USD': Currency(
      code: 'USD',
      name: 'US Dollar',
      symbol: r'$',
      unitsPerUsd: 1,
    ),
    'AED': Currency(
      code: 'AED',
      name: 'UAE Dirham',
      symbol: 'د.إ',
      unitsPerUsd: 3.6725,
    ),
    'INR': Currency(
      code: 'INR',
      name: 'Indian Rupee',
      symbol: '₹',
      unitsPerUsd: 83.5,
    ),
  };

  static double convert({
    required double amount,
    required String fromCode,
    required String toCode,
  }) {
    return amount /
        currencies[fromCode]!.unitsPerUsd *
        currencies[toCode]!.unitsPerUsd;
  }

  static double rate({required String fromCode, required String toCode}) {
    return currencies[toCode]!.unitsPerUsd / currencies[fromCode]!.unitsPerUsd;
  }
}
