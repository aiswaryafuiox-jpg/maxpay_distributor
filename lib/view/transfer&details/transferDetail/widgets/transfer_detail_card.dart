import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class TransferDetailCard extends StatelessWidget {
  final String transactionId;
  final String dateTime;
  final String transactionType;
  final String userType;
  final String userName;
  final String regMobNo;
  final String amount;

  const TransferDetailCard({
    super.key,
    required this.transactionId,
    required this.dateTime,
    required this.transactionType,
    required this.userType,
    required this.userName,
    required this.regMobNo,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isReverse = transactionType.toLowerCase() == "reverse";

    final Color statusColor =
    isReverse ? Color(0xFFEE0023) : Color(0xFF00BC62);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2F3349)
            : AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? const Color(0xFF3C3F52)
              : AppColors.totalborde2.withValues(alpha: .4),
        ),
      ),
      child: Column(
        children: [
          /// TOP ROW (UNCHANGED)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID: TXN6453564",
                style: TextHelper.max1.copyWith(

                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time:",
                    style: TextHelper.max1.copyWith(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "2026-11-29 14:38:43",
                    style: TextHelper.max1.copyWith(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Divider(
            thickness: 1,
            color: isDark
                ? Colors.white.withValues(alpha: .20)
                : Colors.grey.shade400,
          ),

          SizedBox(height: 16.h),

          /// Transaction Type (UNCHANGED)
          _row(
            context,
            "Transaction Type",
            transactionType,
            valueColor: statusColor,
          ),

          SizedBox(height: 14.h),

          /// User Type
          _latoRow(
            context,
            "User Type",
            userType,
          ),

          SizedBox(height: 14.h),

          /// User Name
          _latoRow(
            context,
            "User Name",
            userName,
          ),

          SizedBox(height: 14.h),

          /// Reg Mob
          _latoRow(
            context,
            "Reg.Mob No",
            regMobNo,
          ),

          SizedBox(height: 14.h),

          /// Transaction Amount
          _latoRow(
            context,
            "Transaction Amount",
            amount,
            valueColor: statusColor,
            isAmount: true,
          ),
        ],
      ),
    );
  }

  /// TRANSACTION TYPE (UNCHANGED)
  Widget _row(
      BuildContext context,
      String title,
      String value, {
        Color? valueColor,
        bool isAmount = false,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            title,
            style: TextHelper.max4.copyWith(
              color: isDark
                  ? Colors.white.withValues(alpha: .70)
                  : AppColors.darktextclr,
            ),
          ),
        ),

        SizedBox(
          width: 20.w,
          child: Text(
            ":",
            textAlign: TextAlign.center,
            style: TextHelper.max4.copyWith(
              color: isDark
                  ? Colors.white.withValues(alpha: .70)
                  : AppColors.darktextclr,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Expanded(
          flex: 4,
          child: Text(
            value,
            style: TextHelper.max4.copyWith(
              color: valueColor ?? theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight:
              isAmount ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// USER TYPE ONWARDS (LATO STYLE)
  Widget _latoRow(
      BuildContext context,
      String title,
      String value, {
        Color? valueColor,
        bool isAmount = false,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? Colors.white.withValues(alpha: .70)
                  : const Color(0xFF000000).withValues(alpha: .40),
            ),
          ),
        ),

        SizedBox(
          width: 20.w,
          child: Text(
            ":",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? Colors.white.withValues(alpha: .70)
                  : const Color(0xFF000000).withValues(alpha: .40),
            ),
          ),
        ),

        Expanded(
          flex: 4,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: isAmount ? 16.sp : 16.sp,
              fontWeight: FontWeight.w700,
              color: valueColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}