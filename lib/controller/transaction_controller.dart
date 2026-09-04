import 'package:maxpay/core/utils/custom_snackbar.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/view/transaction_screens/widget/share_receipt.dart';
import '../domain/usecase/transaction/get_transaction_products_usecase.dart';
import '../domain/usecase/transaction/get_transaction_report_usecase.dart';
import '../domain/usecase/transaction/get_transaction_detail_usecase.dart';
import '../domain/usecase/transaction/submit_transaction_dispute_usecase.dart';
import '../data/model/transaction/transaction_product_response_model.dart';
import '../data/model/transaction/transaction_report_response_model.dart';

class TransactionController extends GetxController {
  final GetTransactionProductsUseCase getTransactionProductsUseCase;
  final GetTransactionReportUseCase getTransactionReportUseCase;
  final GetTransactionDetailUseCase getTransactionDetailUseCase;
  final SubmitTransactionDisputeUseCase submitTransactionDisputeUseCase;

  TransactionController(
    this.getTransactionProductsUseCase,
    this.getTransactionReportUseCase,
    this.getTransactionDetailUseCase,
    this.submitTransactionDisputeUseCase,
  );

  RxBool isProductsLoading = false.obs;
  RxList<TransactionProduct> products = <TransactionProduct>[].obs;
  Rx<TransactionProduct?> selectedProduct = Rx<TransactionProduct?>(null);

  RxBool isReportLoading = false.obs;
  RxList<TransactionReportItem> transactions = <TransactionReportItem>[].obs;

  RxString currentStatus = "success".obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  String fromDate = '';
  String toDate = '';

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    final DateTime today = DateTime.now();
    fromDate = DateFormat('yyyy-MM-dd').format(today);
    toDate = DateFormat('yyyy-MM-dd').format(today);
    fromDateController.text = DateFormat('dd.MM.yyyy').format(today);
    toDateController.text = DateFormat('dd.MM.yyyy').format(today);

    fetchTransactionProducts();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    super.onClose();
  }

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchTransactionReport();
    });
  }

  Future<void> fetchTransactionReport({String? statusOverride}) async {
    isReportLoading.value = true;
    if (statusOverride != null) {
      currentStatus.value = statusOverride;
    }

    final body = {
      'status': currentStatus.value,
      'product_id': selectedProduct.value?.id?.toString() ?? '',
      'from_date': fromDate,
      'to_date': toDate,
      'search': searchController.text.trim(),
    };

    final result = await getTransactionReportUseCase.call(body);

    result.fold(
      (failure) {
        isReportLoading.value = false;
        AppLogger.logError("Failed to fetch report: ${failure.message}");
        CustomSnackbar.error(failure.message);
      },
      (response) {
        isReportLoading.value = false;
        if (response.data?.list != null) {
          transactions.assignAll(response.data!.list!);
        } else {
          transactions.clear();
        }
      },
    );
  }

  Future<void> selectDate(
    BuildContext context, {
    required bool isFromDate,
  }) async {
    final DateTime initialDate = isFromDate
        ? (DateTime.tryParse(fromDate) ?? DateTime.now())
        : (DateTime.tryParse(toDate) ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      final displayDate = DateFormat('dd.MM.yyyy').format(picked);

      if (isFromDate) {
        fromDate = formattedDate;
        fromDateController.text = displayDate;
      } else {
        toDate = formattedDate;
        toDateController.text = displayDate;
      }

      fetchTransactionReport();
    }
  }

  Future<void> fetchTransactionProducts() async {
    isProductsLoading.value = true;
    final result = await getTransactionProductsUseCase.call();

    result.fold(
      (failure) {
        isProductsLoading.value = false;
        AppLogger.logError("Failed to fetch products: ${failure.message}");
        CustomSnackbar.error(failure.message);
      },
      (response) {
        isProductsLoading.value = false;
        if (response.data != null) {
          products.assignAll(response.data!);
        }
      },
    );
  }

  Future<void> fetchTransactionDetail(int id, [bool isView = false]) async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    final result = await getTransactionDetailUseCase.call(id);

    Get.back(); // close loading dialog

    result.fold(
      (failure) {
        CustomSnackbar.error(failure.message);
      },
      (response) {
        //
        if (isView) {
          Get.toNamed(AppRoutes.view, arguments: response);
        } else {
          ShareReceipt.shareScreenshot(
            context: Get.context!,
            data: response.data!,
          );
        }
      },
    );
  }

  Future<void> submitDispute(
    String id,
    String subject,
    String description,
  ) async {
    final result = await submitTransactionDisputeUseCase(
      id,
      subject,
      description,
    );

    result.fold(
      (failure) {
        CustomSnackbar.error(failure.message);
      },
      (successMessage) {
        CustomSnackbar.success(successMessage);
      },
    );
  }
}
