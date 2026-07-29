import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/daybook/day_book_products_model.dart';
import 'package:maxpay/data/model/transaction/transaction_report_model.dart';
import 'package:maxpay/domain/usecase/daybook/get_day_book_products_usecase.dart';
import 'package:maxpay/domain/usecase/transaction/get_transaction_success_report_usecase.dart';

class TransactionController extends GetxController {
  final GetTransactionSuccessReportUseCase getTransactionSuccessReportUseCase;
  final GetDayBookProductsUseCase getDayBookProductsUseCase;

  TransactionController(
    this.getTransactionSuccessReportUseCase,
    this.getDayBookProductsUseCase,
  );

  var isLoading = false.obs;
  var isProductsLoading = false.obs;

  var transactionList = <TransactionItem>[].obs;
  var totalTransaction = '0'.obs;
  var totalProfit = '0'.obs;

  var productList = <ProductData>[].obs;
  var selectedProductId = ''.obs;

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTransactionSuccessReport();
  }

  @override
  void onClose() {
    fromDateController.dispose();
    toDateController.dispose();
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchProducts() async {
    isProductsLoading.value = true;
    final result = await getDayBookProductsUseCase.call();

    result.fold(
      (failure) {
        isProductsLoading.value = false;
        AppLogger.logError("Failed to fetch products: ${failure.message}");
      },
      (data) {
        isProductsLoading.value = false;
        if (data.data != null) {
          productList.value = data.data!;
        }
      },
    );
  }

  Future<void> fetchTransactionSuccessReport() async {
    isLoading.value = true;
    final result = await getTransactionSuccessReportUseCase.call(
      selectedProductId.value,
      fromDateController.text,
      toDateController.text,
      searchController.text,
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Failed to fetch transaction report: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          totalTransaction.value = data.data!.totalTransaction ?? "0";
          totalProfit.value = data.data!.totalProfit ?? "0";
          transactionList.value = data.data!.list ?? [];
        }
      },
    );
  }
}
