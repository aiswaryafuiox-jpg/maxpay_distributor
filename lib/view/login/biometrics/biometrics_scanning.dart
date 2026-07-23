import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';

class BiometricsScanningPage extends StatelessWidget {
  const BiometricsScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clrBg,
      appBar: AppBar(
        backgroundColor: AppColors.clrBg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => navigator?.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Text(
              'Place Your Finger',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: AppColors.clrTextblack,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Put your finger on the sensor and lift after you feel a vibration',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
                color: AppColors.clrTextgrey,
              ),
            ),
            SizedBox(height: 80.h),
            Center(
              child: Icon(
                Icons.fingerprint,
                size: 150.r,
                color: Color(0xFF34C759),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomElevatedButton(
                    text: 'Add',
                    height: 50.h, onPressed: () {  },
                    //onPressed: () => Get.toNamed(AppRoutes.successScreen),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
