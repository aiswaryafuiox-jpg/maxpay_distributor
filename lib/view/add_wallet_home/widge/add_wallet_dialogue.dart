import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';

import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddWalletPopup extends StatelessWidget {
  final String amount;
  final String url;
  final String txtionId;

  const AddWalletPopup({
    super.key,
    required this.amount,
    required this.url,
    required this.txtionId,
  });

  static const MethodChannel _upiChannel =
      MethodChannel('com.paylink.retailor/upi_choose');

  
  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
final isDark = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(

          
          color:  theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SingleChildScrollView(
          child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [

    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 24),

        Text(
          "Account Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface
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
              /// QR
              Container(
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
                    data: url,
                    version: QrVersions.auto,
                    size: 220,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Amount
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
                        amount.currencyIndian,
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

              /// Expiry
              Obx(() {
                final controller = Get.find<AddWalletController>();

                final minutes = (controller.remainingSeconds.value ~/ 60)
                    .toString()
                    .padLeft(2, '0');

                final seconds = (controller.remainingSeconds.value % 60)
                    .toString()
                    .padLeft(2, '0');

                return Text(
                  "Expiry: $minutes:$seconds",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),

              const SizedBox(height: 16),

              const SizedBox(height: 20),

const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Pay Using",
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
),

const SizedBox(height: 12),
Obx(() {
  final controller = Get.find<AddWalletController>();

  if (controller.isLoadingUpiApps.value) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (controller.upiApps.isEmpty) {
    return const Text("No UPI apps installed");
  }

  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: controller.upiApps.map((app) {
      return InkWell(
        onTap: () {
          controller.openSpecificUpiApp(
            packageName: app["packageName"],
            url: url,
          );
        },
        child: Container(
          width: 70,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Image.memory(
                app["icon"],
                width: 40,
                height: 40,
              ),
              const SizedBox(height: 5),
              Text(
                app["name"],
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
})
// FutureBuilder<List<Map<String, dynamic>>>(
//   future: Get.find<AddWalletController>().getInstalledUpiApps(),
//   builder: (context, snapshot) {
//     if (!snapshot.hasData) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     final apps = snapshot.data!;

//     if (apps.isEmpty) {
//       return const Text("No UPI apps installed");
//     }

//     return Wrap(
//       spacing: 12,
//       runSpacing: 12,
//       children: apps.map((app) {
//         return InkWell(
//           onTap: () {
//             Get.find<AddWalletController>().openSpecificUpiApp(
//               packageName: app["packageName"],
//               url: url,
//             );
//           },
//           child: Container(
//             width: 70,
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.memory(
//                   app["icon"],
//                   width: 40,
//                   height: 40,
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   app["name"],
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 11),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   },
// ),
            ],
          ),
        ),
      ),
    );
  }
}
