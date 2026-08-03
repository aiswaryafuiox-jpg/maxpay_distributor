import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/transaction/transaction_report_response_model.dart';
import 'package:maxpay/domain/usecase/transaction/get_transaction_report_usecase.dart';

class SearchTransactionController extends GetxController {
  final GetTransactionReportUseCase getTransactionReportUseCase;

  SearchTransactionController(this.getTransactionReportUseCase);

  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  final RxBool isLoading = false.obs;
  final RxList<TransactionReportItem> transactions = <TransactionReportItem>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Default initial mock transactions matching the UI design until search query is entered
    _loadSampleTransactions();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.onClose();
  }

  void _loadSampleTransactions() {
    transactions.assignAll([
      TransactionReportItem(
        id: 1,
        transactionId: "9865647823",
        dateTime: "29-11-2026 07:38:43PM",
        productName: "Prepaid",
        productLogo: null,
        mobile: "9865647823",
        mobileFull: "#9876543",
        amount: 365,
        status: "Success",
      ),
      TransactionReportItem(
        id: 2,
        transactionId: "9865647823",
        dateTime: "29-11-2026 07:38:43PM",
        productName: "Prepaid",
        productLogo: null,
        mobile: "9865647823",
        mobileFull: "#9876543",
        amount: 365,
        status: "Pending",
      ),
      TransactionReportItem(
        id: 3,
        transactionId: "9865647823",
        dateTime: "29-11-2026 07:38:43PM",
        productName: "Prepaid",
        productLogo: null,
        mobile: "9865647823",
        mobileFull: "#9876543",
        amount: 365,
        status: "Failed",
      ),
    ]);
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      if (query.trim().isEmpty) {
        _loadSampleTransactions();
      } else {
        fetchSearchTransactions(query.trim());
      }
    });
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _loadSampleTransactions();
  }

  Future<void> fetchSearchTransactions(String query) async {
    isLoading.value = true;

    final body = {
      'search': query,
      'status': 'all',
    };

    final result = await getTransactionReportUseCase.call(body);

    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Search transactions failed: ${failure.message}");
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (response) {
        isLoading.value = false;
        if (response.data?.list != null && response.data!.list!.isNotEmpty) {
          transactions.assignAll(response.data!.list!);
        } else {
          transactions.clear();
        }
      },
    );
  }
}
