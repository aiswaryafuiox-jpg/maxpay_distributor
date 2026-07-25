import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../core/constants/routes_path.dart';
import '../domain/usecase/login_sendOtp_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController({
    required this.loginUseCase,
  });

  final phoneController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendOtp() async {
    try {
      isLoading.value = true;

      final response = await loginUseCase(
        phoneController.text.trim(),
      );

      isLoading.value = false;

      if (response.success == true) {
        Get.toNamed(
          AppRoutes.otpVerification,
          arguments: response,
        );
      } else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}