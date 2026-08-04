import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/data/model/transfer_detail_model.dart';
import 'package:maxpay/data/model/transfer_detail_list_model.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/domain/usecase/transfer_detail_usecase.dart';
import 'package:maxpay/domain/usecase/get_transfer_detail_list_usecase.dart';
import 'package:maxpay/domain/usecase/reverse_wallet_transfer_usecase.dart';

class TransferDetailController extends GetxController {
  final GetTransferDetailsUseCase getTransferDetailsUseCase;
  final GetTransferDetailListUseCase getTransferDetailListUseCase;
  final ReverseWalletTransferUseCase reverseWalletTransferUseCase;

  TransferDetailController(
    this.getTransferDetailsUseCase,
    this.getTransferDetailListUseCase,
    this.reverseWalletTransferUseCase,
  );

  RxBool isLoading = false.obs;
  RxString selectedTransactionType = "All".obs;
  RxBool isReverse = false.obs;
  RxString totalAmount = "₹0.00".obs;
  RxString label = "".obs;

  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxString searchQuery = ''.obs;

  final searchController = TextEditingController();
  Timer? _debounceTimer;

  RxList<Data> transferDetails = <Data>[].obs;
  RxList<TransferDetailListItem> transferDetailList =
      <TransferDetailListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    fromDate.value = DateFormat('yyyy-MM-dd').format(now);
    toDate.value = DateFormat('yyyy-MM-dd').format(now);

    getTransferDetails();
    fetchTransferDetailList();
  }

  void updateFromDate(String date) {
    fromDate.value = date;
    fetchTransferDetailList();
  }

  void updateToDate(String date) {
    toDate.value = date;
    fetchTransferDetailList();
  }

  void updateDateRange(String from, String to) {
    fromDate.value = from;
    toDate.value = to;
    fetchTransferDetailList();
  }

  @override
  void onClose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchTransferDetailList();
    });
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

  Future<void> fetchTransferDetailList({
    String? type,
    String? fromDateStr,
    String? toDateStr,
    String? searchStr,
  }) async {
    isLoading.value = true;
    final selected = type ?? selectedTransactionType.value;
    String t = 'all';
    if (selected.isNotEmpty && selected.toLowerCase() != 'all') {
      final matched = transferDetails.firstWhereOrNull(
        (e) => e.name?.toLowerCase() == selected.toLowerCase(),
      );
      t = matched?.value ?? selected.toLowerCase();
    }

    final f =
        fromDateStr ??
        (fromDate.value.isNotEmpty
            ? fromDate.value
            : DateFormat('yyyy-MM-dd').format(DateTime.now()));
    final to =
        toDateStr ??
        (toDate.value.isNotEmpty
            ? toDate.value
            : DateFormat('yyyy-MM-dd').format(DateTime.now()));
    final s = searchStr ?? searchQuery.value;

    final result = await getTransferDetailListUseCase(t, f, to, s);
    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        if (response.data?.list != null) {
          transferDetailList.assignAll(response.data!.list!);
        } else {
          transferDetailList.clear();
        }
        totalAmount.value = (response.data?.summaryAmount ?? 0).currencyIndian;
        label.value = response.data?.summaryLabel ?? "";
      },
    );
    isLoading.value = false;
  }

  void changeTransactionType(String value) {
    selectedTransactionType.value = value;
    if (value.toLowerCase() == "reverse") {
      isReverse.value = true;
    } else {
      isReverse.value = false;
    }
    fetchTransferDetailList();
  }

  Future<void> reverseWalletTransfer(String id) async {
    isLoading.value = true;
    final result = await reverseWalletTransferUseCase(id);
    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        Get.snackbar(
          "Success",
          response.message ?? "Transfer reversed successfully",
        );
        fetchTransferDetailList(); // Refresh the list
        Get.find<AddWalletController>().fetchWalletBalance();
      },
    );
    isLoading.value = false;
  }
}
