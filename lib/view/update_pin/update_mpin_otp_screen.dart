import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/update_pin_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/view/login/widgets/custom_numeric_keyboard.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:maxpay/view/login/widgets/resend_timer_widget.dart';
import 'package:pinput/pinput.dart';

class UpdateMpinOtpPage extends StatefulWidget {
  const UpdateMpinOtpPage({super.key});

  @override
  State<UpdateMpinOtpPage> createState() => _UpdateMpinOtpPageState();
}

class _UpdateMpinOtpPageState extends State<UpdateMpinOtpPage> {
  late final UpdatePinController _controller;
  bool _showVerifyButton = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<UpdatePinController>()
        ? Get.find<UpdatePinController>()
        : Get.put(sl<UpdatePinController>());
    _controller.otpController.clear();
    _showVerifyButton = _controller.otpController.text.length == 4;
  }

  void _handleKeyPress(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_controller.otpController.text.isNotEmpty) {
          _controller.otpController.text = _controller.otpController.text
              .substring(0, _controller.otpController.text.length - 1);
        }
      } else if (key == 'submit') {
        if (_controller.otpController.text.length == 4) {
          _controller.onOtpVerify();
        }
      } else {
        if (_controller.otpController.text.length < 4) {
          _controller.otpController.text += key;
        }
      }

      // Automatically show verify button when 4 digits are entered
      _showVerifyButton = _controller.otpController.text.length == 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : double.infinity,
            ),
            child: Column(
              children: [
                /// 🔹 HEADER / BACK BUTTON
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => navigator?.pop(),
                      child: Container(
                        width: 45.w,
                        height: 45.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 18.sp),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: isTablet ? 40.h : 20.h),

                        /// 🔹 Title
                        Text(
                          'Verification code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: isTablet ? 28.sp : 22.sp,
                            color: colorScheme.onSurface,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        /// 🔹 Subtitle
                        Text(
                          "Please type the verification code\nsent to your phone number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: isTablet ? 16.sp : 14.sp,
                            color: AppColors.clrTextgrey,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 40.h),

                        /// 🔹 OTP FIELD (Pinput)
                        Pinput(
                          length: 4,
                          controller: _controller.otpController,
                          readOnly: true,
                          mainAxisAlignment: MainAxisAlignment.center,
                          submittedPinTheme: PinTheme(
                            width: isTablet ? 70.w : 60.w,
                            height: isTablet ? 70.w : 60.w,
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 28.sp : 24.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.clrBg,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.clrPrimary,
                            ),
                          ),
                          defaultPinTheme: PinTheme(
                            width: isTablet ? 70.w : 60.w,
                            height: isTablet ? 70.w : 60.w,
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 28.sp : 24.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.surfaceBright,
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: isTablet ? 70.w : 60.w,
                            height: isTablet ? 70.w : 60.w,
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 28.sp : 24.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.clrPrimary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30.h),

                        /// 🔹 Timer
                        ResendTimerWidget(
                          onResend: () {
                            _controller.sendOtp();
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                /// 🔹 NUMERIC KEYBOARD / VERIFY BUTTON
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _showVerifyButton
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
                          child: Obx(
                            () => CustomElevatedButton(
                              text: _controller.isOtpVerifying.value
                                  ? 'Verifying...'
                                  : 'Verify OTP',
                              onPressed: () {
                                if (!_controller.isOtpVerifying.value) {
                                  _controller.onOtpVerify();
                                }
                              },
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CustomNumericKeyboard(
                            onKeyPressed: _handleKeyPress,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
