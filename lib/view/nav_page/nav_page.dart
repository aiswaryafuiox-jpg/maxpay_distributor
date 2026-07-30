import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/view/add_wallet/add_wallet_screen.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/nav_page/navbar.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:maxpay/view/report/report_page.dart';
import 'package:maxpay/view/settings/settings_page.dart';
import 'package:maxpay/view/supportscreen/support_screen.dart';

class NavPageScreen extends StatefulWidget {
  const NavPageScreen({super.key});

  @override
  State<NavPageScreen> createState() => _ScreenNavBarState();
}

class _ScreenNavBarState extends State<NavPageScreen>
    with WidgetsBindingObserver {
  DateTime? lastBackPressed;
  final NavbarController _navbarController = Get.find<NavbarController>();
  //added

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomePageScreen(),
      const ReportPage(),

      const AddWalletScreen(),

      const SupportScreen(),

      const SettingsPage(),
    ];

    return Obx(() {
      final selectedIndex = _navbarController.selectedIndex;

      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;

          if (selectedIndex != 0) {
            _navbarController.setIndex(0);
          } else {
            final now = DateTime.now();
            if (lastBackPressed == null ||
                now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
              lastBackPressed = now;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Press back again to exit'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              SystemNavigator.pop();
            }
          }
        },
        child: Scaffold(
          bottomNavigationBar: const CustomBottomNavBar(),
          body: IndexedStack(index: selectedIndex, children: screens),
        ),
      );
    });
  }
}
