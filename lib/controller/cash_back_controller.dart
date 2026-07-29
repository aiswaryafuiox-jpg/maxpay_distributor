import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/cashback/cash_back_model.dart';
import 'package:maxpay/data/model/cashback/cash_back_product_types_model.dart';

import 'package:maxpay/domain/usecase/cashback/get_cash_back_list_usecase.dart';
import 'package:maxpay/domain/usecase/cashback/get_cash_back_product_types_usecase.dart';

class CashBackController extends GetxController {
  final GetCashBackProductTypesUseCase getCashBackProductTypesUseCase;
  final GetCashBackListUseCase getCashBackListUseCase;

  CashBackController(
    this.getCashBackProductTypesUseCase,
    this.getCashBackListUseCase,
  );

  var isLoadingProductTypes = false.obs;
  var isLoadingList = false.obs;

  var productTypes = <CashBackProductType>[].obs;
  var selectedProductTypeId = ''.obs;

  var cashBackList = <CashBackItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductTypes();
    fetchCashBackList();
  }

  Future<void> fetchProductTypes() async {
    isLoadingProductTypes.value = true;
    final result = await getCashBackProductTypesUseCase.call();

    result.fold(
      (failure) {
        isLoadingProductTypes.value = false;
        AppLogger.logError(
          "Failed to fetch cashback product types: ${failure.message}",
        );
      },
      (data) {
        isLoadingProductTypes.value = false;
        if (data.data != null) {
          productTypes.value = data.data!;
          // if we want to auto-load the first product type, we could do it here
          if (productTypes.isNotEmpty) {
            selectedProductTypeId.value =
                productTypes.first.id?.toString() ?? "";
            fetchCashBackList();
          }
        }
      },
    );
  }

  Future<void> fetchCashBackList() async {
    if (selectedProductTypeId.value.isEmpty) return;

    isLoadingList.value = true;
    final result = await getCashBackListUseCase.call(
      selectedProductTypeId.value,
    );

    result.fold(
      (failure) {
        isLoadingList.value = false;
        AppLogger.logError("Failed to fetch cashback list: ${failure.message}");
        Get.snackbar("Error", failure.message);
      },
      (data) {
        isLoadingList.value = false;
        if (data.data != null && data.data!.list != null) {
          cashBackList.value = data.data!.list!;
        } else {
          cashBackList.clear();
        }
      },
    );
  }
}
