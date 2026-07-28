import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import '../../controller/login_controller.dart';

class LoginPhoneNamePage extends StatefulWidget {
  const LoginPhoneNamePage({super.key});
  @override
  State<LoginPhoneNamePage> createState() => _LoginPhoneNamePageState();
}

class _LoginPhoneNamePageState extends State<LoginPhoneNamePage> {
  bool _isAccepted = false;
  final LoginController controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "Login"),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),

                  /// LOGO
                  Center(
                    child: SvgPicture.asset(
                      isDark
                          ? AssetImages.splashLogoDark
                          : AssetImages.splashLogo,
                      width: 170.w,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  /// PHONE FIELD
                  PhoneNUmberField(controller: controller.phoneController),
                  SizedBox(height: 18.h),

                  /// TERMS
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22.w,
                        height: 22.h,
                        child: Checkbox(
                          value: _isAccepted,
                          onChanged: (value) {
                            setState(() {
                              _isAccepted = value ?? false;
                            });
                          },
                          fillColor: WidgetStateProperty.all(Colors.white),
                          checkColor: Colors.black,
                          side: WidgetStateBorderSide.resolveWith((states) {
                            return const BorderSide(
                              color: Colors.black,
                              width: 1.2,
                            );
                          }),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12.sp,
                              color: colorScheme.onSurface,
                              height: 1.5,
                            ),
                            children: const [
                              TextSpan(
                                text: "Registration implies acceptance of the ",
                              ),
                              TextSpan(
                                text: "Terms of Service",
                                style: TextStyle(color: AppColors.clrPrimary),
                              ),
                              TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy.",
                                style: TextStyle(color: AppColors.clrPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: MediaQuery.of(context).viewInsets.bottom > 0
                        ? 20.h
                        : 0,
                  ),
                  const Spacer(),
                  Center(
                    child: CommonButton(
                      title: "Submit",
                      onTap: () {
                        if (!_isAccepted) {
                          Get.snackbar(
                            "Terms",
                            "Please accept Terms & Conditions",
                          );
                          return;
                        }

                        if (controller.phoneController.text.trim().isEmpty) {
                          Get.snackbar("Error", "Enter mobile number");
                          return;
                        }

                        if (controller.phoneController.text.trim().length !=
                            10) {
                          Get.snackbar("Error", "Enter valid mobile number");
                          return;
                        }

                        controller.sendOtp();
                      },
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 0
                        ? 10.h
                        : 40.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNUmberField extends StatefulWidget {
  final TextEditingController controller;

  const PhoneNUmberField({super.key, required this.controller});

  @override
  State<PhoneNUmberField> createState() => _PhoneNUmberFieldState();
}

class _PhoneNUmberFieldState extends State<PhoneNUmberField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = theme.brightness == Brightness.dark;
    String? errorText;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: isTablet ? 12.h : 4.h,
      ),
      child: Row(
        children: [
          CountryCodePicker(
            initialSelection: "IN",
            favorite: const ["IN", "+91"],
            showFlag: true,
            showFlagDialog: true,
            padding: EdgeInsets.zero,
            builder: (countryCode) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2.r),
                    child: Image.asset(
                      countryCode?.flagUri ?? "flags/in.png",
                      package: "country_code_picker",
                      width: 24.w,
                      height: 16.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${countryCode?.dialCode ?? "+91"} |",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              );
            },
          ),

          SizedBox(width: 8.w),

          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    errorText = null;
                  } else if (value.length < 10) {
                    errorText = "Phone number must be 10 digits";
                  } else {
                    errorText = null;
                  }
                });
              },
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15.sp,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: "Your phone no",
                errorText: errorText,
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15.sp,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
