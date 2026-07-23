import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class AddWalletPopup extends StatelessWidget {
  const AddWalletPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxDialogHeight = MediaQuery.of(context).size.height * 0.85;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxDialogHeight),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// HEADER
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Account Details",
                        style: TextHelper.max10(context),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       IconButton(
                    //         splashRadius: 20,
                    //         onPressed: () {
                    //           // Share Function
                    //         },
                    //         icon: const Icon(
                    //           Icons.share,
                    //           color: Colors.green,
                    //         ),
                    //       ),
                    //       IconButton(
                    //         splashRadius: 20,
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //         icon: const Icon(
                    //           Icons.close,
                    //           color: Colors.green,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),

                const SizedBox(height: 18),

                /// QR CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(16),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey.withOpacity(.15),
                  //       blurRadius: 10,
                  //       offset: const Offset(0, 3),
                  //     ),
                  //   ],
                  // ),
                  child: Center(
                    child: Image.asset(
                      AssetImages.qr_code,
                      height: 310,
                      width: 310,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                /// AMOUNT CARD
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount",
                                style: TextHelper.max9(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
  "Expiry: 04:59",
  style: TextHelper.max9(context).copyWith(
    color: Colors.red,
  ),
),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 68,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffF3F3F3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "₹ 10,000.00",
                          style: TextHelper.max9(context),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}