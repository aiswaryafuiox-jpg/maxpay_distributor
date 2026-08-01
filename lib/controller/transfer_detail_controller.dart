import 'package:get/get.dart';
import 'package:maxpay/data/model/transfer_detail_model.dart';
import 'package:maxpay/data/model/transfer_detail_list_model.dart';
import 'package:maxpay/domain/usecase/transfer_detail_usecase.dart';
import 'package:maxpay/domain/usecase/get_transfer_detail_list_usecase.dart';
import 'package:maxpay/domain/usecase/reverse_wallet_transfer_usecase.dart';

class TransferDetailController extends GetxController {
  final GetTransferDetailsUseCase getTransferDetailsUseCase;
  final GetTransferDetailListUseCase getTransferDetailListUseCase;
  final ReverseWalletTransferUseCase reverseWalletTransferUseCase;

  TransferDetailController(this.getTransferDetailsUseCase, this.getTransferDetailListUseCase, this.reverseWalletTransferUseCase);

  RxBool isLoading = false.obs;
  RxString selectedTransactionType = "Transfer".obs;
  RxBool isReverse = false.obs;
  RxString totalAmount = "₹0.00".obs;

  RxList<Data> transferDetails = <Data>[].obs;
  RxList<TransferDetailListItem> transferDetailList = <TransferDetailListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTransferDetails();
    fetchTransferDetailList();
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

  Future<void> fetchTransferDetailList({String type = 'all', String fromDate = '2026-01-01', String toDate = '2026-12-31', String search = ''}) async {
    isLoading.value = true;
    final result = await getTransferDetailListUseCase(type, fromDate, toDate, search);
    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        if (response.data?.list != null) {
          transferDetailList.assignAll(response.data!.list!);
        }
        totalAmount.value = "₹ ${response.data?.summaryAmount ?? '0.00'}";
      }
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

  Future<void> reverseWalletTransfer(String id) async {
    isLoading.value = true;
    final result = await reverseWalletTransferUseCase(id);
    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        Get.snackbar("Success", response.message ?? "Transfer reversed successfully");
        fetchTransferDetailList(); // Refresh the list
      }
    );
    isLoading.value = false;
  }
}