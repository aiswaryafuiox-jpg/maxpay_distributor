import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/auto_transfer_details_model.dart';
import 'package:maxpay/data/model/update_auto_transfer_model.dart';
import 'package:maxpay/domain/repository/update_auto_transfer_repo.dart';
import 'package:maxpay/domain/usecase/retailer/get_auto_transfer_details_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/update_auto_transfer_usecase.dart';

class AutoTransferController extends GetxController {
  final GetAutoTransferDetailsUseCase getAutoTransferDetailsUseCase;
  final UpdateAutoTransferUseCase updateAutoTransferUseCase;

  AutoTransferController({
    required this.getAutoTransferDetailsUseCase,
    required this.updateAutoTransferUseCase,
  });

  final TextEditingController lowWalletController = TextEditingController();
  final TextEditingController transferAmountController = TextEditingController();

  var isLoading = false.obs;
  var isUpdating = false.obs;
  var autoTransferData = Rxn<AutoTransferData>();
  var selectedAutoTransferStatus = 'Enable'.obs;

  @override
  void onClose() {
    lowWalletController.dispose();
    transferAmountController.dispose();
    super.onClose();
  }

  Future<void> fetchAutoTransferDetails(String id) async {
    isLoading.value = true;
    final result = await getAutoTransferDetailsUseCase(id);

    result.fold<void>(
      (Failure failure) {
        Get.snackbar("Error", failure.message);
      },
      (AutoTransferDetailsModel response) {
        autoTransferData.value = response.data;
        if (response.data != null) {
          lowWalletController.text = response.data!.lowWallet ?? '';
          transferAmountController.text = response.data!.transferAmount ?? '';
          selectedAutoTransferStatus.value = response.data!.autoTransfer ?? 'Enable';
        }
      },
    );

    isLoading.value = false;
  }

  Future<void> updateAutoTransfer(String id) async {
    isUpdating.value = true;
    final params = UpdateAutoTransferParams(
      id: id,
      lowWallet: lowWalletController.text,
      transferAmount: transferAmountController.text,
      autoTransfer: selectedAutoTransferStatus.value,
    );

    final result = await updateAutoTransferUseCase(params);

    result.fold(
      (Failure failure) {
        Get.snackbar("Error", failure.message);
      },
      (UpdateAutoTransferModel response) {
        Get.snackbar("Success", response.message ?? "Updated successfully");
      },
    );

    isUpdating.value = false;
  }
}
