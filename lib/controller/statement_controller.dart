import 'dart:async';
import 'package:get/get.dart';
import 'package:maxpay/data/model/statement/statement_descriptions_model.dart';
import 'package:maxpay/data/model/statement/statement_list_model.dart';
import 'package:maxpay/domain/repository/statement_repo.dart';
import 'package:maxpay/domain/usecase/statement/get_statement_descriptions_usecase.dart';
import 'package:maxpay/domain/usecase/statement/get_statement_list_usecase.dart';
import 'package:intl/intl.dart';

class StatementController extends GetxController {
  final GetStatementDescriptionsUseCase getStatementDescriptionsUseCase;
  final GetStatementListUseCase getStatementListUseCase;

  StatementController(this.getStatementDescriptionsUseCase, this.getStatementListUseCase);

  RxBool isLoading = false.obs;
  RxBool isListLoading = false.obs;
  
  RxList<StatementDescriptionData> descriptions = <StatementDescriptionData>[].obs;
  Rx<String?> selectedDescription = Rx<String?>(null);

  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxString searchQuery = ''.obs;

  RxList<StatementItem> transactions = <StatementItem>[].obs;

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    fromDate.value = DateFormat('yyyy-MM-dd').format(firstDayOfMonth);
    toDate.value = DateFormat('yyyy-MM-dd').format(now);
    
    fetchDescriptions();
    fetchStatementList();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  Future<void> fetchDescriptions() async {
    isLoading.value = true;
    final result = await getStatementDescriptionsUseCase.call();
    isLoading.value = false;

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (success) {
        descriptions.value = success.data ?? [];
      },
    );
  }

  void selectDescription(String? description) {
    selectedDescription.value = description;
    fetchStatementList();
  }

  void updateDateRange(String start, String end) {
    fromDate.value = start;
    toDate.value = end;
    fetchStatementList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchStatementList();
    });
  }

  Future<void> fetchStatementList() async {
    isListLoading.value = true;
    final params = StatementListParams(
      fromDate: fromDate.value,
      toDate: toDate.value,
      description: selectedDescription.value ?? '',
      search: searchQuery.value,
    );

    final result = await getStatementListUseCase.call(params);
    isListLoading.value = false;

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (success) {
        transactions.value = success.data?.list ?? [];
      },
    );
  }
}
