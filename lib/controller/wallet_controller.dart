import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:maxpay/data/model/wallet_credit_type_model.dart';
import 'package:maxpay/domain/usecase/wallet_credit_type_usecase.dart';

class WalletController extends GetxController {
  final GetWalletCreditTypeUseCase getWalletCreditTypeUseCase;

  WalletController({required this.getWalletCreditTypeUseCase,});


  var walletCreditTypes = <Data>[].obs;
   var selectedCreditTypeId = RxnInt();
  var isLoading = false.obs;

  @override
void onInit() {
  super.onInit();
  debugPrint("WalletController onInit");

  getWalletTypes();
}

  Future<void> getWalletTypes() async {
  isLoading.value = true;

  final result = await getWalletCreditTypeUseCase();

  result.fold(
  (failure) {
    debugPrint(failure.message);
    Get.snackbar("Error", failure.message);
  },
  (response) {
    walletCreditTypes.assignAll(response.data ?? []);

    debugPrint(walletCreditTypes.length.toString());

    for (var item in walletCreditTypes) {
      debugPrint("${item.id} - ${item.name}");
    }
  },
);

  isLoading.value = false;
}
}