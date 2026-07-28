import 'package:maxpay/core/constants/routes_path.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class CustomBottomNavBar extends GetView<NavbarController> {
  const CustomBottomNavBar({super.key});

  final List<Map<String, dynamic>> _baseIcons = const [
    {"image": AssetImages.home, "label": "Home"},
    {"image": AssetImages.report, "label": "Report"},
    {"image": AssetImages.request, "label": "Request"},
    {"image": AssetImages.qr, "label": "Support"},
    {"image": AssetImages.settings, "label": "Settings"},
  ];

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final selectedIndex = controller.selectedIndex;
      final isDark = themeController.isDarkMode;

      return BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 12,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: isDark ? AppColors.clrPrimary : AppColors.blueColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          color: isDark ? AppColors.clrPrimary : AppColors.blueColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        onTap: (value) {
          controller.setIndex(value);
          //
          if (Get.currentRoute != AppRoutes.main) {
            Get.offNamed(AppRoutes.main);
          }
        },
        items: _baseIcons.map((e) {
          final bool isSelected = selectedIndex == _baseIcons.indexOf(e);
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              e["image"],
              colorFilter: ColorFilter.mode(
                isSelected
                    ? (isDark ? AppColors.clrPrimary : AppColors.blueColor)
                    : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: e["label"],
          );
        }).toList(),
      );
    });
  }
}






