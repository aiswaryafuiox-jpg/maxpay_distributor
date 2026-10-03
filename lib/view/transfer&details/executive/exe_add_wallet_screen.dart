import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:get/get.dart';
import '../../../controller/executive_controller.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class ExeAddWalletScreen extends StatefulWidget {
  const ExeAddWalletScreen({super.key});

  @override
  State<ExeAddWalletScreen> createState() => _ExeAddWalletScreenState();
}

class _ExeAddWalletScreenState extends State<ExeAddWalletScreen> {
  final ExecutiveController _controller = Get.find<ExecutiveController>();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch details when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchExecutiveAddWalletDetails(Get.arguments.toString());
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration(
    BuildContext context,
    String hint,
    bool isDark,
  ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextHelper.max1.copyWith(
        color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
      ),
      filled: true,
      fillColor: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: isDark ? AppColors.darkFilterBorder : Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: isDark ? AppColors.darkFilterBorder : Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.clrPrimary),
      ),
    );
  }

  Widget buildLabel(String text, bool isDark) {
    return Text(
      text,
      style: TextHelper.max4.copyWith(
        color: isDark ? AppColors.textclr : AppColors.clrTextblack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Add Wallet"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final details = _controller.exeAddWalletDetails.value;
                if (details == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Wallet Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Wallet Balance",
                            style: TextHelper.max1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            (details.walletBalance ?? 0.00).currencyIndian,
                            style: TextHelper.max13(
                              context,
                            ).copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25.h),

                    buildLabel("User Name", isDark),
                    SizedBox(height: 8.h),
                    TextFormField(
                      initialValue: details.userName ?? "-",
                      readOnly: true,
                      decoration: fieldDecoration(context, "", isDark),
                    ),

                    SizedBox(height: 16.h),

                    buildLabel("Last Transfer Amount", isDark),
                    SizedBox(height: 8.h),
                    TextFormField(
                      initialValue:
                          (details.lastTransferAmount ?? 0.00).currencyIndian,
                      readOnly: true,
                      decoration: fieldDecoration(context, "", isDark),
                    ),

                    SizedBox(height: 16.h),

                    buildLabel("Last Transfer Date & Time", isDark),
                    SizedBox(height: 8.h),
                    TextFormField(
                      initialValue: formatTransactionDate(details.lastTransferDateTime ?? "-"),
                      readOnly: true,
                      decoration: fieldDecoration(context, "", isDark),
                    ),

                    SizedBox(height: 16.h),

                    buildLabel("Outstanding", isDark),
                    SizedBox(height: 8.h),
                    TextFormField(
                      initialValue:
                          (details.lastTransferAmount ?? 0.00).currencyIndian,
                      readOnly: true,
                      decoration: fieldDecoration(context, "", isDark),
                    ),

                    SizedBox(height: 16.h),
                  ],
                );
              }),

              buildLabel("Amount", isDark),
              SizedBox(height: 8.h),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: fieldDecoration(context, "Enter Amount", isDark),
              ),

              SizedBox(height: 40.h),

              Center(
                child: Obx(
                  () => CommonButton(
                    title: "Update",
                    isLoading: _controller.isAddWalletLoading.value,
                    onTap: () {
                      final amount = amountController.text.trim();
                      final id = Get.arguments?.toString();
                      if (id != null && amount.isNotEmpty) {
                        _controller.submitAddWallet(id, amount);
                      } else if (amount.isEmpty) {
                        Get.snackbar(
                          "Required",
                          "Please enter an amount",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                      Get.find<AddWalletController>().fetchWalletBalance();
                    },
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
