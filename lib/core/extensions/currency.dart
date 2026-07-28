import 'package:intl/intl.dart';

extension CurrencyHelper on String {
  String get currencyIndian {
    final cleanedAmount = trim().replaceAll(RegExp(r'[^0-9.-]'), '');
    final parsedAmount = double.tryParse(cleanedAmount);

    return NumberFormat.currency(
      locale: "en_IN",
      symbol: "\u20B9 ",
      decimalDigits: 2,
    ).format(parsedAmount ?? 0);
  }

}
