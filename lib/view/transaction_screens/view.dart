import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
import 'package:maxpay/data/model/transaction/transaction_detail_response_model.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic rawArgs = Get.arguments;
    final TransactionDetailData data;
    if (rawArgs is TransactionDetailResponseModel) {
      data = rawArgs.data ?? TransactionDetailData();
    } else if (rawArgs is TransactionDetailData) {
      data = rawArgs;
    } else if (rawArgs is Map<String, dynamic>) {
      data = TransactionDetailData.fromJson(rawArgs);
    } else {
      data = TransactionDetailData();
    }

    return Scaffold(
      appBar: CommonAppBar(title: "View Details"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productRow("Product Name", data.productLogo),

              detailRow(
                "Payment Status",
                (data.status?.toLowerCase() == 'received' ||
                        data.status?.toLowerCase() == 'success')
                    ? 'Success'
                    : (data.status ?? "-"),
                textColor:
                    (data.status?.toLowerCase() == 'received' ||
                        data.status?.toLowerCase() == 'success')
                    ? Colors.green
                    : null,
              ),

              detailRow("Transaction No", data.transactionId ?? "-"),

              detailRow("Retailer Name", data.retailerName ?? "-"),

              detailRow("Mobile No", data.mobile ?? "-"),

              detailRow(
                "Transaction Amount",
                (data.amount ?? 0).currencyIndian,
              ),

              detailRow(
                "Request Date & Time",
                (data.dateTime?.isNotEmpty ?? false)
                    ? formatTransactionDate(data.dateTime ?? '-')
                    : "-",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(String title, String value, {Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget productRow(String title, String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  height: 35,
                  width: 35,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 35);
                  },
                )
              : const Text("-", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
