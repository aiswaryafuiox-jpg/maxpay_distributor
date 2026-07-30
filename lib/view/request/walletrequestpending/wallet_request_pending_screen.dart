import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/request/walletrequestpending/widget/wallet_request_pending_form.dart';

import 'package:get/get.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controller/pending_wallet_request_controller.dart';
// ... other imports

class WalletRequestPendingScreen extends StatefulWidget {
  const WalletRequestPendingScreen({super.key});

  @override
  State<WalletRequestPendingScreen> createState() =>
      _WalletRequestPendingScreenState();
}

class _WalletRequestPendingScreenState
    extends State<WalletRequestPendingScreen> {
  final controller = Get.put(sl<PendingWalletRequestController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: CommonAppBar(title: "Wallet Request Pending"),

      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: WalletRequestPendingForm(),
        ),
      ),
    );
  }
}
