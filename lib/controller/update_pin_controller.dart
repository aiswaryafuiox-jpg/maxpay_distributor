import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../domain/usecase/update_pin_usecase.dart';
import '../domain/usecase/send_update_mpin_otp_usecase.dart';
import '../core/constants/routes_path.dart';

class UpdatePinController extends GetxController {
  final UpdatePinUseCase updatePinUseCase;
  final SendUpdateMpinOtpUseCase sendUpdateMpinOtpUseCase;

  UpdatePinController({
    required this.updatePinUseCase,
    required this.sendUpdateMpinOtpUseCase,
  });

  final otpController = TextEditingController();
  final newPinController = TextEditingController();
  final confirmPinController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isOtpLoading = false.obs;

  @override
  void dispose() {
    otpController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    isOtpLoading.value = true;
    final result = await sendUpdateMpinOtpUseCase();

    result.fold(
      (failure) {
        isOtpLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
      (successMessage) {
        isOtpLoading.value = false;
        Get.toNamed(AppRoutes.updateMpinOtp);
        Get.snackbar(
          "Success",
          successMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
  }

  void onOtpVerify() {
    if (otpController.text.length != 4) {
      Get.snackbar("Error", "Please enter a valid 4-digit OTP", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    // "Verify" just goes to the next page because there's no separate verify API
    Get.toNamed(AppRoutes.update);
  }

  Future<void> updatePin() async {
    final otp = otpController.text;
    final newPin = newPinController.text;
    final confirmPin = confirmPinController.text;

    if (newPin.isEmpty || confirmPin.isEmpty) {
      Get.snackbar("Error", "Please enter and confirm your new M-PIN", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (newPin.length != 4 || confirmPin.length != 4) {
      Get.snackbar("Error", "M-PIN must be exactly 4 digits", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (newPin != confirmPin) {
      Get.snackbar("Error", "M-PINs do not match", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    final result = await updatePinUseCase(otp, newPin, confirmPin);

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
      (successMessage) {
        isLoading.value = false;
        Get.offAllNamed('/menu'); // Or wherever they should go after success
        Get.snackbar(
          "Success",
          successMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
  }
}
