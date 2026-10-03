import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class WalletBalanceCard extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;

  const WalletBalanceCard({
    super.key,
    this.title = "Wallet Balance",
    this.margin,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final AddWalletController controller =
        Get.isRegistered<AddWalletController>()
            ? Get.find<AddWalletController>()
            : Get.put(sl<AddWalletController>());

    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding ?? EdgeInsets.symmetric(vertical: 18.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.clrPrimary,
        borderRadius: BorderRadius.circular(borderRadius ?? 14.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextHelper.max16,
          ),
          SizedBox(height: 6.h),
          Obx(() {
            final balance = controller.walletBalance.value;
            return Text(
              balance.currencyIndian,
              style: TextHelper.lato12,
            );
          }),
        ],
      ),
    );
  }
}
