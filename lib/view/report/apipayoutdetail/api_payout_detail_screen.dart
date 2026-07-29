import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/report/apipayoutdetail/widget/payout_card.dart';

class PayoutDetailScreen extends StatelessWidget {
  const PayoutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> transactions = [
      {
        "dateTime": "29-11-2026 07:38:43PM",
        "retailerName": "Kumar",
        "mobileNo": "9876543212",
        "amount": "₹100.00",
      },
      // {
      //   "dateTime": "29-11-2026 08:15:21PM",
      //   "retailerName": "Arun",
      //   "mobileNo": "9123456780",
      //   "amount": "₹250.00",
      // },
      // {
      //   "dateTime": "30-11-2026 09:12:50AM",
      //   "retailerName": "Vijay",
      //   "mobileNo": "9876501234",
      //   "amount": "₹500.00",
      // },
      // {
      //   "dateTime": "30-11-2026 10:45:13AM",
      //   "retailerName": "Ramesh",
      //   "mobileNo": "9000012345",
      //   "amount": "₹150.00",
      // },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "API Pay-Out Details",
      ),

      body: Column(
        children: [
          /// Filter Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: CommonFilterBox(
              bottomWidget: TransactionTypeField(value: 'all', onChanged: (val) {}),
            ),
          ),
          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Divider(
              thickness: 1,
              height: 1,
              color: Color(0x4D000000),
            ),
          ),

          const SizedBox(height: 15),
          /// Transaction List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              separatorBuilder: (_, _) =>
              const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = transactions[index];

                return PayoutCard(
                  dateTime: item["dateTime"]!,
                  retailerName: item["retailerName"]!,
                  mobileNo: item["mobileNo"]!,
                  amount: item["amount"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}