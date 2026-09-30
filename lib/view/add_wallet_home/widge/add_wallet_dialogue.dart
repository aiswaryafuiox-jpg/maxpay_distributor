import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/data/model/create_qr_response_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class AddWalletPopup extends StatefulWidget {
  final Ekqr? ekqrData;
  final Worldline? bankData;

  const AddWalletPopup({
    super.key,
    required this.ekqrData,
    required this.bankData,
  });

  @override
  State<AddWalletPopup> createState() => _AddWalletPopupState();
}

class _AddWalletPopupState extends State<AddWalletPopup> {
  @override
  void initState() {
    super.initState();
    _disableScreenshot();
  }

  Future<void> _disableScreenshot() async {
    await ScreenProtector.preventScreenshotOn();
  }

  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ekqrData = widget.ekqrData;
    final bankData = widget.bankData;
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ----------------------------------------------------------
              // HEADER
              // ----------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),

                  Text(
                    "Account Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      final controller = Get.find<AddWalletController>();

                      controller.stopTimer();

                      controller.amountController.clear();

                      Get.back();

                      await controller.getWalletHistory();
                    },
                    child: const Icon(
                      Icons.cancel,
                      size: 24,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ----------------------------------------------------------
              // QR CODE
              // ----------------------------------------------------------
              AbsorbPointer(
                child: Container(
                  width: 220,
                  height: 220,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: QrImageView(
                      data: ekqrData?.upiLink ?? '',
                      version: QrVersions.auto,
                      size: 210,
                      backgroundColor: Colors.white,
                      errorCorrectionLevel: QrErrorCorrectLevel.M,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ----------------------------------------------------------
              // TAP QR
              // ----------------------------------------------------------
              Text(
                "Tap QR to open payment",
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
              ),

              const SizedBox(height: 18),

              // ----------------------------------------------------------
              // AMOUNT
              // ----------------------------------------------------------
              SizedBox(
                width: 270,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkbgBlack
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        ekqrData?.amount?.currencyIndian ?? "0.00",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ----------------------------------------------------------
              // EXPIRY TIMER
              // ----------------------------------------------------------
              Obx(() {
                final controller = Get.find<AddWalletController>();

                final minutes = (controller.remainingSeconds.value ~/ 60)
                    .toString()
                    .padLeft(2, '0');

                final seconds = (controller.remainingSeconds.value % 60)
                    .toString()
                    .padLeft(2, '0');

                return Column(
                  children: [
                    Text(
                      "Expiry: $minutes:$seconds",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),

              // ----------------------------------------------------------
              // NOTE
              // ----------------------------------------------------------
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.clrPrimary.withValues(alpha: .5),
                  surfaceTintColor: AppColors.clrPrimary.withValues(alpha: .5),
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.white, style: .solid),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // shadowColor: Colors.white,
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                ),
                onPressed: () async {
                  final controller = Get.find<AddWalletController>();
                  if (bankData != null) {
                    controller.startWorldlinePayment(bankData);
                  }
                },
                label: Text(
                  "Pay With UPI",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.background,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                iconAlignment: .end,
                icon: CachedNetworkImage(
                  imageUrl:
                      'https://images.icon-icons.com/2699/PNG/512/upi_logo_icon_170312.png',
                  height: 24,
                  // errorBuilder: (context, error, stackTrace) =>
                  //     const Icon(Ionicons.logo_paypal, size: 24),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================================
// OPEN UPI PAYMENT
// ==========================================================================

Future<void> openUpiPayment(String paymentUrl) async {
  try {
    final value = paymentUrl.trim();

    if (value.isEmpty) {
      CustomToast.error("Payment link is empty");
      return;
    }

    AppLogger.debugPrint("UPI payment URL = $value");

    final uri = Uri.tryParse(value);

    if (uri == null) {
      CustomToast.error("Invalid payment link");
      return;
    }

    // --------------------------------------------------------------
    // If backend sends HTTPS URL containing UPI query parameters,
    // convert it into standard UPI URI.
    // --------------------------------------------------------------

    Uri finalUri = uri;

    if (uri.scheme == 'http' || uri.scheme == 'https') {
      final query = uri.queryParameters;

      final pa = query['pa'];

      if (pa != null && pa.isNotEmpty) {
        final params = <String, String>{};

        const allowed = [
          'pa',
          'pn',
          'mc',
          'tr',
          'tid',
          'tn',
          'am',
          'cu',
          'url',
          'mode',
          'purpose',
          'orgid',
        ];

        for (final key in allowed) {
          final value = query[key];

          if (value != null && value.isNotEmpty) {
            params[key] = value;
          }
        }

        if (!params.containsKey('cu')) {
          params['cu'] = 'INR';
        }

        finalUri = Uri(scheme: 'upi', host: 'pay', queryParameters: params);
      }
    }

    AppLogger.debugPrint("FINAL UPI URL = $finalUri");

    // --------------------------------------------------------------
    // OPEN PAYMENT
    // --------------------------------------------------------------

    final canOpen = await canLaunchUrl(finalUri);

    if (!canOpen) {
      CustomToast.error("No UPI app installed");
      return;
    }

    await launchUrl(finalUri, mode: LaunchMode.externalApplication);
  } catch (e) {
    AppLogger.debugPrint("Open UPI error: $e");

    CustomToast.error("Unable to open UPI payment");
  }
}
