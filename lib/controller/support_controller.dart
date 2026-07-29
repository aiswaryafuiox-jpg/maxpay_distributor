import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/support_model.dart';
import 'package:maxpay/domain/usecase/support/get_support_usecase.dart';

class SupportController extends GetxController {
  final GetSupportUseCase getSupportUseCase;

  SupportController(this.getSupportUseCase);

  var isLoading = false.obs;
  var supportData = Rxn<SupportData>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSupport();
  }

  Future<void> fetchSupport() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getSupportUseCase.call();

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        AppLogger.logError("Failed to fetch support: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          supportData.value = data.data;
        } else if (data.message != null) {
          errorMessage.value = data.message!;
        }
      },
    );
  }
}
