import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class ScanWebLoginScreen extends StatelessWidget {
  const ScanWebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              AssetImages.webLoginBg,
              fit: BoxFit.cover,
            ),
          ),

          /// Blur + Dark Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// Custom AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 150),
                          );
                          Get.back();
                        },
                      ),

                      const SizedBox(width: 4),

                      const Text(
                        "Scan & Web Login",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Scanner + QR
                Center(
                  child: SizedBox(
                    width: 350,
                    height: 400,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AssetImages.scanWeb,
                          width: 320,
                          height: 320,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),

                SizedBox(
                  width: 160,
                  child: CommonButton(
                    title: "Submit",
                    onTap: () {},
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}