import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import '../../../../core/constants/routes_path.dart';

class ExecutiveTopTabs extends StatelessWidget {
  const ExecutiveTopTabs({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildTab(
        String text,
        Color color, {
          VoidCallback? onTap,
        }) {
      return Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(2),
          child: Container(
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextHelper.max1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        buildTab(
          "Total Executive:300",
          AppColors.clrPrimary,
          onTap: () {
            // TODO: Total Retailer
          },
        ),

        const SizedBox(width: 2),

        buildTab(
          "Executive List",
          AppColors.redClr,
          onTap: () {
            // TODO: Retailer List
          },
        ),

        const SizedBox(width: 2),

        buildTab(
          "Create Executive",
          AppColors.create,
          onTap: () {
            Get.toNamed(AppRoutes.createExecutive);
          },
        ),
      ],
    );
  }
}