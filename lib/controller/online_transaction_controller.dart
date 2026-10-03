import 'package:maxpay/core/utils/custom_snackbar.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/data/model/report/online_transaction_model.dart';
import 'package:maxpay/domain/repository/online_transaction_repo.dart';
import 'package:maxpay/domain/usecase/report/get_online_transactions_usecase.dart';

class OnlineTransactionController extends GetxController {
  final GetOnlineTransactionUseCase getOnlineTransactionUseCase;

  OnlineTransactionController(this.getOnlineTransactionUseCase);

  RxBool isLoading = false.obs;
  RxList<OnlineTransactionItem> items = <OnlineTransactionItem>[].obs;

  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxString searchQuery = ''.obs;
  RxString status = 'pending'.obs;

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeDates();
    fetchOnlineTransactions();
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
    fetchOnlineTransactions();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchOnlineTransactions();
    });
  }

  void updateStatus(String newStatus) {
    status.value = newStatus;
    fetchOnlineTransactions();
  }

  Future<void> fetchOnlineTransactions() async {
    isLoading.value = true;

    final params = OnlineTransactionParams(
      fromDate: fromDate.value,
      toDate: toDate.value,
      search: searchQuery.value,
      status: status.value,
    );

    final result = await getOnlineTransactionUseCase.call(params);

    isLoading.value = false;

    result.fold(
      (failure) {
        items.clear();
        CustomSnackbar.error(failure.message);
      },
      (success) {
        final data = success.data;
        if (data != null && data.list != null) {
          items.assignAll(data.list!);
        } else {
          items.clear();
        }
      },
    );
  }
}
