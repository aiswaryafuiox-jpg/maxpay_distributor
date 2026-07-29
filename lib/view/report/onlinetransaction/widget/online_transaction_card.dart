import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class OnlineTransactionCard extends StatelessWidget {
  final String dateTime;
  final String retailerName;
  final String mobileNo;
  final String amount;
  final String status;

  const OnlineTransactionCard({
    super.key,
    required this.dateTime,
    required this.retailerName,
    required this.mobileNo,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : const Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.withValues(alpha: .12),
        ),
      ),
      child: Column(
        children: [
          /// Date & Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time",
                style: TextHelper.max12(context),
              ),
              Text(
                dateTime,
                style: TextHelper.max12(context),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Divider(
            color: isDark
                ? Colors.white.withValues(alpha: .12)
                : Colors.grey.withValues(alpha: .25),
            height: 1,
          ),

          const SizedBox(height: 12),

          _buildRow(
            context,
            "Retailer Name",
            retailerName,
          ),

          const SizedBox(height: 12),

          _buildRow(
            context,
            "Reg.Mob No",
            mobileNo,
          ),

          const SizedBox(height: 12),

          _buildRow(
            context,
            "Amount",
            amount,
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: TextHelper.max6.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? (status.toLowerCase() == 'success' ? Colors.green.withValues(alpha: 0.2) : status.toLowerCase() == 'failed' ? Colors.red.withValues(alpha: 0.2) : const Color(0xFF4A3A08))
                      : (status.toLowerCase() == 'success' ? Colors.green.withValues(alpha: 0.1) : status.toLowerCase() == 'failed' ? Colors.red.withValues(alpha: 0.1) : AppColors.pendingBg),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status.capitalizeFirst ?? status,
                  style: TextHelper.max5.copyWith(
                    color: status.toLowerCase() == 'success' ? Colors.green : status.toLowerCase() == 'failed' ? Colors.red : AppColors.pendingColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
      BuildContext context,
      String title,
      String value,
      ) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextHelper.max6.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          value,
          style: TextHelper.max9(context).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}