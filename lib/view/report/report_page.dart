import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode;

      return Container(
        decoration: isDark
            ? null
            : BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.bgOverlay),
                  fit: BoxFit.cover,
                ),
              ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonAppBar(title: "Report", onBack: _goHome),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
              child: Column(
                children: [
                  _buildMenuTile(
                    context,
                    'Online Transaction',
                    () {
                     // Get.toNamed(AppRoutes.myearning);
                      Get.toNamed(AppRoutes.onlineTransaction);
                    },
                    SvgPicture.asset(AssetImages.earnings, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    'Reg. Charge Credit',
                    () {
                      //Get.toNamed(AppRoutes.withdrawrequest1);
                      Get.toNamed(AppRoutes.regChargeCredit);
                    },
                    SvgPicture.asset(AssetImages.wallet, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    'API Payout Details',
                    () {
                      Get.toNamed(AppRoutes.payoutDetails);
                    },
                    SvgPicture.asset(AssetImages.refunds, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    'Payout Request',
                    () {
                      Get.toNamed(AppRoutes.payoutRequest);
                    },
                    SvgPicture.asset(AssetImages.cashback, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    'Payment Request ',
                    () {
                      Get.toNamed(AppRoutes.paymentRequest);
                    },
                    SvgPicture.asset(AssetImages.statements, width: 24.w),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _goHome() {
    Get.find<NavbarController>().setIndex(0);
    if (Get.currentRoute != AppRoutes.main) {
      Get.offAllNamed(AppRoutes.main);
    }
  }

  Widget _buildMenuTile(
    BuildContext context,
    String title,
    VoidCallback onTap,
    Widget icon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colorScheme.onSurface.withValues(alpha: 0.5),
          size: 24.sp,
        ),
      ),
    );
  }
}
