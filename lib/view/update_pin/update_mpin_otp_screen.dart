import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/widget/pin_textfield_widget.dart';
import 'package:maxpay/controller/update_pin_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class UpdateMpinOtpPage extends StatelessWidget {
  const UpdateMpinOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(sl<UpdatePinController>());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Verify OTP"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              "Enter the 4-digit OTP sent to your registered mobile number.",
              style: TextHelper.max1.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "OTP",
              style: TextHelper.pin.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10.h),
            PinTextFieldWidget(
              hintText: "Enter OTP",
              controller: controller.otpController,
            ),
            const Spacer(),
            Center(
              child: CommonButton(
                title: "Verify",
                onTap: () {
                  controller.onOtpVerify();
                },
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
