import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:maxpay/controller/ip_address_controller.dart';

import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);
    final args = Get.arguments as Map<String, String>;
    final title = args['title'];
    final message = args['message'];

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
                  title ?? 'Congratulations!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 22.sp : 20.sp,
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
                  message ?? 'Your account has been created\nsuccessful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: isTablet ? 20.sp : 14.sp,
                    color: AppColors.clrTextgrey,
                    height: 1.5,
                  ),
                ),
                const Spacer(),

                CommonButton(
                  title: title != "Registration Successful"
                      ? "Continue"
                      : "Go to Home",
                  onTap: () async {
                    if (title == "Registration Successful") {
                      final storage = LocalStorageService();
                      await storage.init();

                      final controller = Get.put(
                        IpAddressController(ipAddressUseCase: sl()),
                      );

                      await controller.saveIpAddress();
                    }

                    Get.offAllNamed(AppRoutes.main);
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
