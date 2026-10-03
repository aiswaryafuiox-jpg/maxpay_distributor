import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:pinput/pinput.dart';
import 'package:maxpay/view/login/widgets/resend_timer_widget.dart';
import 'package:flutter/services.dart';
import '../../controller/login_controller.dart';

class ScreenOtpVerification extends StatefulWidget {
  const ScreenOtpVerification({super.key});

  @override
  State<ScreenOtpVerification> createState() => _ScreenOtpVerificationState();
}

class _ScreenOtpVerificationState extends State<ScreenOtpVerification>
    with WidgetsBindingObserver {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  String? _clipboardOtp;
  Set<String> _pastedOtps = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkClipboardForOtp();
    }
  }

  Future<void> _checkClipboardForOtp() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final text = clipboardData?.text;

      if (text != null && text.isNotEmpty) {
        final regExp = RegExp(r'\b\d{4}\b');
        final match = regExp.firstMatch(text);

        if (match != null) {
          final otp = match.group(0);
          if (otp != null && !_pastedOtps.contains(otp)) {
            setState(() {
              _clipboardOtp = otp;
            });
          }
        }
      }
    } catch (e) {
      debugPrint("Clipboard error: $e");
    }
  }

  void _verifyOtp() {
    if (_otpController.text.length == 4) {
      final controller = Get.find<LoginController>();
      controller.verifyOtp(_otpController.text);
    }
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
                          "Please enter the verification code\nsent to your phone number",
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
                          controller: _otpController,
                          enabled: true,
                          showCursor: true,
                          keyboardType: TextInputType.number,
                          onTap: () => otpFocusNode.requestFocus(),
                          onCompleted: (pin) => _verifyOtp(),
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

                        SizedBox(height: 20.h),

                        /// 🔹 Timer
                        ResendTimerWidget(
                          onResend: () {
                            final controller = Get.find<LoginController>();
                            controller.sendOtp();
                          },
                        ),

                        SizedBox(height: 20.h),

                        // 🔹 Paste Button
                      ],
                    ),
                  ),
                ),

                /// VERIFY BUTTON
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
                  child: Obx(
                    () => CustomElevatedButton(
                      text: 'Verify OTP',
                      onPressed: _verifyOtp,
                      isLoading: Get.find<LoginController>().isLoading.value,
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
