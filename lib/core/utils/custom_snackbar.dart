import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';

class CustomSnackbar {
  static void warning(String message, {String? title}) {
    Get.snackbar(
      title ?? "Warning",
      message,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange.withValues(alpha: 0.2),
      colorText: AppColors.clrTextblack,
      icon: const Icon(Icons.warning_rounded, color: Colors.orange),
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
      margin: const EdgeInsets.all(10),
      borderRadius: 12,
      borderWidth: 1,
      borderColor: Colors.orange.withValues(alpha: 0.5),
      overlayBlur: 0,
      overlayColor: Colors.black.withValues(alpha: 0.1),
    );
  }

  static void success(String message, {String? title}) {
    Get.snackbar(
      title ?? "Success",
      message,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withValues(alpha: 0.2),
      colorText: AppColors.clrTextblack,
      icon: const Icon(Icons.warning_rounded, color: Colors.green),
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
      margin: const EdgeInsets.all(10),
      borderRadius: 12,
      borderWidth: 1,
      borderColor: Colors.green.withValues(alpha: 0.5),
      overlayBlur: 0,
      overlayColor: Colors.black.withValues(alpha: 0.1),
    );
  }

  static void error(String message, {String? title}) {
    Get.snackbar(
      title ?? "Error",
      message,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withValues(alpha: 0.2),
      colorText: AppColors.clrTextblack,
      icon: const Icon(Icons.warning_rounded, color: Colors.red),
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
      margin: const EdgeInsets.all(10),
      borderRadius: 12,
      borderWidth: 1,
      borderColor: Colors.red.withValues(alpha: 0.5),
      overlayBlur: 0,
      overlayColor: Colors.black.withValues(alpha: 0.1),
    );
  }
}
