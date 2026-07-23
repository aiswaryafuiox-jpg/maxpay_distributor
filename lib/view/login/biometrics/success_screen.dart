import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => navigator?.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: colorScheme.onSurface,
            size: 20.sp,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 500 : double.infinity,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: isTablet ? 60.h : 40.h),
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 32.sp : 24.sp,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: isTablet ? 80.h : 60.h),
                // Illustration
                Image.asset(
                  AssetImages.successLogin,
                  height: isTablet ? 400.h : 280.h,
                  width: isTablet ? 420.w : 300.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: isTablet ? 80.h : 60.h),
                Text(
                  'Your account has been created\nsuccessful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: isTablet ? 20.sp : 16.sp,
                    color: AppColors.clrTextgrey,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                CustomElevatedButton(
                  text: 'Go to Home',
                  height: isTablet ? 70.h : 56.h,
                  onPressed: () {
                    Get.toNamed(AppRoutes.main);
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
