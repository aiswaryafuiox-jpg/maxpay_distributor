
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_card_code/sim_card_code.dart';

class SimUtil {
  /// Test numbers exception list
  static const List<String> testNumbers = ['9999999999', '8098309901'];

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
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (!status.isGranted) {
      if (showToasts) {
        CustomToast.error(
          "Phone permission is required to verify the SIM card",
        );
      }
      return false;
    }

    // 2. Fetch SIM info
    final sims = await SimCardManager.allSimInfo;
    AppLogger.logError("Detected SIM cards: ${sims.length}");

    if (sims.isEmpty) {
      if (showToasts) {
        CustomToast.error("No SIM card detected in this device");
      }
      return false;
    }

    bool numberExists = false;

    for (var sim in sims) {
      AppLogger.logError(
        "SIM slot=${sim.slotIndex}, carrier=${sim.carrierName}, number=${sim.phoneNumber}",
      );
      if (sim.phoneNumber != null && sim.phoneNumber!.isNotEmpty) {
        if (_matches(enteredPhone, sim.phoneNumber)) {
          numberExists = true;
          break;
        }
      }
    }

    // Also check the default phoneNumber getter
    final defaultNumber = await SimCardManager.phoneNumber;
    AppLogger.logError("Default SIM phone number: $defaultNumber");
    if (defaultNumber != null && defaultNumber.isNotEmpty) {
      if (_matches(enteredPhone, defaultNumber)) {
        numberExists = true;
      }
    }

    // Strictly block if a number isn't found
    if (!numberExists) {
      if (showToasts) {
        CustomToast.error(
          "The entered mobile number does not exist on this device",
        );
      }
      return false;
    }

    return true;
  }
}
