import 'package:flutter/foundation.dart' as foundation;
import 'dart:convert';
import 'dart:developer';

class AppLogger {
  static String _formatValue(dynamic value) {
    if (value is Map || value is List) {
      try {
        return const JsonEncoder.withIndent('  ').convert(value);
      } catch (_) {
        return value.toString();
      }
    }
    return value.toString();
  }

  static void debugPrint(dynamic value) {
    if (foundation.kDebugMode) {
      foundation.debugPrint(_formatValue(value));
    }
  }

  static void logError(dynamic value) {
    if (foundation.kDebugMode) {
      log(_formatValue(value));
    }
  }
}
