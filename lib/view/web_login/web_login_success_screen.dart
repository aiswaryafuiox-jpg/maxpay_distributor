import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class WebLoginSuccessScreen extends StatelessWidget {
  const WebLoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  color: Color(0xFF4ade80),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 80),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Web Login Successful !!!",
                style: TextStyle(
                  color: Color(0xFF4ade80),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: CommonButton(
                  title: "Done",
                  onTap: () {
                    Get.offNamedUntil(AppRoutes.main, (route) => false);
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
