import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/retailer_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class RetailerTopTabs extends StatelessWidget {
  const RetailerTopTabs({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildTab(
      String text,
      Color color, {
      BorderRadius? borderRadius,
      VoidCallback? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, borderRadius: borderRadius),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextHelper.max1.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: buildTab(
              "Total Retailer: ${Get.find<RetailerController>().retailers.length}",
              AppColors.clrPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
          ),
          Expanded(flex: 2, child: buildTab("Retailer List", AppColors.redClr)),
          Expanded(
            flex: 3,
            child: buildTab(
              "Create Retailer",
              AppColors.create,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.createRetailerScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
