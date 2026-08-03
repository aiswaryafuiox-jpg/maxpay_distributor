import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/global_widget/wallet_balance_card.dart';
import 'package:maxpay/view/add_wallet_home/widge/add_wallet_widget.dart';

class WalletBalanceScreen extends GetView<AddWalletController> {
  const WalletBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Wallet Balance"),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: .symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            const WalletBalanceCard(),
            const SizedBox(height: 20),
            Text(
              "Recent Transactions",
              style: TextHelper.max10(context).copyWith(fontFamily: 'Poppins'),
            ),

            const SizedBox(height: 20),

            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.walletQrHistory.value.data?.isEmpty ?? true) {
                return Center(child: Text("No Transactions"));
              }
              return Column(
                spacing: 12,
                crossAxisAlignment: .start,
                children: [
                  ...(controller.walletQrHistory.value.data ?? []).map(
                    (e) => transactionCard(
                      context: context,
                      txnId: e.txnId ?? '',

                      dateTime: e.dateTime ?? '',
                      status: e.status?.capitalize ?? '',

                      statusColor: e.status == 'pending'
                          ? Colors.orange
                          : e.status == 'failed'
                          ? Colors.red
                          : Colors.green,
                      amount: e.amount ?? '',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
