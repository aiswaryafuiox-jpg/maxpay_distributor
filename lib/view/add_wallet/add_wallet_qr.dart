import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/add_wallet/widge/add_wallet_dialogue.dart';
import 'package:maxpay/view/add_wallet/widge/add_wallet_widget.dart';

class AddWalletScreen extends GetView<AddWalletController> {
  const AddWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Add Wallet"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// QR IMAGE CONTAINER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(
                    AssetImages.addwallet,
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// AMOUNT TITLE
            Text("Amount", style: TextHelper.max9(context)),

            const SizedBox(height: 8),

            TextFormField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: "Enter Amount",
                hintStyle: TextStyle(
                  color: theme.colorScheme.onTertiaryFixedVariant,
                ),
                filled: true,
                fillColor: colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// SUBMIT BUTTON
            Center(
              child: CommonButton(title: "Submit", onTap: () {}),
            ),

            const SizedBox(height: 28),

            /// RECENT TRANSACTIONS
            Text("Recent Transactions", style: TextHelper.max10(context)),

            const SizedBox(height: 14),

            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.walletQrHistory.value.data?.list?.isEmpty ??
                  true) {
                return Center(child: Text("No Transactions"));
              }
              return Column(
                spacing: 12,
                crossAxisAlignment: .start,
                children: [
                  ...(controller.walletQrHistory.value.data?.list ?? []).map(
                    (e) => transactionCard(
                      context: context,
                      txnId: e.transactionId ?? '',

                      dateTime: e.dateTime ?? '',
                      status: e.status?.capitalize ?? '',

                      statusColor: e.status == 'pending'
                          ? Colors.orange
                          : e.status == 'failed'
                          ? Colors.red
                          : Colors.green,
                      amount: e.amount?.currencyIndian ?? '',
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
