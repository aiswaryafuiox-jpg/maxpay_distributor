import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transfer&details/lowwallet/widget/low_wallet_card.dart';

class LowWalletScreen extends StatelessWidget {
  const LowWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Low Wallet",
      ),

      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (_, index) {
            return const LowWalletCard(
              retailerName: "Klein Moriarti",
              mobile: "9782452130",
              amount: "₹500.00",
            );
          },
        ),
      ),
    );
  }
}