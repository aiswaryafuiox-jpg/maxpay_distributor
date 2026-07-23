import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/widget/pin_textfield_widget.dart';

class UpdatePinPage extends StatelessWidget {
  const UpdatePinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Update M-Pin"),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),

            Text(
              "New M-Pin (4 digits only)",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),

            SizedBox(height: 10.h),

            const PinTextFieldWidget(hintText: "Enter M-Pin"),

            SizedBox(height: 24.h),

            Text(
              "Confirm M-Pin",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),

            SizedBox(height: 10.h),

            const PinTextFieldWidget(hintText: "Confirm M-Pin"),

            const Spacer(),

            Center(
              child: CommonButton(
                title: "Submit",
                onTap: () {
                  Get.toNamed(AppRoutes.veirfypin);
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
