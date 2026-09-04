import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class DayBookCard extends StatelessWidget {
  final String retailerName;
  final String mobileNo;
  final String transactionId;
  final String transactionType;
  final String receivedAmount;
  final String dateTime;

  const DayBookCard({
    super.key,
    required this.retailerName,
    required this.mobileNo,
    required this.transactionId,
    required this.transactionType,
    required this.receivedAmount,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3349) : AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? const Color(0xFF3C3F52)
              : AppColors.totalborde2.withValues(alpha: .35),
        ),
      ),
      child: Column(
        children: [
          /// DATE & TIME
          Row(
            children: [
              Text(
                "Date & Time:",
                style: TextHelper.max1.copyWith(
                  color: isDark
                      ? Colors.white.withValues(alpha: .60)
                      : const Color(0xff8A8A8A),
                ),
              ),

              const Spacer(),

              Text(
                dateTime,
                style: TextHelper.max1.copyWith(
                  color: isDark
                      ? Colors.white.withValues(alpha: .60)
                      : const Color(0xff6E6E6E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Divider(
            thickness: 1,
            color: isDark
                ? Colors.white.withValues(alpha: .20)
                : Colors.grey.shade300,
          ),

          SizedBox(height: 14.h),

          _row(context, "Retailer Name", retailerName),

          SizedBox(height: 12.h),

          _row(context, "Reg.Mob No", mobileNo),

          SizedBox(height: 12.h),

          _row(context, "Transaction ID", transactionId),

          SizedBox(height: 14.h),

          /// TRANSACTION TYPE
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xffE8EDFF),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Transaction Type",
                    style: TextHelper.max4.copyWith(
                      color: const Color(0xff3455FF),
                    ),
                  ),
                ),

                Text(
                  transactionType,
                  style: TextHelper.max4.copyWith(
                    color: const Color(0xff3455FF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          /// RECEIVED AMOUNT
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xffE8FAEF),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Received Amount",
                    style: TextHelper.max4.copyWith(
                      color: const Color(0xff00C853),
                    ),
                  ),
                ),

                Text(
                  receivedAmount.currencyIndian,
                  style: TextHelper.max4.copyWith(
                    color: const Color(0xff00C853),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String title, String value) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextHelper.max4.copyWith(color: theme.colorScheme.onSurface),
          ),
        ),

        Text(
          value,
          style: TextHelper.max4.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
