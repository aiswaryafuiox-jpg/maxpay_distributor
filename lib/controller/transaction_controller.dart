import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import '../domain/usecase/transaction/get_transaction_products_usecase.dart';
import '../domain/usecase/transaction/get_transaction_report_usecase.dart';
import '../domain/usecase/transaction/get_transaction_detail_usecase.dart';
import '../domain/usecase/transaction/submit_transaction_dispute_usecase.dart';
import '../data/model/transaction/transaction_product_response_model.dart';
import '../data/model/transaction/transaction_report_response_model.dart';
import '../data/model/transaction/transaction_detail_response_model.dart';

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
  final TextEditingController dateController = TextEditingController();

  String fromDate = '';
  String toDate = '';

  @override
  void onInit() {
    super.onInit();
    final DateTime today = DateTime.now();
    fromDate = DateFormat('yyyy-MM-dd').format(today);
    toDate = DateFormat('yyyy-MM-dd').format(today);
    dateController.text = DateFormat('dd.MM.yyyy').format(today);

    fetchTransactionProducts();
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
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
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

  Future<void> selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime.tryParse(fromDate) ?? DateTime.now(),
        end: DateTime.tryParse(toDate) ?? DateTime.now(),
      ),
    );

    if (picked != null) {
      fromDate = DateFormat('yyyy-MM-dd').format(picked.start);
      toDate = DateFormat('yyyy-MM-dd').format(picked.end);
      
      final displayStart = DateFormat('dd.MM.yyyy').format(picked.start);
      final displayEnd = DateFormat('dd.MM.yyyy').format(picked.end);
      
      if (fromDate == toDate) {
        dateController.text = displayStart;
      } else {
        dateController.text = "$displayStart - $displayEnd";
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
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
      },
      (response) {
        isProductsLoading.value = false;
        if (response.data != null) {
          products.assignAll(response.data!);
        }
      },
    );
  }

  Future<void> fetchTransactionDetail(int id) async {
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    
    final result = await getTransactionDetailUseCase.call(id);
    
    Get.back(); // close loading dialog

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
      },
      (response) {
        if (response.data != null) {
          _showTransactionDetailDialog(response.data!);
        }
      },
    );
  }

  void _showTransactionDetailDialog(TransactionDetailData detail) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction Detail", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDetailRow("Transaction ID", detail.transactionId ?? 'N/A'),
            _buildDetailRow("Date & Time", detail.dateTime ?? 'N/A'),
            _buildDetailRow("Product", detail.productName ?? 'N/A'),
            _buildDetailRow("Mobile", detail.mobile ?? 'N/A'),
            _buildDetailRow("Retailer Name", detail.retailerName ?? 'N/A'),
            _buildDetailRow("Amount", (detail.amount ?? 0).currencyIndian),
            _buildDetailRow("Status", detail.status ?? 'N/A'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Future<void> submitDispute(String id, String subject, String description) async {
    final result = await submitTransactionDisputeUseCase(id, subject, description);

    result.fold(
      (failure) {
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
      (successMessage) {
        Get.snackbar(
          "Success",
          successMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
  }
}
