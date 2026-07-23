import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDarkMode;
      return Container(
        decoration: BoxDecoration(
          image: isDark
              ? null
              : DecorationImage(
                  image: AssetImage(AssetImages.bgOverlay),
                  fit: BoxFit.cover,
                ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          //appBar: CommonAppBar(title: "Settings", onBack: _goHome),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 46.h),
                //child: Column(
                 // children: [
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: _goHome,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 18.sp,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(width: 15.w),

                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            Text(
                              "Web Login",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),

                            SizedBox(height: 6.h),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00BC62),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Link",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      SvgPicture.asset(
                                        AssetImages.linkShare,
                                        width: 15.w,
                                        height: 15.h,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.scanWebLogin);
                                  },
                                  child: Image.asset(
                                    AssetImages.qr_code,
                                    width: 50.w,
                                    height: 50.w,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 5.h),

                    _buildMenuTile(
                      context,
                      'Profile',
                      () {
                        Get.toNamed(AppRoutes.profile);
                      },
                      SvgPicture.asset(AssetImages.profile, width: 24.w),
                    ),
                    _buildMenuTile(
                      context,
                      'Cash Back',
                          () {
                        Get.toNamed(AppRoutes.cashback);
                      },
                      SvgPicture.asset(AssetImages.acc, width: 24.w),
                    ),
                    _buildMenuTile(
                      context,
                      'Commission Settings',
                          () {
                        Get.toNamed(AppRoutes.commission);
                      },
                      SvgPicture.asset(AssetImages.acc, width: 24.w),
                    ),
                    _buildMenuTile(
                      context,
                      'Bulk Package Update',
                          () {
                        Get.toNamed(AppRoutes.bulkPackageCharge);
                      },
                      SvgPicture.asset(AssetImages.acc, width: 24.w),
                    ),
                    _buildMenuTile(
                      context,
                      'Account (active/inactive)',
                          () {
                        //Get.toNamed(AppRoutes.profile);
                      },
                      SvgPicture.asset(AssetImages.acc, width: 24.w),
                    ),
                    _buildMenuTile(
                      context,
                      'Add Fingerprint',
                          () {
                        Get.toNamed(AppRoutes.biometricsIntro);
                      },
                      SvgPicture.asset(AssetImages.fingerprint, width: 24.w),
                    ),

                    _buildMenuTile(
                      context,
                      'Grade',
                      () {
                        Get.toNamed(AppRoutes.grade);
                      },
                      SvgPicture.asset(AssetImages.grade, width: 24.w),
                    ),
                    _buildMenuTile(context, 'KYC', () {
                      Get.toNamed(AppRoutes.kyc);
                    }, SvgPicture.asset(AssetImages.kyc, width: 24.w)),
                    _buildMenuTile(
                      context,
                      'Update M-Pin',
                      () {
                        Get.toNamed(AppRoutes.update);
                      },
                      SvgPicture.asset(AssetImages.updatePin, width: 24.w),
                    ),

                    _buildMenuTile(
                      context,
                      'Privacy Policy',
                      () {},
                      SvgPicture.asset(AssetImages.privacyPolicy, width: 24.w),
                    ),
                    _buildMenuTile(
                      context,
                      'Rating & Review',
                          () {
                        //Get.toNamed(AppRoutes.profile);
                      },
                      SvgPicture.asset(AssetImages.rating, width: 24.w),
                    ),
                    _buildMenuTile(
                      context,
                      'Login History',
                      () {
                        Get.toNamed(AppRoutes.loginhistory);
                      },
                      SvgPicture.asset(AssetImages.history, width: 24.w),
                    ),

                    /// 🔹 LOGOUT BUTTONS
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildLogoutButton(
                              context,
                              ' App Logout',
                              Icons.logout_rounded,
                              () {},
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: _buildLogoutButton(
                              context,
                              'Web Logout',
                              Icons.logout_rounded,
                              () {},
                              true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 🔹 VERSION TEXT
                    Text(
                      'Latest Version 1.0.0',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 45.h),
                  ],
                ),
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
    Widget leadingIcon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        leading: leadingIcon,
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

  Widget _buildLogoutButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap, [
    bool isRight = false,
  ]) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 0,
      ),
      iconAlignment: isRight ? IconAlignment.end : IconAlignment.start,
      icon: Icon(icon, color: Colors.white, size: 20.sp),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
