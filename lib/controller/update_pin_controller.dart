import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../domain/usecase/update_pin_usecase.dart';
import '../domain/usecase/send_update_mpin_otp_usecase.dart';
import '../domain/usecase/verify_update_mpin_otp_usecase.dart';
import '../core/constants/routes_path.dart';

class UpdatePinController extends GetxController {
  final UpdatePinUseCase updatePinUseCase;
  final SendUpdateMpinOtpUseCase sendUpdateMpinOtpUseCase;
  final VerifyUpdateMpinOtpUseCase verifyUpdateMpinOtpUseCase;

  UpdatePinController({
    required this.updatePinUseCase,
    required this.sendUpdateMpinOtpUseCase,
    required this.verifyUpdateMpinOtpUseCase,
  });

  final otpController = TextEditingController();
  final newPinController = TextEditingController();
  final confirmPinController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isOtpLoading = false.obs;
  RxBool isOtpVerifying = false.obs;

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

  Future<void> onOtpVerify() async {
    final otp = otpController.text.trim();
    if (otp.length != 4) {
      Get.snackbar(
        "Error",
        "Please enter a valid 4-digit OTP",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isOtpVerifying.value = true;
    final result = await verifyUpdateMpinOtpUseCase(otp);

    result.fold(
      (failure) {
        isOtpVerifying.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
      (successMessage) {
        isOtpVerifying.value = false;
        Get.toNamed(AppRoutes.update);
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

  Future<void> updatePin() async {
    final newPin = newPinController.text.trim();
    final confirmPin = confirmPinController.text.trim();

    if (newPin.isEmpty || confirmPin.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter and confirm your new M-PIN",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (newPin.length != 4 || confirmPin.length != 4) {
      Get.snackbar(
        "Error",
        "M-PIN must be exactly 4 digits",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (newPin != confirmPin) {
      Get.snackbar(
        "Error",
        "M-PINs do not match",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    final result = await updatePinUseCase(newPin, confirmPin);

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
        Get.offAllNamed(AppRoutes.main);
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
