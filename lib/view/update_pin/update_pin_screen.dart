import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/widget/pin_textfield_widget.dart';
import 'package:maxpay/controller/update_pin_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class UpdatePinPage extends StatelessWidget {
  const UpdatePinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(sl<UpdatePinController>());

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
              style: TextHelper.pin.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              )
            ),
            SizedBox(height: 10.h),
            PinTextFieldWidget(
              hintText: "Enter M-Pin",
              controller: controller.newPinController,
            ),
            SizedBox(height: 24.h),
            Text(
              "Confirm M-Pin",
              style: TextHelper.pin.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              )
            ),
            SizedBox(height: 10.h),
            PinTextFieldWidget(
              hintText: "Confirm M-Pin",
              controller: controller.confirmPinController,
            ),
            const Spacer(),
            Center(
              child: Obx(() => CommonButton(
                title: controller.isLoading.value ? "Updating..." : "Submit",
                onTap: controller.isLoading.value 
                  ? () {} 
                  : () {
                      controller.updatePin();
                    },
              )),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
