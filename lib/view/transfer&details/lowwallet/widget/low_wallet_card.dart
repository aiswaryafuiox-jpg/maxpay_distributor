import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class LowWalletCard extends StatelessWidget {
  final String retailerName;
  final String mobile;
  final String amount;

  const LowWalletCard({
    super.key,
    required this.retailerName,
    required this.mobile,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : const Color(0xffF6F7FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.withValues(alpha: .12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Retailer
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Retailers Name: ",
                  style: TextHelper.max11(context),
                ),
                TextSpan(
                  text: retailerName,
                  style: TextHelper.max9(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          /// Mobile
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Reg Mob no: ",
                  style: TextHelper.max11(context),
                ),
                TextSpan(
                  text: "+91 $mobile",
                  style: TextHelper.max9(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [

              Text(
                "Wallet Amount:",
                style: TextHelper.max5.copyWith(
                  color: AppColors.clrSecondary,
                  fontSize: 13,
                ),
              ),

              const Spacer(),

              Text(
                amount,
                style: TextHelper.max10(context).copyWith(
                  color: AppColors.clrSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 90,
              height: 30,
              child: CommonButton(
                title: "Add Wallet",
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}