import 'package:get/get.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/wallet_credit_type_model.dart';
import 'package:maxpay/data/model/wallet_credit_list_model.dart';
import 'package:maxpay/domain/usecase/wallet_credit_type_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_wallet_credit_list_usecase.dart';

class WalletController extends GetxController {
  final GetWalletCreditTypeUseCase getWalletCreditTypeUseCase;
  final GetWalletCreditListUseCase getWalletCreditListUseCase;

  WalletController({
    required this.getWalletCreditTypeUseCase,
    required this.getWalletCreditListUseCase,
  });


  var walletCreditTypes = <Data>[].obs;
  var selectedCreditTypeId = RxnInt();
  var selectedCreditTypeName = RxnString();
  var fromDate = ''.obs;
  var toDate = ''.obs;
  var searchQuery = ''.obs;
  
  var isLoading = false.obs;

  var isListLoading = false.obs;
  var walletCreditList = <WalletCreditItem>[].obs;
  var totalCreditAmount = '0'.obs;

  @override
void onInit() {
  super.onInit();
  print("WalletController onInit");

  getWalletTypes();
}

  Future<void> getWalletTypes() async {
  isLoading.value = true;

  final result = await getWalletCreditTypeUseCase();

  result.fold(
  (failure) {
    print(failure.message);
    Get.snackbar("Error", failure.message);
  },
  (response) {
    walletCreditTypes.assignAll(response.data ?? []);

    print(walletCreditTypes.length);

    for (var item in walletCreditTypes) {
      print("${item.id} - ${item.name}");
    }
  },
);

  isLoading.value = false;
}

  void applyFilters() {
    fetchWalletCreditList(
      type: selectedCreditTypeName.value ?? '',
      fromDate: fromDate.value,
      toDate: toDate.value,
      search: searchQuery.value,
    );
  }

  Future<void> fetchWalletCreditList({
    String type = '',
    String fromDate = '',
    String toDate = '',
    String search = '',
  }) async {
    isListLoading.value = true;
    final result = await getWalletCreditListUseCase(type, fromDate, toDate, search);

    result.fold<void>(
      (Failure failure) {
        Get.snackbar("Error", failure.message);
      },
      (WalletCreditListModel response) {
        if (response.data?.list != null) {
          walletCreditList.assignAll(response.data!.list!);
        }
        totalCreditAmount.value = response.data?.creditAmount ?? '0';
      },
    );

    isListLoading.value = false;
  }
}