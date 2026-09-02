import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/add_wallet_home/widge/add_wallet_widget.dart';

class AddWalletScreenMain extends GetView<AddWalletController> {
  const AddWalletScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Add Wallet"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------------------------
              // IMAGE
              // ----------------------------------------------------------
              Container(
                height: 240.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset.zero,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    AssetImages.addwallet,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ----------------------------------------------------------
              // AMOUNT TITLE
              // ----------------------------------------------------------
              Text(
                "Amount",
                style: TextHelper.max9(context).copyWith(fontFamily: 'Poppins'),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: controller.amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: "Enter Amount",

                  prefixIcon: SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        "₹",
                        style: TextHelper.max9(
                          context,
                        ).copyWith(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  hintStyle: TextStyle(
                    color: theme.colorScheme.onTertiaryFixedVariant,
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
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

              Center(
                child: CommonButton(
                  title: "Submit",
                  onTap: () async {
                    final amount = controller.amountController.text.trim();

                    if (amount.isEmpty) {
                      Get.snackbar(
                        "Alert",
                        "Please Enter Amount",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    final parsedAmount = double.tryParse(amount);

                    if (parsedAmount == null || parsedAmount <= 0) {
                      Get.snackbar(
                        "Alert",
                        "Please Enter a Valid Amount",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    await controller.createQr(amount);
                  },
                ),
              ),

              const SizedBox(height: 28),

              // ----------------------------------------------------------
              // RECENT TRANSACTIONS
              // ----------------------------------------------------------
              Text(
                "Recent Transactions",
                style: TextHelper.max10(
                  context,
                ).copyWith(fontFamily: 'Poppins'),
              ),

              const SizedBox(height: 20),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.walletQrHistory.value.data?.list?.isEmpty ??
                    true) {
                  return const Center(child: Text("No Transactions"));
                }

                return Column(
                  children: [
                    ...(controller.walletQrHistory.value.data?.list ?? []).map((
                      e,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: transactionCard(
                          context: context,
                          txnId: e.transactionId ?? '',
                          dateTime: e.dateTime ?? '',
                          status: e.status?.capitalize ?? '',
                          statusColor: e.status == 'pending'
                              ? Colors.orange
                              : e.status == 'failed'
                              ? Colors.red
                              : Colors.green,
                          amount: e.amount?.toString() ?? '',
                        ),
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ======================================================================
  // CONVERT BACKEND LINK TO WORKING STANDARD UPI LINK
  // ======================================================================

  String _buildWorkingUpiUrl({
    required String backendLink,
    required String amount,
  }) {
    try {
      final uri = Uri.tryParse(backendLink);

      if (uri == null) {
        debugPrint("Invalid backend URL");
        return '';
      }

      final params = uri.queryParameters;

      final pa = params['pa'];
      final pn = params['pn'];

      if (pa == null || pa.trim().isEmpty) {
        debugPrint("UPI ID (pa) not found");
        return '';
      }

      final upiUri = Uri(
        scheme: 'upi',
        host: 'pay',
        queryParameters: {
          'pa': pa,
          'pn': pn ?? 'AJ SYSTEMS & SERVICES',
          'am': amount,
          'cu': 'INR',
        },
      );

      final result = upiUri.toString();

      debugPrint("Generated working UPI URL = $result");

      return result;
    } catch (e) {
      debugPrint("UPI URL conversion error = $e");

      return '';
    }
  }
}

// ==========================================================================
// UPI PAYMENT DIALOG
// ==========================================================================

class UpiPaymentDialog extends StatelessWidget {
  final String upiUrl;
  final String amount;

  const UpiPaymentDialog({
    super.key,
    required this.upiUrl,
    required this.amount,
  });

  // ------------------------------------------------------------------------
  // OPEN UPI APP
  // ------------------------------------------------------------------------

  Future<void> _openUpiApp() async {
    try {
      final uri = Uri.parse(upiUrl);

      debugPrint("UPI payment URL = $upiUrl");

      final canOpen = await canLaunchUrl(uri);

      debugPrint("Can open UPI = $canOpen");

      if (!canOpen) {
        Get.snackbar(
          "Payment Error",
          "No UPI application found",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("UPI launch error = $e");

      Get.snackbar(
        "Payment Error",
        "Unable to open UPI application",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Center(
        child: Text("Pay Now", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --------------------------------------------------------------
            // AMOUNT
            // --------------------------------------------------------------
            Text(
              "Amount",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),

            const SizedBox(height: 4),

            Text(
              "₹$amount",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------------------
            // QR
            // --------------------------------------------------------------
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: QrImageView(
                data: upiUrl,
                version: QrVersions.auto,
                size: 220,
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Scan this QR code to pay",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------------------
            // GPay
            // --------------------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _openUpiApp,
                child: const Text(
                  "Pay with UPI",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --------------------------------------------------------------
            // CLOSE
            // --------------------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
