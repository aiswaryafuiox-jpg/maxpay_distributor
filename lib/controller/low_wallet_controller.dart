import 'package:maxpay/core/utils/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/low_wallet_retailers_model.dart';
import 'package:maxpay/domain/usecase/retailer/get_low_wallet_retailers_usecase.dart';

class LowWalletController extends GetxController {
  final GetLowWalletRetailersUseCase getLowWalletRetailersUseCase;

  LowWalletController(this.getLowWalletRetailersUseCase);

  RxBool isLoading = false.obs;
  RxList<LowWalletRetailerItem> retailers = <LowWalletRetailerItem>[].obs;
  RxInt totalRetailers = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLowWalletRetailers();
  }

  Future<void> fetchLowWalletRetailers() async {
    isLoading.value = true;
    final result = await getLowWalletRetailersUseCase();
    
    result.fold(
      (Failure failure) {
        CustomSnackbar.error(failure.message);
      },
      (LowWalletRetailersModel response) {
        if (response.data?.list != null) {
          retailers.assignAll(response.data!.list!);
        }
        totalRetailers.value = response.data?.total ?? 0;
      }
    );
    isLoading.value = false;
  }
}
