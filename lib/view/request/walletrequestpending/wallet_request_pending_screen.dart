import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/request/walletrequestpending/widget/wallet_request_pending_form.dart';

import '../../nav_page/navbar_provider.dart';

class WalletRequestPendingScreen extends StatelessWidget {
  const WalletRequestPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: CommonAppBar(
        title: "Wallet Request Pending",
        onBack: () {
          Get.find<NavbarController>().setIndex(0);
        },
      ),

      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: WalletRequestPendingForm(),
        ),
      ),
    );
  }
}