import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class CommissionCard extends StatelessWidget {
  final String packageName;

  final String badgeText;
  final Color badgeColor;
  final Gradient? badgeGradient;
  final Color badgeTextColor;

  final String totalProducts;
  final String updatedProducts;
  final String pendingProducts;

  final bool showResetButton;

  final String statusText;
  final Color statusColor;

  final Color? resetColor;

  const CommissionCard({
    super.key,
    required this.packageName,
    required this.badgeText,
    required this.badgeColor,
    this.badgeGradient,
    required this.badgeTextColor,
    required this.totalProducts,
    required this.updatedProducts,
    required this.pendingProducts,
    required this.showResetButton,
    required this.statusText,
    required this.statusColor,
    this.resetColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : const Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.withValues(alpha: .12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        children: [

          /// HEADER
          Row(
            children: [

              Expanded(
                child: Text(
                  packageName,
                  style: TextHelper.max10(context).copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  gradient: badgeGradient,

                  color: badgeColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  badgeText,
                  style: TextHelper.max1.copyWith(
                    color: badgeTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Divider(
            color: isDark
                ? Colors.white.withValues(alpha: 0.30)
                : const Color(0xFF000000).withValues(alpha: 0.30),
          ),

          const SizedBox(height: 14),

          IntrinsicHeight(
            child: Row(
              children: [

                Expanded(
                  child: _column(
                    context,
                    "No of Products",
                    totalProducts,
                    Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                VerticalDivider(
                  width: 1,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.30)
                      : const Color(0xFF000000).withValues(alpha: 0.30),
                ),
                Expanded(
                  child: _column(
                    context,
                    "Update Products",
                    updatedProducts,
                    const Color(0xff00BC62),
                  ),
                ),

                VerticalDivider(
                  width: 1,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.30)
                      : const Color(0xFF000000).withValues(alpha: 0.30),
                ),

                Expanded(
                  child: _column(
                    context,
                    "Update Pending",
                    pendingProducts,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerRight,
            child: showResetButton
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                _button(
                  "Reset",
                  resetColor ?? AppColors.resetBtn,
                ),

                const SizedBox(width: 8),

                _button(
                  statusText,
                  statusColor,
                ),
              ],
            )
                : _button(
              statusText,
              statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _column(
      BuildContext context,
      String title,
      String value,
      Color valueColor,
      ) {
    return Column(
      children: [

        Text(
          title,
          textAlign: TextAlign.center,
          style: TextHelper.max1.copyWith(
            color: Color(0xFF636363),
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: TextHelper.max10(context).copyWith(
            color: valueColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _button(
      String text,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextHelper.max1.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}