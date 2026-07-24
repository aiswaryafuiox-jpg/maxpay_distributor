// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:maxpay/core/constants/colors.dart';
// import 'package:maxpay/core/constants/routes_path.dart';
// import 'package:maxpay/core/utils/responsive.dart';
// import 'package:maxpay/global_widget/commom_button.dart';
// import 'package:maxpay/global_widget/custom_app.dart';
// import 'package:maxpay/view/login/widgets/login_textfield.dart';
//
// class LoginPhoneNamePage extends StatefulWidget {
//   const LoginPhoneNamePage({super.key});
//
//   @override
//   State<LoginPhoneNamePage> createState() => _LoginPhoneNamePageState();
// }
//
// class _LoginPhoneNamePageState extends State<LoginPhoneNamePage> {
//   bool _isAccepted = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final isTablet = Responsive.isTablet(context);
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: const CommonAppBar(title: "Login"),
//       body: SafeArea(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxWidth: isTablet ? 500 : double.infinity,
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: isTablet ? 30.h : 20.h),
//
//                   // Phone Number Field
//                   const PhoneNUmberField(),
//
//                   SizedBox(height: 16.h),
//
//                   // Name Field
//                   const LoginTextField(hintText: 'Enter Your Name'),
//
//                   SizedBox(height: 16.h),
//
//                   // Pincode Field
//                   const LoginTextField(
//                     hintText: 'Enter Pincode',
//                     keyboardType: TextInputType.number,
//                   ),
//
//                   SizedBox(height: 24.h),
//
//                   // Terms Checkbox
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 24.h,
//                         width: 24.w,
//                         child: Checkbox(
//                           value: _isAccepted,
//                           onChanged: (value) {
//                             setState(() {
//                               _isAccepted = value ?? false;
//                             });
//                           },
//                           fillColor: WidgetStateProperty.all(
//                             Colors.white,
//                           ), // white background
//                           checkColor: Colors.black, // black tick
//                           side: WidgetStateBorderSide.resolveWith((states) {
//                             return const BorderSide(
//                               color: Colors.black, // ALWAYS black border
//                               width: 1.5,
//                             );
//                           }),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12.w),
//                       Expanded(
//                         child: RichText(
//                           text: TextSpan(
//                             style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: isTablet ? 16.sp : 13.sp,
//                               color: colorScheme.onSurface,
//                               height: 1.5,
//                             ),
//                             children: [
//                               const TextSpan(
//                                 text: 'Registration implies acceptance of the ',
//                               ),
//                               const TextSpan(
//                                 text: 'Terms of Service',
//                                 style: TextStyle(
//                                   color: AppColors.clrPrimary,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const TextSpan(text: ' and '),
//                               const TextSpan(
//                                 text: 'Privacy Policy.',
//                                 style: TextStyle(
//                                   color: AppColors.clrPrimary,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const Spacer(),
//
//                   // Login Button
//                   // Center(
//                   //   child: CustomElevatedButton(
//                   //     text: 'Login',
//                   //     width: isTablet ? 300.w : 222.w,
//                   //     height: isTablet ? 70.h : 60.h,
//                   //     backgroundColor: AppColors.clrPrimary,
//                   //     borderRadius: 12.r,
//                   //     onPressed: () {
//                   //       Get.toNamed(AppRoutes.otpVerification);
//
//                   //     },
//                   //   ),
//                   // ),
//                   Center(
//                     child: CommonButton(
//                       title: "Login",
//                       onTap: () {
//                         Get.toNamed(AppRoutes.otpVerification);
//                       },
//                     ),
//                   ),
//
//                   SizedBox(height: 40.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PhoneNUmberField extends StatefulWidget {
//   const PhoneNUmberField({super.key});
//
//   @override
//   State<PhoneNUmberField> createState() => _PhoneNUmberFieldState();
// }
//
// class _PhoneNUmberFieldState extends State<PhoneNUmberField> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isTablet = Responsive.isTablet(context);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceBright,
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: 16.w,
//         vertical: isTablet ? 12.h : 4.h,
//       ),
//       child: Row(
//         children: [
//           CountryCodePicker(
//             initialSelection: 'IN',
//             favorite: const ['IN', '+91'],
//             showFlag: true,
//             showFlagDialog: true,
//             padding: EdgeInsets.zero,
//             dialogTextStyle: TextStyle(
//               fontFamily: 'Lufga',
//               fontSize: isTablet ? 18.sp : 14.sp,
//               color: theme.colorScheme.onSurface,
//             ),
//             searchDecoration: const InputDecoration(hintText: 'Search country'),
//             builder: (countryCode) {
//               return Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(2.r),
//                     child: Image.asset(
//                       countryCode?.flagUri ?? 'flags/in.png',
//                       package: 'country_code_picker',
//                       width: isTablet ? 32.w : 24.w,
//                       height: isTablet ? 22.h : 16.h,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Icon(
//                         Icons.flag,
//                         size: isTablet ? 32.w : 24.w,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   Text(
//                     '${countryCode?.dialCode ?? "+91"} |',
//                     style: TextStyle(
//                       fontFamily: 'Lufga',
//                       fontWeight: FontWeight.w500,
//                       fontSize: isTablet ? 20.sp : 16.sp,
//                       color: theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   SizedBox(width: 4.w),
//                   Icon(
//                     Icons.keyboard_arrow_down,
//                     color: theme.colorScheme.onSurface,
//                     size: isTablet ? 24.w : 20.w,
//                   ),
//                 ],
//               );
//             },
//           ),
//           SizedBox(width: 8.w),
//           Expanded(
//             child: TextField(
//               style: TextStyle(
//                 fontFamily: 'Lufga',
//                 color: theme.colorScheme.onSurface,
//                 fontSize: isTablet ? 20.sp : 16.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//               decoration: InputDecoration(
//                 hintText: 'Your phone no',
//                 hintStyle: TextStyle(
//                   fontFamily: 'Lufga',
//                   color: theme.colorScheme.onSurface,
//                   fontSize: isTablet ? 20.sp : 16.sp,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 border: InputBorder.none,
//               ),
//               keyboardType: TextInputType.phone,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class LoginPhoneNamePage extends StatefulWidget {
  const LoginPhoneNamePage({super.key});

  @override
  State<LoginPhoneNamePage> createState() => _LoginPhoneNamePageState();
}

class _LoginPhoneNamePageState extends State<LoginPhoneNamePage> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,

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
                  const PhoneNUmberField(),

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
                          fillColor:
                          WidgetStateProperty.all(Colors.white),
                          checkColor: Colors.black,
                          side:
                          WidgetStateBorderSide.resolveWith((states) {
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
                                text:
                                "Registration implies acceptance of the ",
                              ),
                              TextSpan(
                                text: "Terms of Service",
                                style: TextStyle(
                                  color: AppColors.clrPrimary,
                                ),
                              ),
                              TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy.",
                                style: TextStyle(
                                  color: AppColors.clrPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // const Spacer(),
                  //
                  // /// BUTTON
                  // Center(
                  //   child: CommonButton(
                  //     title: "Submit",
                  //     onTap: () {
                  //       Get.toNamed(AppRoutes.otpVerification);
                  //     },
                  //   ),
                  // ),
                  //
                  // SizedBox(height: 40.h),
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
                        Get.toNamed(AppRoutes.otpVerification);
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
  const PhoneNUmberField({super.key});

  @override
  State<PhoneNUmberField> createState() => _PhoneNUmberFieldState();
}

class _PhoneNUmberFieldState extends State<PhoneNUmberField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : const Color(0xFFF8F9FA),
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
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15.sp,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Your phone no",
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
