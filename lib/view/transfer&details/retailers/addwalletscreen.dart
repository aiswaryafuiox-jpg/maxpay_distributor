import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class RetAddWalletScreen extends StatefulWidget {
  const RetAddWalletScreen({super.key});

  @override
  State<RetAddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<RetAddWalletScreen> {
  final TextEditingController userNameController =
  TextEditingController(text: "John Williamson");

  final TextEditingController lastTransferAmountController =
  TextEditingController(text: "₹ 2455.23");

  final TextEditingController lastTransferDateController =
  TextEditingController(text: "12/03/2024 10:30:33 AM");

  final TextEditingController outstandingController =
  TextEditingController(text: "₹ 10,000.00");

  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    lastTransferAmountController.dispose();
    lastTransferDateController.dispose();
    outstandingController.dispose();
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
      fillColor:
      isDark ? AppColors.darkplceholder : AppColors.lightbg2,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 14.h,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: AppColors.clrPrimary,
        ),
      ),
    );
  }

  Widget buildLabel(String text, bool isDark) {
    return Text(
      text,
      style: TextHelper.max4.copyWith(
        color: isDark
            ? AppColors.textclr
            : AppColors.clrTextblack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Add Wallet",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
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
                      "₹ 245005.23",
                      style: TextHelper.max13(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              buildLabel("User Name", isDark),
              SizedBox(height: 8.h),
              TextField(
                controller: userNameController,
                decoration:
                fieldDecoration(context, "", isDark),
              ),

              SizedBox(height: 16.h),

              buildLabel("Last Transfer Amount", isDark),
              SizedBox(height: 8.h),
              TextField(
                controller: lastTransferAmountController,
                decoration:
                fieldDecoration(context, "", isDark),
              ),

              SizedBox(height: 16.h),

              buildLabel("Last Transfer Date & Time", isDark),
              SizedBox(height: 8.h),
              TextField(
                controller: lastTransferDateController,
                decoration:
                fieldDecoration(context, "", isDark),
              ),

              SizedBox(height: 16.h),

              buildLabel("Outstanding", isDark),
              SizedBox(height: 8.h),
              TextField(
                controller: outstandingController,
                decoration:
                fieldDecoration(context, "", isDark),
              ),

              SizedBox(height: 16.h),

              buildLabel("Amount", isDark),
              SizedBox(height: 8.h),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: fieldDecoration(
                  context,
                  "Enter Amount",
                  isDark,
                ),
              ),

              SizedBox(height: 40.h),

              Center(
                child: CommonButton(
                  title: "Update",
                  onTap: () {},
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