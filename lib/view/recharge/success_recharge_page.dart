import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class SuccessRechargePage extends StatelessWidget {
  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String rechargeAmount;
  final String transactionId;
  final String dateTime;

  const SuccessRechargePage({
    super.key,
    this.productName = 'Jio',
    this.operatorInitial = 'J',
    this.operatorColor = Colors.red,
    this.transactionNo = '9867453758',
    this.rechargeAmount = '₹365.0',
    this.transactionId = 'TXN75483457',
    this.dateTime = '29-11-2026 14:38:4',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Only Mobile and DTH recharges show amount inside the box
    // Common mobile/dth names or anything containing 'TV' or 'Recharge'
    final bool isMobileOrDTH =
        productName.toLowerCase().contains('jio') ||
        productName.toLowerCase().contains('airtel') ||
        productName.toLowerCase().contains('vi') ||
        productName.toLowerCase().contains('bsnl') ||
        productName.toLowerCase().contains('tv') ||
        productName.toLowerCase().contains('dish') ||
        productName.toLowerCase().contains('tata') ||
        productName.toLowerCase().contains('sun') ||
        productName.toLowerCase().contains('videocon');

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              /// 🔹 SUCCESS ICON
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
              Text(
                'Recharge Successful !!!',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),

              SizedBox(height: 40.h),

              /// 🔹 SUMMARY CARD
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder.withValues(alpha: 0.5)
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(
                      'Product',
                      productName,
                      isIcon: true,
                      context: context,
                    ),
                    _buildSummaryRow(
                      'Transaction No',
                      transactionNo,
                      context: context,
                    ),
                    if (isMobileOrDTH)
                      _buildSummaryRow(
                        'Recharge Amount',
                        rechargeAmount,
                        valueColor: isDark ? Colors.white : Colors.black,
                        context: context,
                      ),
                    _buildSummaryRow(
                      'Transaction ID',
                      transactionId,
                      context: context,
                    ),
                    _buildSummaryRow('Date & Time', dateTime, context: context),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.view),
                      child: Text(
                        'View Detail',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (!isMobileOrDTH) ...[
                SizedBox(height: 30.h),
                Divider(color: Colors.grey.withValues(alpha: 0.2)),
                SizedBox(height: 20.h),
                Text(
                  'Amount Paid $rechargeAmount',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],

              const Spacer(),

              /// 🔹 DONE BUTTON
              Center(
                child: CommonButton(
                  title: 'Done',
                  onTap: () => Get.offAllNamed(AppRoutes.main),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isIcon = false,
    Color? valueColor,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
          Row(
            children: [
              if (isIcon) ...[
                CircleAvatar(
                  radius: 8.r,
                  backgroundColor: operatorColor,
                  child: Text(
                    operatorInitial,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              Text(
                value,
                style: TextStyle(
                  color:
                      valueColor ??
                      (Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.black87),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
