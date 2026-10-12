import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/utils/custom_toast.dart';
import 'package:maxpay/data/model/auto_transfer_details_model.dart';
import 'package:maxpay/data/model/partner/partner_list_response_model.dart';
import 'package:maxpay/data/model/update_auto_transfer_model.dart';
import 'package:maxpay/domain/repository/update_auto_transfer_repo.dart';
import 'package:maxpay/domain/usecase/partner/get_mapped_dist_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_auto_transfer_details_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/update_auto_transfer_usecase.dart';

class AutoTransferController extends GetxController {
  final GetMappedDistUseCase getMappedDistUseCase;
  final GetAutoTransferDetailsUseCase? getAutoTransferDetailsUseCase;
  final UpdateAutoTransferUseCase? updateAutoTransferUseCase;

  AutoTransferController({
    required this.getMappedDistUseCase,
    this.getAutoTransferDetailsUseCase,
    this.updateAutoTransferUseCase,
  });

  // Partner list state
  final RxList<StockistItem> partnerList = <StockistItem>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Legacy fields (maintained for backward compatibility)
  final TextEditingController lowWalletController = TextEditingController();
  final TextEditingController transferAmountController =
      TextEditingController();
  final RxBool isUpdating = false.obs;
  final Rxn<AutoTransferData> autoTransferData = Rxn<AutoTransferData>();
  final RxString selectedAutoTransferStatus = 'Enable'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMappedPartners();
  }

  @override
  void onClose() {
    lowWalletController.dispose();
    transferAmountController.dispose();
    super.onClose();
  }

  /// Fetch mapped partners/stockists from API
  Future<void> fetchMappedPartners({bool isRefresh = false}) async {
    if (!isRefresh) {
      isLoading.value = true;
    }
    errorMessage.value = '';

    final result = await getMappedDistUseCase();

    result.fold(
      (Failure failure) {
        errorMessage.value = failure.message;
        CustomToast.error(failure.message);
      },
      (MappedDistResponseModel response) {
        final list = response.data?.stockistList ?? [];
        partnerList.assignAll(list);
      },
    );

    isLoading.value = false;
  }

  /// Filtered partners based on search query
  List<StockistItem> get filteredPartners {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return partnerList;
    }
    return partnerList.where((item) {
      final name = item.displayName.toLowerCase();
      final phone = item.displayPhone.toLowerCase();
      final userId = (item.userId ?? '').toLowerCase();
      return name.contains(query) ||
          phone.contains(query) ||
          userId.contains(query);
    }).toList();
  }

  // Legacy auto transfer details methods
  Future<void> fetchAutoTransferDetails(String id) async {
    if (getAutoTransferDetailsUseCase == null) return;
    isLoading.value = true;
    final result = await getAutoTransferDetailsUseCase!(id);

    result.fold<void>(
      (Failure failure) {
        CustomToast.error(failure.message);
      },
      (AutoTransferDetailsModel response) {
        autoTransferData.value = response.data;
        if (response.data != null) {
          lowWalletController.text = response.data!.lowWallet ?? '';
          transferAmountController.text = response.data!.transferAmount ?? '';
          selectedAutoTransferStatus.value =
              response.data!.autoTransfer ?? 'Enable';
        }
      },
    );

    isLoading.value = false;
  }

  Future<void> updateAutoTransfer(String id) async {
    if (updateAutoTransferUseCase == null) return;
    isUpdating.value = true;
    final params = UpdateAutoTransferParams(
      id: id,
      lowWallet: lowWalletController.text,
      transferAmount: transferAmountController.text,
      autoTransfer: selectedAutoTransferStatus.value,
    );

    final result = await updateAutoTransferUseCase!(params);

    result.fold(
      (Failure failure) {
        CustomToast.error(failure.message);
      },
      (UpdateAutoTransferModel response) {
        CustomToast.success(response.message ?? "Updated successfully");
      },
    );

    isUpdating.value = false;
  }
}
