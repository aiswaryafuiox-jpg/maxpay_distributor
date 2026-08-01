import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/profile_controller.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

import '../core/constants/routes_path.dart';
import '../domain/usecase/login_send_otp_usecase.dart';
import '../domain/usecase/verify_otp_usecase.dart';
import '../domain/usecase/create_pin_usecase.dart';
import '../domain/usecase/verify_pin_usecase.dart';
import '../domain/usecase/update_fingerprint_usecase.dart';
import '../domain/usecase/logout_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final CreatePinUseCase createPinUseCase;
  final VerifyPinUseCase verifyPinUseCase;
  final UpdateFingerprintUseCase updateFingerprintUseCase;
  final LogoutUseCase logoutUseCase;

  final LocalAuthentication auth = LocalAuthentication();

  LoginController({
    required this.loginUseCase,
    required this.verifyOtpUseCase,
    required this.createPinUseCase,
    required this.verifyPinUseCase,
    required this.updateFingerprintUseCase,
    required this.logoutUseCase,
  });

  final phoneController = TextEditingController();
  final isLoading = false.obs;

  final storage = LocalStorageService();

  int mpinAttempts = 0;

  final isNewUser = 0.obs;
  final isPin = 0.obs;
  final isFingerPrint = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocalData();
  }

  Future<void> _loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    isNewUser.value = prefs.getInt("is_new_user") ?? 0;
    isPin.value = prefs.getInt("is_pin") ?? 0;
    isFingerPrint.value = prefs.getInt("is_finger_print") ?? 0;
  }

  Future<void> sendOtp() async {
    isLoading.value = true;
    final result = await loginUseCase(phoneController.text.trim());
    isLoading.value = false;

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (response) {
        if (response.success == true) {
          Get.toNamed(AppRoutes.otpVerification, arguments: response);
        } else {
          CustomToast.error(response.message ?? "Something went wrong");
        }
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    isLoading.value = true;
    final result = await verifyOtpUseCase(phoneController.text.trim(), otp);
    isLoading.value = false;

    await result.fold(
      (failure) async {
        CustomToast.error(failure.message);
      },
      (response) async {
        if (response.success == true && response.data != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", response.data!.token ?? "");
          await prefs.setInt("is_new_user", response.data!.isNewUser ?? 0);
          await prefs.setInt("is_pin", response.data!.isPin ?? 0);
          await prefs.setInt(
            "is_finger_print",
            response.data!.isFingerPrint ?? 0,
          );
          await prefs.setString(
            "last_active_time",
            DateTime.now().toIso8601String(),
          );

          isNewUser.value = response.data!.isNewUser ?? 0;
          isPin.value = response.data!.isPin ?? 0;
          isFingerPrint.value = response.data!.isFingerPrint ?? 0;

          if (isPin.value == 1) {
            Get.toNamed(AppRoutes.enterPin);
          } else {
            Get.toNamed(AppRoutes.pinCodeCreation);
          }
        } else {
          CustomToast.error(response.message ?? "Invalid OTP");
        }
      },
    );
  }

  Future<void> createPin(String pin) async {
    isLoading.value = true;
    final result = await createPinUseCase(pin);
    isLoading.value = false;

    await result.fold(
      (failure) async {
        CustomToast.error(failure.message);
      },
      (response) async {
        if (response.success == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt("is_pin", 1);
          await prefs.setString(
            "last_active_time",
            DateTime.now().toIso8601String(),
          );

          isPin.value = 1;

          Get.toNamed(AppRoutes.successScreen);
        } else {
          CustomToast.error(response.message ?? "Failed to create PIN");
        }
      },
    );
  }

  Future<bool> verifyPin(String pin) async {
    isLoading.value = true;
    final result = await verifyPinUseCase(pin);
    isLoading.value = false;

    return await result.fold(
      (failure) async {
        return await _handleFailedPin(failure.message);
      },
      (response) async {
        if (response.success == true) {
          mpinAttempts = 0;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            "last_active_time",
            DateTime.now().toIso8601String(),
          );
          await Get.find<ProfileController>().fetchProfile();
          Get.offAllNamed(AppRoutes.main);
          return true;
        } else {
          return await _handleFailedPin(response.message ?? "Incorrect PIN");
        }
      },
    );
  }

  Future<bool> _handleFailedPin(String message) async {
    mpinAttempts++;
    if (mpinAttempts >= 3) {
      mpinAttempts = 0;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      Get.offAllNamed(AppRoutes.loginPhoneName);
      Get.snackbar(
        "Session Expired",
        "Too many failed attempts. Please login again.",
      );
      return false;
    } else {
      Get.snackbar("Error", "$message. ${3 - mpinAttempts} attempts left.");
      return false;
    }
  }

  Future<void> authenticateWithFingerprint() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      if (!canAuthenticate) {
        Get.snackbar('Info', 'Biometrics not supported on this device.');
        return;
      }

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        biometricOnly: true,
      );

      if (didAuthenticate) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'last_active_time',
          DateTime.now().toIso8601String(),
        );
        await Get.find<ProfileController>().fetchProfile();
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      Get.snackbar('Error', 'Authentication failed: $e');
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    final result = await logoutUseCase();
    isLoading.value = false;

    await result.fold(
      (failure) async {
        AppLogger.logError("Logout FAILURE : ${failure.message}");
        CustomToast.error(failure.message);
        await _clearSessionAndNavigate();
      },
      (response) async {
        AppLogger.logError("=========== Logout RESPONSE ===========");
        AppLogger.logError("ðŸ‘SUCCESS : $response");
        AppLogger.logError("===========================================");

        if (response.success == true) {
          CustomToast.success("Logout Successfully");
          await _clearSessionAndNavigate();
        } else {
          CustomToast.error("Logout Failed");
        }
      },
    );
  }

  Future<void> _clearSessionAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("is_new_user");
    await prefs.remove("is_pin");
    await prefs.remove("is_finger_print");
    await prefs.remove("last_active_time");

    phoneController.clear();
    Get.offAllNamed(AppRoutes.loginPhoneName);

    try {
      Get.find<NavbarController>().setIndex(0);
    } catch (_) {}
  }

  /// Forces a complete local logout and attempts to call the backend logout API.
  /// This ensures that even if the API fails (e.g. no internet), local tokens are wiped securely.
  Future<void> forceLogout() async {
    AppLogger.logError("Attempting forced backend logout...");
    final result = await logoutUseCase();

    result.fold(
      (failure) {
        AppLogger.logError("Forced backend logout failed: ${failure.message}");
      },
      (response) {
        AppLogger.logError("Forced backend logout success.");
      },
    );

    // Regardless of API success, clear local tokens completely
    await _clearSessionAndNavigate();
  }

  Future<void> toggleFingerprint(bool isEnabled) async {
    final status = isEnabled ? 1 : 0;
    final result = await updateFingerprintUseCase(status);

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (response) async {
        if (response.success == true) {
          isFingerPrint.value = status;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('is_finger_print', status);
          CustomToast.success(
            response.message ?? 'Fingerprint updated successfully',
          );
        } else {
          CustomToast.error(
            response.message ?? 'Failed to update fingerprint settings',
          );
        }
      },
    );
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
