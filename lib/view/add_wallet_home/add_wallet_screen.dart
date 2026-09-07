import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/add_wallet_home/widge/add_wallet_widget.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

class AddWalletScreenMain extends GetView<AddWalletController> {
  const AddWalletScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final WeiplCheckoutFlutter _wlchekc = WeiplCheckoutFlutter();

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
              ElevatedButton(
                onPressed: () {
                  String deviceID = ""; // initialize variable

                  if (Platform.isAndroid) {
                    deviceID =
                        "AndroidSH2"; // Android-specific deviceId, supported options are "AndroidSH1" & "AndroidSH2"
                  } else if (Platform.isIOS) {
                    deviceID =
                        "iOSSH2"; // iOS-specific deviceId, supported options are "iOSSH1" & "iOSSH2"
                  }

                  var reqJson = {
                    "features": {
                      "enableAbortResponse": true,
                      "enableExpressPay": false,
                      "enableInstrumentDeRegistration": true,
                      "enableMerTxnDetails": true,
                    },
                    "consumerData": {
                      "deviceId": deviceID,
                      "token":
                          "a7356fb644fa98999a45d62361c80a574ff24f96b59669381593edbb97ef4feb0ea427d19e79b8d4ef5d82d38bb0eae890615b5054c702695deef11ec771b751",
                      "paymentMode": "all",
                      "merchantLogoUrl":
                          "https://paylinkonline.in/assets/img/side_bar_logo.png", //provided merchant logo will be displayed
                      "merchantId": "L3348",
                      "currency": "INR",
                      "consumerId": "c964634",
                      "consumerMobileNo": "9876543210",
                      "consumerEmailId": "test@test.com",
                      "txnId": "1684835158539", //Unique merchant transaction ID
                      "items": [
                        {"itemId": "first", "amount": "10", "comAmt": "0"},
                      ],
                      "customStyle": {
                        "PRIMARY_COLOR_CODE":
                            "#de7518", //merchant primary color code
                        "SECONDARY_COLOR_CODE":
                            "#FFFFFF", //provide merchant's suitable color code
                        "BUTTON_COLOR_CODE_1":
                            "#2d8c8c", //merchant"s button background color code
                        "BUTTON_COLOR_CODE_2":
                            "#FFFFFF", //provide merchant's suitable color code for button text
                      },
                    },
                  };

                  _wlchekc.on(
                    WeiplCheckoutFlutter.wlResponse,
                    responseCallback,
                    errorCallback,
                  );
                  _wlchekc.open(reqJson);
                },
                child: const Text("Proceed"),
              ),
              Center(
                child: CommonButton(
                  title: "Submit",
                  onTap: () async {
                    if (Platform.isIOS) {
                      // iOS code
                      bool status = await _wlchekc.checkInstalledUpiApp(
                        "gpay://upi/",
                      ); //UPI Schemes :- "phonepe://upi/" OR "gpay://upi/" OR "paytm://".
                      showAlertDialog(context, "WL SDK Response", "$status");
                    } else if (Platform.isAndroid) {
                      // android code
                      Map<dynamic, dynamic> response = await _wlchekc
                          .upiIntentAppsList();
                      showAlertDialog(context, "WL SDK Response", "$response");
                    } else {
                      showAlertDialog(
                        context,
                        "WL SDK Response",
                        "Feature is not available for selected platform.",
                      );
                    }
                  },
                ),
              ),

              // Center(
              //   child: CommonButton(
              //     title: "Submit",
              //     onTap: () async {
              //       final amount = controller.amountController.text.trim();

              //       if (amount.isEmpty) {
              //         Get.snackbar(
              //           "Alert",
              //           "Please Enter Amount",
              //           backgroundColor: Colors.red,
              //           colorText: Colors.white,
              //         );
              //         return;
              //       }

              //       final parsedAmount = double.tryParse(amount);

              //       if (parsedAmount == null || parsedAmount <= 0) {
              //         Get.snackbar(
              //           "Alert",
              //           "Please Enter a Valid Amount",
              //           backgroundColor: Colors.red,
              //           colorText: Colors.white,
              //         );
              //         return;
              //       }

              //       await controller.createQr(amount);
              //     },
              //   ),
              // ),
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

  void responseCallback(Map<dynamic, dynamic> response) {
    AppLogger.logError(response);
    // showAlertDialog(Get.context!, "WL SDK Response", "$response");
  }

  void errorCallback(Map<dynamic, dynamic> response) {
    AppLogger.logError(response);
    // showAlertDialog(Get.context!, "WL SDK Error", "$response");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Okay"),
      onPressed: () {
        // AppLogger.logError(message);
        Navigator.pop(context, false);
      },
    );
    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 25, right: 25),
          title: Center(child: Text(title)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: SizedBox(
            height: 400,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[const SizedBox(height: 20), Text(message)],
              ),
            ),
          ),
          actions: [continueButton],
        );
      },
    );
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
