import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../domain/usecase/login_sendOtp_usecase.dart';
import '../../domain/usecase/verify_otp_usecase.dart';
import '../../domain/usecase/create_pin_usecase.dart';
import '../../domain/usecase/verify_pin_usecase.dart';
import '../../domain/usecase/update_fingerprint_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/profile/get_profile_usecase.dart';
import '../../domain/usecase/profile/update_profile_usecase.dart';
import '../../domain/usecase/profile/verify_update_profile_otp_usecase.dart';
import '../../domain/usecase/profile/resend_update_profile_otp_usecase.dart';
import '../../domain/usecase/profile/update_status_send_otp_usecase.dart';
import '../../domain/usecase/profile/verify_update_status_otp_usecase.dart';
import '../../controller/profile_controller.dart';
import '../../controller/retailer_controller.dart';
import '../../domain/usecase/retailer/get_retailers_usecase.dart';
import '../../domain/usecase/retailer/get_retailer_detail_usecase.dart';
import '../../domain/usecase/retailer/get_commission_packages_usecase.dart';
import '../../domain/usecase/retailer/create_retailer_usecase.dart';
import '../../domain/usecase/retailer/update_retailer_usecase.dart';
import '../../domain/usecase/retailer/get_add_wallet_details_usecase.dart';
import '../../domain/usecase/retailer/add_wallet_usecase.dart';
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

    Get.put<ProfileController>(
      ProfileController(
        sl<GetProfileUseCase>(),
        sl<UpdateProfileUseCase>(),
        sl<VerifyUpdateProfileOtpUseCase>(),
        sl<ResendUpdateProfileOtpUseCase>(),
        sl<UpdateStatusSendOtpUseCase>(),
        sl<VerifyUpdateStatusOtpUseCase>(),
      ),
      permanent: true,
    );

    Get.put<RetailerController>(
      RetailerController(
        sl<GetRetailersUseCase>(),
        sl<GetRetailerDetailUseCase>(),
        sl<GetCommissionPackagesUseCase>(),
        sl<CreateRetailerUseCase>(),
        sl<UpdateRetailerUseCase>(),
        sl<GetAddWalletDetailsUseCase>(),
        sl<AddWalletUseCase>(),
      ),
      permanent: true,
    );
  }
}
