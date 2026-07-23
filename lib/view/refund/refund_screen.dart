import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/refund/widget/refund_widget.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,


      appBar: const CommonAppBar(title: "Refunds"),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            /// 🔹 Date Filter Row
            

           

            /// 🔹 Search
          const CommonFilterBox(),

            const SizedBox(height: 16),

            /// 🔹 Total Earnings Box
     

            Divider(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),

            const SizedBox(height: 16),

            /// 🔹 List
            Expanded(
              child: ListView(
                children: const [
                  EarningsCard1(),
                  EarningsCard1(),
                  EarningsCard1(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  }