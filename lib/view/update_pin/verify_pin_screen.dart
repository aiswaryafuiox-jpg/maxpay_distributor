import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/widget/pin_box_widget.dart';

class VerifyPinPage extends StatefulWidget {
  const VerifyPinPage({super.key});

  @override
  State<VerifyPinPage> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  final TextEditingController pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String pin = pinController.text;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: ""),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            Text("Verify OTP", style: TextHelper.max13(context)),

            SizedBox(height: 40.h),

            /// PIN BOXES
            // Row(
            //   children: List.generate(
            //     4,
            //     (index) =>
            //         PinBoxWidget(number: index < pin.length ? pin[index] : ""),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                children: List.generate(
                  4,
                      (index) => PinBoxWidget(
                    number: index < pin.length ? pin[index] : "",
                  ),
                ),
              ),
            ),
            /// HIDDEN TEXTFIELD
            Opacity(
              opacity: 0,
              child: TextField(
                controller: pinController,
                autofocus: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),

            const Spacer(),

            Center(
              child: CommonButton(
                title: "Continue",
                onTap: () {
                  if (pin.length == 4) {
                    Get.back();
                  }
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
