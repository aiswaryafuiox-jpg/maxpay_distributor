import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transfer&details/lowwallet/widget/low_wallet_card.dart';
import 'package:maxpay/controller/low_wallet_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class LowWalletScreen extends StatefulWidget {
  const LowWalletScreen({super.key});

  @override
  State<LowWalletScreen> createState() => _LowWalletScreenState();
}

class _LowWalletScreenState extends State<LowWalletScreen> {
  final controller = Get.put(sl<LowWalletController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "Low Wallet"),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.retailers.isEmpty) {
            return const Center(child: Text("No low wallet retailers found"));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.retailers.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (_, index) {
              final item = controller.retailers[index];
              return LowWalletCard(
                retailerName: item.retailerName ?? "-",
                mobile: item.regMobileNumber ?? "-",
                amount: "₹${item.walletAmount ?? '0.00'}",
              );
            },
          );
        }),
      ),
    );
  }
}
