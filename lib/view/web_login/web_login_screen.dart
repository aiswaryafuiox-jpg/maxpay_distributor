import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WebLoginScreen extends StatelessWidget {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkbgBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkbgBlack,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.clrBg),
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
        brightness: Brightness.dark,
        surface: AppColors.darkbgBlack,
        onSurface: AppColors.clrBg,
        onSurfaceVariant: AppColors.textclr,
        outline: AppColors.darkFilterBorder,
        surfaceBright: AppColors.darkplceholder,
      ),
    );

    final inputDecoration = _darkInputDecoration();
    final inputStyle = TextHelper.max8.copyWith(color: AppColors.clrBg);

    return Theme(
      data: darkTheme,
      child: Scaffold(
        backgroundColor: AppColors.darkbgBlack,
        appBar: CommonAppBar(title: "Web Signup"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Email
              TextField(
                cursorColor: AppColors.clrPrimary,
                style: inputStyle,
                decoration: inputDecoration.copyWith(
                  hintText: "Sample@gmail.com",
                ),
              ),

              const SizedBox(height: 15),

              /// Password
              TextField(
                obscureText: true,
                cursorColor: AppColors.clrPrimary,
                style: inputStyle,
                decoration: inputDecoration.copyWith(
                  hintText: "Enter Password",
                ),
              ),

              const SizedBox(height: 15),

              /// Re-enter Password
              TextField(
                obscureText: true,
                cursorColor: AppColors.clrPrimary,
                style: inputStyle,
                decoration: inputDecoration.copyWith(
                  hintText: "Re-enter Password",
                ),
              ),

              const Spacer(),

              /// Submit Button
              CommonButton(
                title: "Submit",
                onTap: () {
                  Get.toNamed(AppRoutes.webotp);
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _darkInputDecoration() {
    return InputDecoration(
      hintStyle: TextHelper.max8.copyWith(color: AppColors.textclr),
      filled: true,
      fillColor: AppColors.darkplceholder,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkFilterBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.clrPrimary),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkFilterBorder),
      ),
    );
  }
}
