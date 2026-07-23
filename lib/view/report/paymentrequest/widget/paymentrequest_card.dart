import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class PaymentRequestCard extends StatelessWidget {
  final String dateTime;
  final String transactionId;
  final String apiName;
  final String amount;
  final String status;

  const PaymentRequestCard({
    super.key,
    required this.dateTime,
    required this.transactionId,
    required this.apiName,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color statusTextColor;
    Color statusBgColor;

    switch (status.toLowerCase()) {
      case "success":
        statusTextColor = AppColors.successColor;
        statusBgColor =
        isDark ? const Color(0xFF0B4A2D) : AppColors.successBg;
        break;

      case "pending":
        statusTextColor = AppColors.pendingColor;
        statusBgColor =
        isDark ? const Color(0xFF4A3A08) : AppColors.pendingBg;
        break;

      default:
        statusTextColor = AppColors.successColor;
        statusBgColor =
        isDark ? const Color(0xFF0B4A2D) : AppColors.successBg;
    }

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
              : Colors.grey.withValues(alpha: 0.12),
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
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.grey.withValues(alpha: 0.25),
            height: 1,
          ),

          const SizedBox(height: 12),

          _buildRow(
            context,
            "Transaction ID",
            transactionId,
          ),

          const SizedBox(height: 12),

          _buildRow(
            context,
            "API Name",
            apiName,
          ),

          const SizedBox(height: 12),

          _buildRow(
            context,
            "Amount",
            amount,
            valueColor: AppColors.clrPrimary,
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
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status,
                  style: TextHelper.max5.copyWith(
                    color: statusTextColor,
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
      String value, {
        Color? valueColor,
      }) {
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
            color: valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}