import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/data/model/my_earnings/my_earnings_model.dart';

class EarningsCard extends StatelessWidget {
  final MyEarningsItem item;

  const EarningsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final secondaryTextColor = isDark
        ? Colors.white.withValues(alpha: 0.7)
        : AppColors.darktextclr;

    final title = item.productName?.isNotEmpty == true
        ? item.productName!
        : (item.productType?.isNotEmpty == true
              ? item.productType!
              : "Recharge");

    final firstLetter = title.isNotEmpty ? title[0].toUpperCase() : "R";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3349) : AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          /// Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Transaction No: ${item.transactionNo ?? 'N/A'}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: secondaryTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.dateTime ?? 'N/A',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.withValues(alpha: 0.4), thickness: 0.8),
          const SizedBox(height: 10),

          /// Bottom Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Logo / Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.clrPrimary,
                backgroundImage:
                    (item.productLogo != null &&
                        item.productLogo!.isNotEmpty &&
                        (item.productLogo!.startsWith("http://") ||
                            item.productLogo!.startsWith("https://")))
                    ? NetworkImage(item.productLogo!)
                    : null,
                child:
                    (item.productLogo == null ||
                        item.productLogo!.isEmpty ||
                        (!item.productLogo!.startsWith("http://") &&
                            !item.productLogo!.startsWith("https://")))
                    ? Text(
                        firstLetter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),

              const SizedBox(width: 12),

              /// Recharge Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tr.Amount : ₹${item.transactionAmount ?? '0.00'}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              /// Earnings
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "My Earnings",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹ ${item.myEarnings ?? '0.00'}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
