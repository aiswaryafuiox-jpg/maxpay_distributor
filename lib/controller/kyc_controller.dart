import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/kyc_model.dart';
import 'package:maxpay/domain/usecase/kyc/get_kyc_usecase.dart';

import 'package:maxpay/domain/usecase/kyc/submit_kyc_usecase.dart';

class KycController extends GetxController {
  final GetKycUseCase getKycUseCase;
  final SubmitKycUseCase submitKycUseCase;

  KycController(this.getKycUseCase, this.submitKycUseCase);

  var isLoading = false.obs;
  var isSubmitting = false.obs;
  var kycData = Rxn<KycData>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKyc();
  }

  Future<void> fetchKyc() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getKycUseCase.call();

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        AppLogger.logError("Failed to fetch KYC: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          kycData.value = data.data;
        } else if (data.message != null) {
          errorMessage.value = data.message!;
        }
      },
    );
  }

  Future<void> submitKyc({
    required String email,
    required String whatsappNumber,
    String? cancelledCheckPath,
    String? gstNoPath,
    String? panPath,
  }) async {
    isSubmitting.value = true;
    
    final result = await submitKycUseCase.call(
      email: email,
      whatsappNumber: whatsappNumber,
      cancelledCheckPath: cancelledCheckPath,
      gstNoPath: gstNoPath,
      panPath: panPath,
    );

    result.fold(
      (failure) {
        isSubmitting.value = false;
        AppLogger.logError("Failed to submit KYC: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isSubmitting.value = false;
        Get.snackbar("Success", data.message ?? "KYC submitted successfully");
        if (data.data != null) {
          kycData.value = data.data;
        } else {
          // Re-fetch to get updated details
          fetchKyc();
        }
      },
    );
  }
}
