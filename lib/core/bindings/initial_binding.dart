import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../domain/usecase/login_sendOtp_usecase.dart';
import '../di/service_locator.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {

    Get.put<LoginController>(
      LoginController(
        loginUseCase: sl<LoginUseCase>(),
      ),
      permanent: true,
    );

  }
}