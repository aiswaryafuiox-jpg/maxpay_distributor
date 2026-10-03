import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

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
  final trimmed = isoDateString.trim();
  if (trimmed.isEmpty || trimmed == '-') {
    return '-';
  }

  try {
    // 1. Try standard ISO-8601 parse first
    final isoParsed = DateTime.tryParse(trimmed);
    if (isoParsed != null) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy, hh:mm a');
      return formatter.format(isoParsed.toLocal());
    }

    // 2. Normalize attached AM/PM (e.g. 06:39:52PM -> 06:39:52 PM)
    final normalized = trimmed.replaceAllMapped(
      RegExp(r'(\d)(AM|PM|am|pm)', caseSensitive: false),
      (m) => '${m[1]} ${m[2]?.toUpperCase()}',
    );

    final List<String> patterns = [
      'dd.MM.yyyy hh:mm:ss a',
      'dd.MM.yyyy hh:mm a',
      'dd.MM.yyyy HH:mm:ss',
      'dd.MM.yyyy HH:mm',
      'dd.MM.yyyy',
      'dd-MM-yyyy, hh:mm:ss a',
      'dd-MM-yyyy, hh:mm a',
      'dd-MM-yyyy hh:mm:ss a',
      'dd-MM-yyyy hh:mm a',
      'dd-MM-yyyy HH:mm:ss',
      'dd-MM-yyyy HH:mm',
      'dd-MM-yyyy',
      'dd/MM/yyyy hh:mm:ss a',
      'dd/MM/yyyy hh:mm a',
      'dd/MM/yyyy HH:mm:ss',
      'dd/MM/yyyy HH:mm',
      'dd/MM/yyyy',
      'yyyy-MM-dd HH:mm:ss',
      'yyyy-MM-dd hh:mm:ss a',
      'yyyy-MM-dd hh:mm a',
      'yyyy/MM/dd HH:mm:ss',
      'yyyy.MM.dd HH:mm:ss',
    ];

    for (final pattern in patterns) {
      try {
        final parsed = DateFormat(pattern).parseLoose(normalized);
        final DateFormat formatter = DateFormat('dd-MM-yyyy, hh:mm a');
        return formatter.format(parsed);
      } catch (_) {}
    }

    return trimmed;
  } catch (e) {
    AppLogger.logError('Error formatting date: $e $isoDateString');
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

      final formattedBase = baseUrl.endsWith('/')
          ? baseUrl.substring(0, baseUrl.length - 1)
          : baseUrl;

      final formattedPath = startsWith('/') ? substring(1) : this;

      return '$formattedBase/$formattedPath';
    } catch (e) {
      debugPrint('Error in addToBase: $e');
      return this;
    }
  }
}
