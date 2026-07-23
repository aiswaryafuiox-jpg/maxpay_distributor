import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/add_wallet/widge/add_wallet_dialogue.dart';
import 'package:maxpay/view/add_wallet/widge/add_wallet_widget.dart';

class AddWalletScreen extends StatelessWidget {
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
              padding: const EdgeInsets.only(top: 5,left:0,right:0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(
                    AssetImages.addWallet1,
                    height: 345,
                    width:346,
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
              style: TextStyle(
                color: colorScheme.onSurface,
              ),
             decoration: InputDecoration(
  hintText: "Enter Amount",
  hintStyle: TextStyle(
    color: theme.colorScheme.onTertiaryFixedVariant,
  ),

  filled: true,
  fillColor: theme.brightness == Brightness.dark
      ? AppColors.darkplceholder
      : AppColors.background,

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
    borderSide: BorderSide.none,
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  ),
),
            ),

            const SizedBox(height: 18),

            /// SUBMIT BUTTON
            Center(
              child: CommonButton(
                title: "Submit",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddWalletPopup(),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            /// RECENT TRANSACTIONS
            Text("Recent Transactions", style: TextHelper.max10(context)),

            const SizedBox(height: 14),

            transactionCard(
              context: context,
              status: "Failed",
              statusColor: Colors.red,
              amount: "₹ 500.00",
            ),

            const SizedBox(height: 12),

            transactionCard(
              context: context,
              status: "Success",
              statusColor: Colors.green,
              amount: "₹ 500.00",
            ),

            const SizedBox(height: 12),

            transactionCard(
              context: context,
              status: "Processing",
              statusColor: Colors.orange,
              amount: "₹ 500.00",
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
