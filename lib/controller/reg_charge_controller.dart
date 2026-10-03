import 'package:maxpay/core/utils/custom_snackbar.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/data/model/report/reg_charge_detail_model.dart';
import 'package:maxpay/domain/repository/reg_charge_repo.dart';
import 'package:maxpay/domain/usecase/report/get_reg_charge_detail_usecase.dart';

class RegChargeController extends GetxController {
  final GetRegChargeDetailUseCase getRegChargeDetailUseCase;

  RegChargeController(this.getRegChargeDetailUseCase);

  RxBool isLoading = false.obs;
  RxList<RegChargeDetailItem> items = <RegChargeDetailItem>[].obs;

  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxString searchQuery = ''.obs;

  RxNum totalDistributorCommission = RxNum(0);
  RxNum totalExecutiveCommission = RxNum(0);

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeDates();
    fetchRegChargeDetails();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void _initializeDates() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    fromDate.value = DateFormat('yyyy-MM-dd').format(firstDayOfMonth);
    toDate.value = DateFormat('yyyy-MM-dd').format(now);
  }

  void updateDateRange(String from, String to) {
    fromDate.value = from;
    toDate.value = to;
    fetchRegChargeDetails();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchRegChargeDetails();
    });
  }

  Future<void> fetchRegChargeDetails() async {
    isLoading.value = true;

    final params = RegChargeDetailParams(
      fromDate: fromDate.value,
      toDate: toDate.value,
      search: searchQuery.value,
    );

    final result = await getRegChargeDetailUseCase.call(params);

    isLoading.value = false;

    result.fold(
      (failure) {
        items.clear();
        CustomSnackbar.error(failure.message);
      },
      (success) {
        final data = success.data;
        if (data != null) {
          totalDistributorCommission.value = data.totalDistributorCommission ?? 0;
          totalExecutiveCommission.value = data.totalExecutiveCommission ?? 0;
          items.assignAll(data.list ?? []);
        } else {
          items.clear();
        }
      },
    );
  }
}
