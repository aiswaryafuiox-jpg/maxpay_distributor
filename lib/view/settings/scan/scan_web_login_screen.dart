import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:maxpay/controller/web_login_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/constants/asset_images.dart';

class ScanWebLoginScreen extends StatefulWidget {
  const ScanWebLoginScreen({super.key});

  @override
  State<ScanWebLoginScreen> createState() => _ScanWebLoginScreenState();
}

class _ScanWebLoginScreenState extends State<ScanWebLoginScreen> {
  final WebLoginController controller = Get.put(sl<WebLoginController>());
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

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
                color: Colors.black.withValues(alpha: 0.35),
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

                /// Scanner
                Center(
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: MobileScanner(
                        controller: cameraController,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isNotEmpty) {
                            final String? code = barcodes.first.rawValue;
                            if (code != null) {
                              controller.onQrScanned(code);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  return const SizedBox.shrink();
                }),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}