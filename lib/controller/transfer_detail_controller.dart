import 'package:get/get.dart';
import 'package:maxpay/data/model/transfer_detail_model.dart';
import 'package:maxpay/domain/usecase/transfer_detail_usecase.dart';

class TransferDetailController extends GetxController {
  final GetTransferDetailsUseCase getTransferDetailsUseCase;

  TransferDetailController(this.getTransferDetailsUseCase);

  RxBool isLoading = false.obs;
  RxString selectedTransactionType = "Transfer".obs;
  RxBool isReverse = false.obs;
  RxString totalAmount = "₹0.00".obs;

  RxList<Data> transferDetails = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTransferDetails();
  }

  Future<void> getTransferDetails() async {
    isLoading.value = true;

    final result = await getTransferDetailsUseCase();

    result.fold(
  (failure) {
    Get.snackbar("Error", failure.message);
  },
  (response) {
    transferDetails.assignAll(response.data ?? []);
  },
);

    isLoading.value = false;
  }

  void changeTransactionType(String value) {
    if (value == "Reverse") {
      selectedTransactionType.value = "Reverse";
      isReverse.value = true;
    } else {
      selectedTransactionType.value = "Transfer";
      isReverse.value = false;
    }
  }
}