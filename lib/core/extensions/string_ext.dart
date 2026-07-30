import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/api_routes.dart';


extension BulletText on String {
  String get bulletText {
    // Split by either literal "\n" or actual newline control characters
    var bulletPoints = split(RegExp(r'\\n|\n'));

    // Remove empty strings and trim each item
    bulletPoints = bulletPoints
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    // Format as bullet list
    return bulletPoints.map((item) => '• $item').join('\n');
  }
}



String formatTransactionDate(String isoDateString) {
  try {
    DateTime dateTime = DateTime.parse(isoDateString).toLocal();
    final DateFormat formatter = DateFormat('dd-MM-yyyy, hh:mm a');
    return formatter.format(dateTime);
  } catch (e) {
    debugPrint('Error formatting date: $e');
    return isoDateString;
  }
}

extension UrlHelper on String {
  String addToBase() {
    try {
      if (startsWith('http://') || startsWith('https://')) {
        return this;
      }

      final baseUrl = ApiRoutes.baseURL.split('/api').first;

      final formattedBase =
          baseUrl.endsWith('/')
              ? baseUrl.substring(0, baseUrl.length - 1)
              : baseUrl;

      final formattedPath =
          startsWith('/') ? substring(1) : this;

      return '$formattedBase/$formattedPath';
    } catch (e) {
      debugPrint('Error in addToBase: $e');
      return this;
    }
  }
}