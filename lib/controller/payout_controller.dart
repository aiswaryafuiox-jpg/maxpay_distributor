
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/utils/custom_toast.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/payout/payout_model.dart';
import 'package:maxpay/domain/usecase/payout/get_payout_usecase.dart';

class PayoutController extends GetxController {
  final GetPayoutUseCase getPayoutUseCase;

  PayoutController(this.getPayoutUseCase);

  final isLoading = false.obs;

  final payoutList = <PayoutItem>[].obs;
  final filteredPayoutList = <PayoutItem>[].obs;

  final totalEarnings = '0.00'.obs;

  final fromDate = ''.obs;
  final toDate = ''.obs;

  final mobileSearch = ''.obs;

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initializeDates();
    fetchPayout();
  }

  @override
  void onClose() {
    fromDateController.dispose();
    toDateController.dispose();
    mobileController.dispose();
    super.onClose();
  }

  void _initializeDates() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    fromDate.value = today;
    toDate.value = today;

    fromDateController.text = today;
    toDateController.text = today;
  }

  void updateDateRange(String from, String to) {
    final fromParsed = DateTime.tryParse(from);
    final toParsed = DateTime.tryParse(to);

    if (fromParsed != null &&
        toParsed != null &&
        fromParsed.isAfter(toParsed)) {
      CustomToast.error(
        'From date cannot be later than the to date',
      );
      fromDateController.text = fromDate.value;
      toDateController.text = toDate.value;
      return;
    }

    fromDate.value = from;
    toDate.value = to;

    fromDateController.text = from;
    toDateController.text = to;

    fetchPayout();
  }

  void searchByMobile(String value) {
    mobileSearch.value = value.trim();
    _filterPayouts();
  }

  void _filterPayouts() {
    final query = mobileSearch.value.replaceAll(' ', '');

    if (query.isEmpty) {
      filteredPayoutList.assignAll(payoutList);
      return;
    }

    filteredPayoutList.assignAll(
      payoutList.where((item) {
        final mobile = (item.mobileNumber ?? '').replaceAll(' ', '');
        return mobile.contains(query);
      }).toList(),
    );
  }

  Future<void> fetchPayout() async {
    isLoading.value = true;

    try {
      final result = await getPayoutUseCase.call(
        fromDate.value,
        toDate.value,
      );

      result.fold(
        (failure) {
          payoutList.clear();
          filteredPayoutList.clear();
          totalEarnings.value = '0.00';

          AppLogger.logError(
            'Failed to fetch payout: ${failure.message}',
          );

          CustomToast.error(failure.message);
        },
        (data) {
          final response = data.data;

          if (response != null) {
            totalEarnings.value = response.totalEarnings ?? '0.00';

            payoutList.assignAll(response.list ?? []);

            _filterPayouts();
          } else {
            totalEarnings.value = '0.00';
            payoutList.clear();
            filteredPayoutList.clear();
          }
        },
      );
    } catch (e, stackTrace) {
      payoutList.clear();
      filteredPayoutList.clear();
      totalEarnings.value = '0.00';

      AppLogger.logError('Failed to fetch payout: $e\n$stackTrace');
      CustomToast.error('Something went wrong while fetching payouts');
    } finally {
      isLoading.value = false;
    }
  }
}
