import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:get/get.dart';
import '../../../controller/retailer_controller.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class RetAddWalletScreen extends StatefulWidget {
  final bool isPartner;
  const RetAddWalletScreen({super.key, this.isPartner = false});

  @override
  State<RetAddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<RetAddWalletScreen> {
  final RetailerController _controller = Get.find<RetailerController>();
  final TextEditingController amountController = TextEditingController();

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

  void _showConfirmationDialog(String id, String amount) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkplceholder : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          title: Text(
            "Confirmation",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.clrTextblack,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure you want to add wallet amount?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                amount.currencyIndian,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.clrPrimary,
                ),
              ),
            ],
          ),
          actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (widget.isPartner) {
                        _controller.submitDisAddWallet(id, amount);
                      } else {
                        _controller.submitAddWallet(id, amount);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.clrPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
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
                final details = _controller.addWalletDetails.value;
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
                      initialValue: details.lastTransferDateTime ?? "-",
                      readOnly: true,
                      decoration: fieldDecoration(context, "", isDark),
                    ),

                    SizedBox(height: 16.h),

                    buildLabel("Outstanding", isDark),
                    SizedBox(height: 8.h),
                    TextFormField(
                      initialValue:
                          (details.outstanding ?? 0.00).currencyIndian,
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
                      final id =
                          (widget.isPartner
                                  ? (_controller
                                            .addWalletDetails
                                            .value
                                            ?.distributorId ??
                                        _controller
                                            .addWalletDetails
                                            .value
                                            ?.retailerId)
                                  : _controller
                                        .addWalletDetails
                                        .value
                                        ?.retailerId)
                              ?.toString();
                      final amount = amountController.text.trim();
                      if (id != null && amount.isNotEmpty) {
                        _showConfirmationDialog(id, amount);
                      } else if (amount.isEmpty) {
                        Get.snackbar(
                          "Required",
                          "Please enter an amount",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
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
