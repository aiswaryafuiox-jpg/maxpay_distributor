import 'package:maxpay/core/utils/custom_snackbar.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/my_earnings/my_earnings_model.dart';
import 'package:maxpay/domain/usecase/my_earnings/get_my_earnings_usecase.dart';

class MyEarningsController extends GetxController {
  final GetMyEarningsUseCase getMyEarningsUseCase;

  MyEarningsController(this.getMyEarningsUseCase);

  var isLoading = false.obs;
  var earningsList = <MyEarningsItem>[].obs;
  var totalEarnings = '0.00'.obs;

  var fromDate = ''.obs;
  var toDate = ''.obs;
  var searchQuery = ''.obs;

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeDates();
    fetchMyEarnings();
  }

  @override
  void onClose() {
    fromDateController.dispose();
    toDateController.dispose();
    searchController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  void _initializeDates() {
    final now = DateTime.now();

    fromDate.value = DateFormat('yyyy-MM-dd').format(now);
    toDate.value = DateFormat('yyyy-MM-dd').format(now);
    fromDateController.text = fromDate.value;
    toDateController.text = toDate.value;
  }

  void updateDateRange(String from, String to) {
    fromDate.value = from;
    toDate.value = to;
    fromDateController.text = from;
    toDateController.text = to;
    fetchMyEarnings();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchMyEarnings();
    });
  }

  Future<void> fetchMyEarnings() async {
    isLoading.value = true;
    final result = await getMyEarningsUseCase.call(
      fromDate.value,
      toDate.value,
      searchQuery.value,
    );

    isLoading.value = false;

    result.fold(
      (failure) {
        earningsList.clear();
        totalEarnings.value = "0.00";
        AppLogger.logError("Failed to fetch my earnings: ${failure.message}");
        CustomSnackbar.error(failure.message);
      },
      (data) {
        if (data.data != null) {
          totalEarnings.value = data.data!.totalEarnings ?? "0.00";
          earningsList.assignAll(data.data!.list ?? []);
        } else {
          totalEarnings.value = "0.00";
          earningsList.clear();
        }
      },
    );
  }
}
