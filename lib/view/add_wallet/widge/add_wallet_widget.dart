import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

Widget transactionCard({
  required BuildContext context,
  required String status,
  required Color statusColor,
  required String amount,
}) {
  final theme = Theme.of(context);
  final dividerColor = theme.brightness == Brightness.dark
      ? Colors.white.withValues(alpha: 0.12)
      : Colors.black.withValues(alpha: 0.12);

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.brightness == Brightness.dark
          ? AppColors.darkplceholder
          : AppColors.background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("UTR NO: 9785121TGV", style: TextHelper.max12(context)),
            Text(
              "Date & Time:\n29-11-2026 07:38:43PM",
              textAlign: TextAlign.end,
              style: TextHelper.max12(context),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 1, thickness: 1, color: dividerColor),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status", style: TextHelper.max12(context)),
                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Amount", style: TextHelper.max12(context)),
                const SizedBox(height: 5),

                Text(amount, style: TextHelper.max10(context)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
