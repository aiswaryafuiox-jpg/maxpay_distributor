import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/retailer_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class RetailerTopTabs extends StatelessWidget {
  const RetailerTopTabs({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildTab(
      String? text,
      Widget? icon,

      Color color, {
      BorderRadius? borderRadius,
      bool isSelected = false,
      VoidCallback? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, borderRadius: borderRadius),
          child: Row(
            mainAxisAlignment: .center,
            spacing: text == null ? 0 : 8,
            children: [
              icon ?? SizedBox.shrink(),
              text == null
                  ? SizedBox.shrink()
                  : Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextHelper.max1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        margin: .symmetric(horizontal: 16.w, vertical: 6),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Obx(() {
                final val = Get.find<RetailerController>().retailers.value;
                return buildTab(
                  "${val.activeCount ?? 0}",
                  SvgPicture.asset(AssetImages.profileUser),

                  AppColors.active1Bg,
                  isSelected: true,
                  borderRadius: const BorderRadius.only(),
                );
              }),
            ),
            Expanded(
              child: Obx(() {
                final val = Get.find<RetailerController>().retailers.value;
                return buildTab(
                  "${val.inactiveCount ?? 0}",
                  SvgPicture.asset(AssetImages.profileUser),

                  AppColors.redClr,
                  isSelected: true,
                  borderRadius: const BorderRadius.only(),
                );
              }),
            ),
            Expanded(
              child: buildTab(
                null,
                SvgPicture.asset(AssetImages.profileUser),

                AppColors.clrPrimary,
              ),
            ),
            Expanded(
              child: buildTab(
                null,
                SvgPicture.asset(AssetImages.addProfile),

                AppColors.blueColor,
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
      ),
    );
  }
}
