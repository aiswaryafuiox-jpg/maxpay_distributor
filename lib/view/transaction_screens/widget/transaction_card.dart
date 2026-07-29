import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/data/model/transaction/transaction_report_response_model.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/transaction_controller.dart';

class TransactionCard extends StatelessWidget {

  final TransactionReportItem item;
  final Color bgColor;
  final TransactionStatus status;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const TransactionCard({
    super.key,
    required this.item,
    required this.bgColor,
    required this.status,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isSuccess = status == TransactionStatus.success;
    final bool isPending = status == TransactionStatus.pending;
    final bool isFailed = status == TransactionStatus.failed;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID: ${item.transactionId ?? 'N/A'}",
                style: TextHelper.max1
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time:",
                    style: TextHelper.max1.copyWith(
                      fontSize: 11
                    )
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.dateTime ?? 'N/A',
                    style: TextHelper.max1.copyWith(
                      fontSize: 11
                    )
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 2),
            ),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                child: item.productLogo != null
                  ? Image.network(
                      item.productLogo!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
                    )
                  : const Icon(Icons.category, color: Colors.grey),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName ?? 'Unknown',
                      style: TextHelper.lato14.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: theme.brightness == Brightness.dark
                          ? Colors.black
                          : theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Number: ${item.mobile ?? 'N/A'}",
                      style: TextHelper.lato11.copyWith(
                        fontWeight: FontWeight.w600,

                        fontSize: 12,
                        color: theme.brightness == Brightness.dark
                            ? Colors.black
                            : theme.colorScheme.onSurface,

                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹ ${item.amount ?? 0}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: theme.brightness == Brightness.dark
                          ? Colors.black
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 1),

                  if (isFailed)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          customButton(
                            text: "Failed",
                            color: Colors.red,
                            isCompact: false,
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isPending ? Color(0xFFD98200) :Color(0xFF00A954),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isPending ? "Processing" : "Success",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          if (isSuccess) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
                children: [
                  if (item.canDispute == 1)
                    customButton(
                      text: "Dispute",
                      color: Colors.red,
                      onTap: () {
                        // _showDisputeDialog(context); // Optional
                      },
                      isCompact: true,
                    ),
                  customButton(
                    text: "View Details",
                    color: AppColors.clrPrimary,
                    onTap: () {
                      if (item.id != null) {
                        Get.find<TransactionController>().fetchTransactionDetail(item.id!);
                      }
                    },
                    isCompact: true,
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget customButton({
    required String text,
    required Color color,
    IconData? icon,
    VoidCallback? onTap,
    bool isCompact = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 8 : 12,
          vertical: isCompact ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: text == "View"
              ? Border.all(color: Colors.blue.withValues(alpha: 0.3))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isCompact ? 10 : 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(icon, color: Colors.white, size: 15),
            ],
          ],
        ),
      ),
    );
  }

}
