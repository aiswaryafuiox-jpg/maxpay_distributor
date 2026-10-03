import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';

class NavbarController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void setIndex(int index) {
    _selectedIndex.value = index;
    if (Get.isRegistered<AddWalletController>()) {
      Get.find<AddWalletController>().fetchWalletBalance();
    }
  }
}
