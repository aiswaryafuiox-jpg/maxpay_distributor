import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import 'package:maxpay/view/report/paymentrequest/widget/payment_request_top_widget.dart';
import 'package:maxpay/view/report/paymentrequest/widget/paymentrequest_card.dart';


class PaymentRequestScreen extends StatelessWidget {
  const PaymentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        "dateTime": "29-11-2026 07:38:43PM",
        "transactionId": "TX123456",
        "apiName": "A Plus",
        "amount": "₹100.00",
        "status": "Success",
      },
      {
        "dateTime": "29-11-2026 07:38:43PM",
        "transactionId": "TX123456",
        "apiName": "A Plus",
        "amount": "₹100.00",
        "status": "Pending",
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Payment Request",
      ),

      body: Column(
        children: [
          /// Top Widget
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: const PaymentRequestTopWidget(),
          ),

          /// Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Divider(
              thickness: 1,
              height: 1,
              color: Color(0x4D000000),
            ),
          ),

          const SizedBox(height: 14),

          /// Cards
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = transactions[index];

                return PaymentRequestCard(
                  dateTime: item["dateTime"]!,
                  transactionId: item["transactionId"]!,
                  apiName: item["apiName"]!,
                  amount: item["amount"]!,
                  status: item["status"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}