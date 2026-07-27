import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  static String _formatValue(dynamic value) {
    if (value is Map || value is List) {
      try {
        return const JsonEncoder.withIndent('  ').convert(value);
      } catch (e) {
        return value.toString();
      }
    } else if (value is String) {
      return value;
    } else if (value is num) {
      return value.toString();
    } else {
      return value.toString();
    }
  }

  static void debugPrint(dynamic value) {
    if (kDebugMode) {
      print(_formatValue(value));
    }
  }

  static void logError(dynamic value) {
    if (kDebugMode) {
      log(_formatValue(value));
    }
  }
}
