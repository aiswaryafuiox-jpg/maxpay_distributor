import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/data/model/wallet_credit_list_model.dart';
import 'package:maxpay/data/model/wallet_credit_type_model.dart';
import 'package:maxpay/domain/usecase/retailer/get_wallet_credit_list_usecase.dart';
import 'package:maxpay/domain/usecase/wallet_credit_type_usecase.dart';

class WalletController extends GetxController {
  final GetWalletCreditTypeUseCase getWalletCreditTypeUseCase;
  final GetWalletCreditListUseCase getWalletCreditListUseCase;

  WalletController({
    required this.getWalletCreditTypeUseCase,
    required this.getWalletCreditListUseCase,
  });

  var walletCreditTypes = <Data>[].obs;
  var selectedCreditTypeId = RxnString();
  var walletCreditItems = <WalletCreditItem>[].obs;
  var totalCreditAmount = '0.00'.obs;

  var isLoadingTypes = false.obs;
  var isLoadingList = false.obs;

  var fromDate = ''.obs;
  var toDate = ''.obs;
  var searchQuery = ''.obs;

  final searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeDates();
    getWalletTypes();
    fetchWalletCreditList();
  }

  @override
  void onClose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  void _initializeDates() {
    final now = DateTime.now();

    fromDate.value = DateFormat('yyyy-MM-dd').format(now);
    toDate.value = DateFormat('yyyy-MM-dd').format(now);
  }

  Future<void> getWalletTypes() async {
    isLoadingTypes.value = true;
    final result = await getWalletCreditTypeUseCase();

    result.fold(
      (failure) {
        debugPrint(failure.message);
      },
      (response) {
        walletCreditTypes.assignAll(response.data ?? []);
      },
    );
    isLoadingTypes.value = false;
  }

  Future<void> fetchWalletCreditList() async {
    isLoadingList.value = true;

    final typeStr = selectedCreditTypeId.value != null
        ? selectedCreditTypeId.value.toString()
        : '';

    final result = await getWalletCreditListUseCase(
      typeStr,
      fromDate.value,
      toDate.value,
      searchQuery.value,
    );

    isLoadingList.value = false;

    result.fold(
      (failure) {
        walletCreditItems.clear();
        totalCreditAmount.value = '0.00';
        Get.snackbar("Error", failure.message);
      },
      (response) {
        final data = response.data;
        if (data != null) {
          totalCreditAmount.value = data.creditAmount ?? '0.00';
          walletCreditItems.assignAll(data.list ?? []);
        } else {
          totalCreditAmount.value = '0.00';
          walletCreditItems.clear();
        }
      },
    );
  }

  void updateDateRange(String from, String to) {
    fromDate.value = from;
    toDate.value = to;
    fetchWalletCreditList();
  }

  void updateSelectedType(String? typeId) {
    selectedCreditTypeId.value = typeId;
    fetchWalletCreditList();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchWalletCreditList();
    });
  }

  void clearFilters() {
    _initializeDates();
    selectedCreditTypeId.value = null;
    searchQuery.value = '';
    searchController.clear();
    fetchWalletCreditList();
  }
}
