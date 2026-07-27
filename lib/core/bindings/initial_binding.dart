import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../domain/usecase/login_sendOtp_usecase.dart';
import '../../domain/usecase/verify_otp_usecase.dart';
import '../../domain/usecase/create_pin_usecase.dart';
import '../../domain/usecase/verify_pin_usecase.dart';
import '../../domain/usecase/update_fingerprint_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../di/service_locator.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {

    Get.put<LoginController>(
      LoginController(
        loginUseCase: sl<LoginUseCase>(),
        verifyOtpUseCase: sl<VerifyOtpUseCase>(),
        createPinUseCase: sl<CreatePinUseCase>(),
        verifyPinUseCase: sl<VerifyPinUseCase>(),
        updateFingerprintUseCase: sl<UpdateFingerprintUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
      ),
      permanent: true,
    );

  }
}