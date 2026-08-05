import 'dart:convert';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/domain/usecase/web_login_usecase.dart';
import 'package:maxpay/domain/usecase/web_logout_usecase.dart';
import 'package:maxpay/controller/profile_controller.dart';

class WebLoginController extends GetxController {
  final WebLoginUseCase webLoginUseCase;
  final WebLogoutUseCase webLogoutUseCase;

  WebLoginController({
    required this.webLoginUseCase,
    required this.webLogoutUseCase,
  });

  RxBool isScanning = true.obs;
  RxBool isLoading = false.obs;

  Future<void> onQrScanned(String scannedData) async {
    if (!isScanning.value || isLoading.value) return;

    isScanning.value = false; // Stop processing further scans while validating
    isLoading.value = true;

    final profileController = Get.find<ProfileController>();
    final currentUserId = profileController.profileData.value?.userId;

    String? qrUserId;
    try {
      final map = jsonDecode(scannedData);
      qrUserId = map['qr_user_id'] ?? map['user_id'] ?? map['id'];
    } catch (e) {
      qrUserId = scannedData.trim();
    }

    if (qrUserId != null && qrUserId == currentUserId) {
      final result = await webLoginUseCase.call(qrUserId);
      result.fold(
        (failure) {
          CustomToast.error(failure.message);
          // Allow scanning again after failure
          Future.delayed(const Duration(seconds: 5), () {
            isScanning.value = true;
          });
        },
        (success) {
          CustomToast.success(success);
          Get.offNamed('/websuccess');
        },
      );
    } else {
      CustomToast.error("QR Code User ID does not match your current User ID.");
      // Allow scanning again after a delay
      Future.delayed(const Duration(seconds: 3), () {
        isScanning.value = true;
      });
    }

    isLoading.value = false;
  }

  Future<void> webLogout() async {
    if (isLoading.value) return;
    isLoading.value = true;

    final result = await webLogoutUseCase.call("0");
    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (success) {
        CustomToast.success(success);
        Get.back(); // Or navigate away from the success screen
      },
    );

    isLoading.value = false;
  }
}
