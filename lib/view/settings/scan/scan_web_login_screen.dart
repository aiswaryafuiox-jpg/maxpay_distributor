import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:maxpay/controller/web_login_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class ScanWebLoginScreen extends StatefulWidget {
  const ScanWebLoginScreen({super.key});

  @override
  State<ScanWebLoginScreen> createState() => _ScanWebLoginScreenState();
}

class _ScanWebLoginScreenState extends State<ScanWebLoginScreen> {
  final WebLoginController controller = Get.put(sl<WebLoginController>());
  final MobileScannerController cameraController = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: .normal,
  );

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Scan & Web Login",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 150));
            Get.back();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
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
        ],
      ),
    );
  }
}
