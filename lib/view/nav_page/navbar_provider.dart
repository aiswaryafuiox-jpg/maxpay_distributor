import 'package:get/get.dart';

class NavbarController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void setIndex(int index) {
    _selectedIndex.value = index;
  }
}
