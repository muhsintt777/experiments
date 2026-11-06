import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyRate {
  const CurrencyRate({required this.value, required this.date});

  final double value;
  final String date;
}

class Currency {
  const Currency({required this.code, required this.name});

  final String code;
  final String name;
}

class CurrencyConverter {
  static const currencies = <String, Currency>{
    'USD': Currency(code: 'USD', name: 'US Dollar'),
    'AED': Currency(code: 'AED', name: 'UAE Dirham'),
    'INR': Currency(code: 'INR', name: 'Indian Rupee'),
  };

  static Future<CurrencyRate> rate({
    required String fromCode,
    required String toCode,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final cacheKey = 'frankfurter_rate_${fromCode}_$toCode';
    final checkedOn = _dateStamp(DateTime.now());
    final cachedValue = preferences.getString(cacheKey);

    if (cachedValue != null) {
      try {
        final cached = jsonDecode(cachedValue) as Map<String, dynamic>;
        if (cached['checkedOn'] == checkedOn &&
            cached['rate'] is num &&
            cached['date'] is String) {
          return CurrencyRate(
            value: (cached['rate'] as num).toDouble(),
            date: cached['date'] as String,
          );
        }
      } catch (_) {
        // Remove invalid cache data before fetching a fresh rate.
      }
      await preferences.remove(cacheKey);
    }

    if (fromCode == toCode) {
      return CurrencyRate(value: 1, date: checkedOn);
    }

    final uri = Uri.https('api.frankfurter.dev', '/v2/rates', {
      'base': fromCode.toLowerCase(),
      'quotes': toCode.toLowerCase(),
    });
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch exchange rate');
    }

    final body = jsonDecode(response.body) as List<dynamic>;
    final rateEntry = body.cast<Map<String, dynamic>>().firstWhere(
      (entry) => entry['base'] == fromCode && entry['quote'] == toCode,
      orElse: () => <String, dynamic>{},
    );
    final rateValue = rateEntry['rate'];
    final rateDate = rateEntry['date'];
    if (rateValue is! num || rateDate is! String) {
      throw FormatException('Rate for $toCode was not returned');
    }

    final rate = CurrencyRate(value: rateValue.toDouble(), date: rateDate);
    await preferences.setString(
      cacheKey,
      jsonEncode({
        'checkedOn': checkedOn,
        'date': rate.date,
        'rate': rate.value,
      }),
    );
    return rate;
  }

  static String _dateStamp(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
