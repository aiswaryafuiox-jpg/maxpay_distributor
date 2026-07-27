import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/login_controller.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/sim_util.dart';
import 'package:maxpay/core/utils/snackbar.dart';



import 'package:shared_preferences/shared_preferences.dart';

class AppLifecycleController extends GetxController
    with WidgetsBindingObserver {
  static const String _keyLastActive = "last_active_time";

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  /// Returns true if the time interval between [lastActive] and [current]
  /// crosses at least one daily boundary: 6:00 AM, 12:00 PM, 6:00 PM, or 12:00 AM (00:00).
  static bool hasCrossedLogoutTime(DateTime lastActive, DateTime current) {
    if (current.difference(lastActive).inHours >= 24) {
      return true;
    }

    final datesToCheck = [
      DateTime(lastActive.year, lastActive.month, lastActive.day),
      DateTime(current.year, current.month, current.day),
    ];

    // Fixed daily boundary hours: 12 AM (0), 6 AM (6), 12 PM (12), 6 PM (18)
    final hours = [0, 6, 12, 18];

    for (final date in datesToCheck) {
      for (final hour in hours) {
        final boundary = DateTime(date.year, date.month, date.day, hour);
        // If a boundary time occurred after lastActive and before or at current,
        // it means we have crossed a logout boundary.
        if (boundary.isAfter(lastActive) && !boundary.isAfter(current)) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    AppLogger.logError("AppLifecycleState changed to: $state");

    final prefs = await SharedPreferences.getInstance();

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // Save last active time when the app goes into the background
      await prefs.setString(
        _keyLastActive,
        DateTime.now().toIso8601String(),
      );
      AppLogger.logError(
        "Saved last active time: ${DateTime.now().toIso8601String()}",
      );
    } else if (state == AppLifecycleState.resumed) {
      final token = prefs.getString("token");
      final loggedInPhone = prefs.getString("logged_in_phone");

      // 1. Verify SIM binding if user is logged in
      if (token != null && token.isNotEmpty && loggedInPhone != null && loggedInPhone.isNotEmpty) {
        final bool isSimValid = await SimUtil.verifySimPresent(loggedInPhone);
        if (!isSimValid) {
          AppLogger.logError("SIM Binding Failed on Resume. Calling backend logout API and clearing data.");
          CustomToast.error("The already logged number doesn't exist in device");
          
          if (Get.isRegistered<LoginController>()) {
            await Get.find<LoginController>().forceLogout();
          } else {
            await prefs.clear();
            Get.offAllNamed(AppRoutes.intro);
          }
          return; // Stop further checks
        }
      }

      // 2. Check if a logout boundary was crossed when resuming
      if (token != null && token.isNotEmpty) {
        final lastActiveStr = prefs.getString(_keyLastActive);
        if (lastActiveStr != null) {
          final lastActive = DateTime.tryParse(lastActiveStr);
          if (lastActive != null) {
            final crossed = hasCrossedLogoutTime(lastActive, DateTime.now());
            AppLogger.logError(
              "App resumed. Last active: $lastActive, Current: ${DateTime.now()}. Crossed boundary: $crossed",
            );

            if (crossed) {
              AppLogger.logError(
                "Logout boundary crossed. Automatically logging out.",
              );
              
              if (Get.isRegistered<LoginController>()) {
                await Get.find<LoginController>().forceLogout();
              } else {
                await prefs.remove("token");
                Get.offAllNamed(AppRoutes.loginPhoneName);
              }
            }
          }
        }
      }
    }
  }
}
