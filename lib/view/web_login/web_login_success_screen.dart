import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WebLoginSuccessScreen extends StatelessWidget {
  const WebLoginSuccessScreen({super.key});

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
      ),
    );

    return Theme(
      data: darkTheme,
      child: Scaffold(
        backgroundColor: AppColors.darkbgBlack,
        appBar: CommonAppBar(title: ""),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: Column(
              children: [
                const SizedBox(height: 60),

                /// SUCCESS TITLE
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Success",
                        style: TextStyle(
                          color: AppColors.clrBg,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 8),

                      Icon(Icons.check_circle, color: AppColors.fav2, size: 30),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// IMAGE
                Image.asset(AssetImages.websuccess, height: 220),

                const SizedBox(height: 30),

                /// MESSAGE
                const Text(
                  "Your web link has been sent to your\nmail id please check your inbox.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.fav2, fontSize: 14),
                ),

                const Spacer(),

                /// BUTTON
                Center(
                  child: CommonButton(
                    title: "Submit",
                    onTap: () {
                      Get.toNamed(AppRoutes.setting);
                    },
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
