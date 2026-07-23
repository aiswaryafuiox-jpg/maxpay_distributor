// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/route_manager.dart';
// import 'package:go_router/go_router.dart';
// import 'package:maxpay/core/constants/colors.dart';
// import 'package:maxpay/core/utils/responsive.dart';
// import 'package:maxpay/core/constants/routes_path.dart';
// import 'package:maxpay/view/login/widgets/custom_numeric_keyboard.dart';
// import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
// import 'package:pinput/pinput.dart';
//
// class PinCodeCreationPage extends StatefulWidget {
//   const PinCodeCreationPage({super.key});
//
//   @override
//   State<PinCodeCreationPage> createState() => _PinCodeCreationPageState();
// }
//
// class _PinCodeCreationPageState extends State<PinCodeCreationPage> {
//   final TextEditingController _pinController = TextEditingController();
//   bool _showAddButton = false;
//
//   void _handleKeyPress(String key) {
//     setState(() {
//       if (key == 'backspace') {
//         if (_pinController.text.isNotEmpty) {
//           _pinController.text = _pinController.text.substring(
//             0,
//             _pinController.text.length - 1,
//           );
//         }
//       } else if (key == 'submit') {
//         if (_pinController.text.length == 4) {
//           context.push(AppRoutes.successScreen);
//         }
//       } else {
//         if (_pinController.text.length < 4) {
//           _pinController.text += key;
//         }
//       }
//       _showAddButton = _pinController.text.length == 4;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final isTablet = Responsive.isTablet(context);
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => navigator?.pop(),
//           icon: Icon(
//             Icons.arrow_back_ios_new,
//             color: colorScheme.onSurface,
//             size: 20.sp,
//           ),
//         ),
//       ),
//       body: Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: isTablet ? 500 : double.infinity,
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: isTablet ? 40.h : 20.h),
//                 Text(
//                   'Create your Pin code',
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w700,
//                     fontSize: isTablet ? 32.sp : 24.sp,
//                     color: colorScheme.onSurface,
//                   ),
//                 ),
//                 SizedBox(height: 40.h),
//
//                 /// 🔹 PIN INPUT (Pinput)
//                 Center(
//                   child: Pinput(
//                     length: 4,
//                     controller: _pinController,
//                     readOnly: true,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     defaultPinTheme: PinTheme(
//                       width: isTablet ? 70.w : 56.w,
//                       height: isTablet ? 70.w : 56.w,
//                       textStyle: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: isTablet ? 28.sp : 22.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.clrPrimary,
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                     ),
//                     focusedPinTheme: PinTheme(
//                       width: isTablet ? 70.w : 56.w,
//                       height: isTablet ? 70.w : 56.w,
//                       textStyle: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: isTablet ? 28.sp : 22.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.clrPrimary,
//                         borderRadius: BorderRadius.circular(10.r),
//                         border: Border.all(
//                           color: colorScheme.onSurface,
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const Spacer(),
//
//                 /// 🔹 ACTION BUTTONS / KEYBOARD
//                 AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300),
//                   child: _showAddButton
//                       ? Row(
//                           key: const ValueKey('action_buttons'),
//                           children: [
//                             Expanded(
//                               child: TextButton(
//                                 onPressed: () => navigator?.pop(),
//                                 child: Text(
//                                   'Cancel',
//                                   style: TextStyle(
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 16.sp,
//                                     color: colorScheme.onSurface,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16.w),
//                             Expanded(
//                               child: CustomElevatedButton(
//                                 text: 'Add',
//                                 height: isTablet ? 70.h : 50.h,
//                                 onPressed: () {
//                                   Get.toNamed(AppRoutes.successScreen);
//                                 },
//                               ),
//                             ),
//                           ],
//                         )
//                       : Padding(
//                           key: const ValueKey('keyboard'),
//                           padding: EdgeInsets.only(bottom: 20.h),
//                           child: CustomNumericKeyboard(
//                             onKeyPressed: _handleKeyPress,
//                           ),
//                         ),
//                 ),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/widget/pin_box_widget.dart';

class PinCodeCreationPage extends StatefulWidget {
  const PinCodeCreationPage({super.key});

  @override
  State<PinCodeCreationPage> createState() => _PinCodeCreationPageState();
}

class _PinCodeCreationPageState extends State<PinCodeCreationPage> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pin = _pinController.text;
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: ""),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),

          child: Column(
            children: [

              SizedBox(height: 40.h),

              /// TITLE
              Center(
                child: Text(
                  "Create your M-PIN",
                  style: TextHelper.max13(context).copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              SizedBox(height: 45.h),

              /// PIN BOXES
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                        (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: PinBoxWidget(
                        number:
                        index < pin.length ? pin[index] : "",
                      ),
                    ),
                  ),
                ),
              ),

              /// Hidden TextField
              SizedBox(
                width: 1,
                height: 1,
                child: TextField(
                  controller: _pinController,
                  focusNode: _focusNode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),

              const Spacer(),

              if (pin.length == 4)
                Row(
                  children: [

                    Expanded(
                      child: InkWell(
          onTap: () async {
    FocusScope.of(context).unfocus();

    await Future.delayed(const Duration(milliseconds: 150));

    _pinController.clear();

    if (mounted) {
    setState(() {});
    }

    Get.back();
    },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextHelper.max4.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 18.w),

                    Expanded(
                      child: CommonButton(
                        title: "Add",onTap: () {
                        // Close keyboard
                        FocusScope.of(context).unfocus();

                        // Wait for keyboard to close
                        Future.delayed(const Duration(milliseconds: 200), () {
                          Get.toNamed(AppRoutes.successScreen);
                        });
                      },
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
