import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';

import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
import 'package:maxpay/core/utils/texthelper.dart';

Widget transactionCard({
  required BuildContext context,
  required String status,
  required Color statusColor,

  required String amount,
  required String txnId,
  required String dateTime,
}) {
  final theme = Theme.of(context);

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.brightness == Brightness.dark
          ? AppColors.darkplceholder
          : AppColors.background,
      borderRadius: BorderRadius.circular(10),
      border: .all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "UTR NO: $txnId",
                style: TextHelper.max12(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Date & Time:\n${dateTime.isNotEmpty ? formatTransactionDate(dateTime) : "-"}",
                textAlign: TextAlign.end,
                style: TextHelper.max12(context),
              ),
            ),
          ],
        ),

        const SizedBox(height: 1),
        Divider(
          color: theme.brightness == Brightness.light
              ? Colors.black12
              : Colors.white24,
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
                Text(amount.currencyIndian, style: TextHelper.max10(context)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
