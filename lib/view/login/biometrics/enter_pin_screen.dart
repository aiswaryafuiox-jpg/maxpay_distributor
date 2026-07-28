import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/login_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/login/widgets/custom_numeric_keyboard.dart';
import 'package:pinput/pinput.dart';

class PinCodeEnterPage extends StatefulWidget {
  const PinCodeEnterPage({super.key});
  @override
  State<PinCodeEnterPage> createState() => _PinCodeEnterPageState();
}

class _PinCodeEnterPageState extends State<PinCodeEnterPage> {
  final LoginController controller = Get.find<LoginController>();

  final TextEditingController pinController = TextEditingController();
  bool isUpdatePin = false;
  final RxBool showVerifyButton = false.obs;
  @override
  void initState() {
    super.initState();
    isUpdatePin = (Get.arguments as bool?) ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!isUpdatePin) {
        if (controller.isFingerPrint.value == 1) {
          await controller.authenticateWithFingerprint();
        }
      }
    });
  }

  void handleKeyPress(String key) {
    String current = pinController.text;

    if (key == 'backspace') {
      if (current.isNotEmpty) {
        current = current.substring(0, current.length - 1);
      }
    } else {
      if (current.length < 4) {
        current = current + key;
      }
    }

    pinController.value = TextEditingValue(
      text: current,
      selection: TextSelection.collapsed(offset: current.length),
    );
    showVerifyButton.value = current.length == 4;
  }

  void resetPin() {
    pinController.clear();
    showVerifyButton.value = false;
    setState(() {});
  }

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
          onPressed: () {
            if (showVerifyButton.value) {
              resetPin();
            } else {
              Get.back();
            }
          },
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 48.h : 24.h),

                Text(
                  'Enter your M-PIN',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 30.sp : 22.sp,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please enter your 4-digit security PIN to access your account.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: isTablet ? 18.sp : 13.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),

                SizedBox(height: isTablet ? 56.h : 40.h),

                Center(
                  child: Pinput(
                    length: 4,
                    controller: pinController,
                    readOnly: true,
                    defaultPinTheme: PinTheme(
                      width: isTablet ? 72.w : 58.w,
                      height: isTablet ? 72.w : 58.w,
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.clrPrimary.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: isTablet ? 72.w : 58.w,
                      height: isTablet ? 72.w : 58.w,
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isTablet ? 28.sp : 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isTablet ? 40.h : 32.h),

                /// Fingerprint Icon
                if (!isUpdatePin)
                  Obx(() {
                    if (controller.isFingerPrint.value == 1) {
                      return Center(
                        child: GestureDetector(
                          onTap: () async {
                            await controller.authenticateWithFingerprint();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.fingerprint_rounded,
                                size: isTablet ? 72.sp : 56.sp,
                                color: AppColors.clrPrimary,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Use Fingerprint',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: isTablet ? 16.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.clrPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),

                const Spacer(),

                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: showVerifyButton.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            key: const ValueKey('verify'),
                            children: [
                              Expanded(
                                child: CommonButton(
                                  title: "Verify",
                                  isLoading: controller.isLoading.value,
                                  onTap: () async {
                                    final success = await controller.verifyPin(
                                      pinController.text.trim(),
                                    );

                                    if (!success) {
                                      resetPin(); // 🔥 IMPORTANT FIX
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            key: const ValueKey('keyboard'),
                            padding: EdgeInsets.only(bottom: 24.h, top: 16.h),
                            child: CustomNumericKeyboard(
                              onKeyPressed: handleKeyPress,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
