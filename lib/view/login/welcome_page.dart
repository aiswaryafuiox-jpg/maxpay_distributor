import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isTablet = Responsive.isTablet(context);

    return Obx(() {
      final isDark = themeController.isDarkMode;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: AppColors.clrPrimary,
          onPressed: () {
            themeController.toggleTheme();
          },
          child: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 1.sh),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Subtle background "P" element - Scaled with ScreenUtil
                Positioned(
                  right: -40.w,
                  top: -100.h,
                  child: IgnorePointer(
                    child: Stack(
                      children: <Widget>[
                        Text(
                          'P',
                          style: TextStyle(
                            fontSize: 420.r,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = (AppColors.clrTextgrey).withValues(
                                alpha: .08,
                              ),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          'P',
                          style: TextStyle(
                            fontSize: 420.r,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Subtle background "L" element - Scaled with ScreenUtil
                Positioned(
                  left: -40.w,
                  bottom: 20.h,
                  child: IgnorePointer(
                    child: Stack(
                      children: <Widget>[
                        Text(
                          'L',
                          style: TextStyle(
                            fontSize: 420.r,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = (AppColors.clrTextgrey).withValues(
                                alpha: .08,
                              ),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          'L',
                          style: TextStyle(
                            fontSize: 420.r,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 600 : double.infinity,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: isTablet ? 120.h : 80.h),
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTablet ? 64.sp : 48.sp,
                                    color: AppColors.clrPrimary,
                                    letterSpacing: -1.0,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  'Lets get started',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: isTablet ? 28.sp : 20.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 125.h),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h, left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Existing customer / Get started',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: isTablet ? 20.sp : 16.sp,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Center(
                                    child: CustomElevatedButton(
                                      width: isTablet ? 300.w : 222.w,
                                      height: isTablet ? 60.h : 48.h,
                                      text: 'Sign in',
                                      onPressed: () =>
                                      Get.toNamed(AppRoutes.selectSim)
                                         
                                    ),
                                  ),
                                  SizedBox(height: 32.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'New customer? ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: isTablet ? 20.sp : 16.sp,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.toNamed(AppRoutes.selectSim),
                                        child: Text(
                                          'Create new account',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: isTablet ? 20.sp : 16.sp,
                                            color: AppColors.clrPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
