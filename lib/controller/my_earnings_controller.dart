import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/my_earnings/my_earnings_model.dart';
import 'package:maxpay/domain/usecase/my_earnings/get_my_earnings_usecase.dart';

class MyEarningsController extends GetxController {
  final GetMyEarningsUseCase getMyEarningsUseCase;

  MyEarningsController(this.getMyEarningsUseCase);

  var isLoading = false.obs;
  var earningsList = <MyEarningsItem>[].obs;
  var totalEarnings = '0'.obs;

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMyEarnings();
  }

  @override
  void onClose() {
    fromDateController.dispose();
    toDateController.dispose();
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchMyEarnings() async {
    isLoading.value = true;
    final result = await getMyEarningsUseCase.call(
      fromDateController.text,
      toDateController.text,
      searchController.text,
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Failed to fetch my earnings: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoading.value = false;
        if (data.data != null) {
          totalEarnings.value = data.data!.totalEarnings ?? "0";
          earningsList.value = data.data!.list ?? [];
        }
      },
    );
  }
}
