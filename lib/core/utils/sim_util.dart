import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class SimUtil {
  /// Test numbers exception list
  static const List<String> testNumbers = [
    '9999999999',
    '7200251365',
    '9876541302',
  ];

  /// Helper function to normalize and match
  static bool _matches(String entered, String? sim) {
    if (sim == null || sim.isEmpty) return false;
    final cleanEntered = entered.replaceAll(RegExp(r'\D'), '');
    final cleanSim = sim.replaceAll(RegExp(r'\D'), '');
    if (cleanEntered.isEmpty || cleanSim.isEmpty) return false;

    // Match last 10 digits if both have at least 10 digits
    if (cleanEntered.length >= 10 && cleanSim.length >= 10) {
      return cleanEntered.substring(cleanEntered.length - 10) ==
          cleanSim.substring(cleanSim.length - 10);
    }

    // If any part of the number is visible (e.g., SIM returns fewer than 10 digits),
    // compare it with the exact position (usually the end) of the entered number.
    if (cleanEntered.endsWith(cleanSim)) {
      return true;
    }

    return cleanEntered == cleanSim;
  }

  /// Verifies if the [registeredPhone] is currently present in the device's SIM slots.
  /// Returns [true] if:
  /// 1. The phone is in the test numbers list.
  /// 2. The phone matches an active SIM.
  /// 3. SIMs are present but none return a readable phone number (fallback).
  ///
  /// Returns [false] if:
  /// 1. Permission is denied.
  /// 2. No SIM is inserted.
  /// 3. The phone number doesn't match any of the readable SIMs.
  ///
  /// Set [showToasts] to true to display error messages via CustomToast (e.g. during login).
  static const _simChannel = MethodChannel('sim_verification');

  /// Verifies if the [registeredPhone] is currently present in the device's SIM slots.
  /// Uses the new custom MethodChannel 'sim_verification' implemented in MainActivity.kt
  static Future<bool> verifySimPresent(
    String registeredPhone, {
    bool showToasts = false,
  }) async {
    final enteredPhone = registeredPhone.trim();

    if (testNumbers.contains(enteredPhone)) {
      return true; // Bypass for test numbers
    }

    // 1. Request phone permission
    var status = await Permission.phone.status;
    if (!status.isGranted && !status.isLimited) {
      status = await Permission.phone.request();
    }

    if (!status.isGranted && !status.isLimited) {
      if (showToasts) {
        CustomToast.error(
          "Phone permission is required to verify the SIM card",
        );
      }
      return false;
    }

    // 2. Fetch SIM info using MethodChannel
    try {
      final List<dynamic>? simList = await _simChannel.invokeMethod(
        'getSimList',
      );
      AppLogger.logError(
        "Detected SIM cards via channel: ${simList?.length ?? 0}",
      );

      if (simList == null || simList.isEmpty) {
        if (showToasts) {
          CustomToast.error("No SIM card detected in this device");
        }
        return false;
      }

      int readableSimsCount = 0;
      bool numberMatched = false;

      for (var sim in simList) {
        final Map<dynamic, dynamic> simData = sim as Map<dynamic, dynamic>;
        final String? phoneNumber = simData['number']?.toString().trim();

        AppLogger.logError(
          "SIM slot=${simData['slotIndex']}, carrier=${simData['carrierName']}, number=$phoneNumber",
        );

        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          readableSimsCount++;
          if (_matches(enteredPhone, phoneNumber)) {
            numberMatched = true;
            break;
          }
        }
      }

      // If we found a direct match on any readable SIM, permit immediately.
      if (numberMatched) {
        AppLogger.logError(
          "SIM check passed: Phone number matched active SIM.",
        );
        return true;
      }

      // If NOT all inserted SIMs returned readable numbers (e.g. carrier did not store MSISDN on SIM hardware),
      // we allow the login/session to proceed because at least one active SIM card exists whose number cannot be read by Android OS.
      // Ownership is then securely verified through OTP / SMS.
      final int totalSimsCount = simList.length;
      if (readableSimsCount < totalSimsCount) {
        AppLogger.logError(
          "SIM check fallback: $readableSimsCount of $totalSimsCount SIMs returned readable numbers. Permitting operation.",
        );
        return true;
      }

      // If ALL inserted SIMs returned readable phone numbers and NONE of them matched the entered phone:
      AppLogger.logError(
        "SIM check failed: None of the $totalSimsCount readable SIM cards matched $enteredPhone.",
      );
      if (showToasts) {
        CustomToast.error(
          "The entered mobile number does not exist on this device",
        );
      }
      return false;
    } catch (e) {
      AppLogger.logError("Failed to get SIM list via channel: $e");
      if (showToasts) {
        CustomToast.error("Failed to verify SIM card");
      }
      return false;
    }
  }
}
