import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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
}