import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';


import '../../../../global_widget/commom_button.dart';
import 'common_readonly_field.dart';

class WalletRequestPendingForm extends StatelessWidget {
  const WalletRequestPendingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonReadonlyField(
          title: "Date & Time",
          value: "16. Oct. 2025",
        ),

        const SizedBox(height: 16),

        CommonReadonlyField(
          title: "Retailer Name",
          value: "John Williamson",
        ),

        const SizedBox(height: 16),

        CommonReadonlyField(
          title: "Reg. Mob No",
          value: "+91 9865375260",
        ),

        const SizedBox(height: 16),

        CommonReadonlyField(
          title: "Payment Status",
          value: "Complete",
        ),

        const SizedBox(height: 16),

        CommonReadonlyField(
          title: "Payment Mode",
          value: "Wallet Transfer",
        ),

        const SizedBox(height: 16),

        /// UTR
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "UTR No",
              style: TextHelper.max6.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),

            SizedBox(
              height: 28,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.clrPrimary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Receipt
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Receipt",
              style: TextHelper.max6.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),

            SizedBox(
              height: 28,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.clrPrimary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        CommonReadonlyField(
          title: "Amount",
          value: "₹10000.00",
        ),

        const SizedBox(height: 16),

        CommonReadonlyField(
          title: "Confirm Amount",
          value: "₹10000.00",
        ),

        const SizedBox(height: 30),

        Center(
          child: CommonButton(
            title: "Update",
            onTap: () {},
          ),
        ),
      ],
    );
  }
}