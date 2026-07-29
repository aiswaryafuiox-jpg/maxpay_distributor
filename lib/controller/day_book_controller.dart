import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/daybook/day_book_products_model.dart';
import 'package:maxpay/data/model/daybook/day_book_list_model.dart';
import 'package:maxpay/domain/usecase/daybook/get_day_book_products_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/get_day_book_list_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/delete_day_book_usecase.dart';
import 'package:flutter/material.dart';

class DayBookController extends GetxController {
  final GetDayBookProductsUseCase getDayBookProductsUseCase;
  final GetDayBookListUseCase getDayBookListUseCase;
  final DeleteDayBookUseCase deleteDayBookUseCase;

  DayBookController(
    this.getDayBookProductsUseCase,
    this.getDayBookListUseCase,
    this.deleteDayBookUseCase,
  );

  var isLoading = false.obs;
  var isListLoading = false.obs;
  var products = <ProductData>[].obs;
  var selectedProduct = Rxn<ProductData>();
  var dayBookList = <DayBookItem>[].obs;
  var totalAmount = '0'.obs;

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void onClose() {
    fromDateController.dispose();
    toDateController.dispose();
    searchController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    final result = await getDayBookProductsUseCase.call();
    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Failed to fetch day book products: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          products.value = data.data!;
          if (products.isNotEmpty) {
            selectedProduct.value = products.first;
          }
        }
      },
    );
  }

  void selectProduct(ProductData product) {
    selectedProduct.value = product;
    fetchDayBookList();
  }

  Future<void> fetchDayBookList() async {
    isListLoading.value = true;
    final productId = selectedProduct.value?.id?.toString() ?? "";
    final result = await getDayBookListUseCase.call(
      fromDateController.text,
      toDateController.text,
      productId,
      searchController.text,
    );
    
    result.fold(
      (failure) {
        isListLoading.value = false;
        AppLogger.logError("Failed to fetch day book list: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isListLoading.value = false;
        if (data.data != null) {
          totalAmount.value = data.data!.totalAmount ?? "0";
          dayBookList.value = data.data!.list ?? [];
        }
      },
    );
  }

  Future<void> deleteDayBook(String id) async {
    isListLoading.value = true;
    final result = await deleteDayBookUseCase.call(id);

    result.fold(
      (failure) {
        isListLoading.value = false;
        AppLogger.logError("Failed to delete day book: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        Get.snackbar("Success", data.message ?? "Deleted successfully");
        fetchDayBookList();
      },
    );
  }
}
