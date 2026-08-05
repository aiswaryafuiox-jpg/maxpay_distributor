import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';

import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/add_wallet/widge/add_wallet_widget.dart';

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
              /// QR IMAGE CONTAINER
              Container(
                height: 240.h,
                width: MediaQuery.of(context).size.width.w,
                margin: .zero,
                padding: .zero,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: .zero,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(AssetImages.addwallet, fit: .fitHeight),
                ),
              ),

              const SizedBox(height: 20),

              /// AMOUNT TITLE
              Text(
                "Amount",
                style: TextHelper.max9(context).copyWith(fontFamily: 'Poppins'),
              ),

              const SizedBox(height: 8),

              /// AMOUNT FIELD
              TextFormField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: "Enter Amount",
                  prefixIcon: Container(
                    width: 40,
                    padding: const EdgeInsets.only(top: 4),
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

              /// SUBMIT BUTTON
              Center(
                child: CommonButton(
                  title: "Submit",
                  onTap: () {
                    if (controller.amountController.text.isNotEmpty) {
                      controller.createQr(
                        controller.amountController.text.trim(),
                      );
                    } else {
                      Get.snackbar(
                        "Alert",
                        "Please Enter Amount",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 28),

              /// RECENT TRANSACTIONS
              Text(
                "Recent Transactions",
                style: TextHelper.max10(
                  context,
                ).copyWith(fontFamily: 'Poppins'),
              ),

              const SizedBox(height: 20),

              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.walletQrHistory.value.data?.list?.isEmpty ?? true) {
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
      ),
    );
  }
}
