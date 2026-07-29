import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/view/transfer&details/executive/exe_add_wallet_screen.dart';
import 'package:maxpay/view/transfer&details/retailers/widgets/retailor_cardbutton.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/texthelper.dart';
import '../../../../controller/executive_controller.dart';

import '../../../../data/model/executive/executive_list_response_model.dart';

class ExecutiveCard extends StatelessWidget {
  final Executive executive;

  const ExecutiveCard({super.key, required this.executive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Executive Name: ",
                  style: TextHelper.max1.copyWith(
                    color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                  ),
                ),
                TextSpan(
                  text: executive.executiveName ?? "-",
                  style: TextHelper.max1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Reg. Mobile No: ",
                  style: TextHelper.max1.copyWith(
                    color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                  ),
                ),
                TextSpan(
                  text: "+91 ${executive.regMobileNumber ?? '-'}",
                  style: TextHelper.max1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Divider(
            color: isDark ? AppColors.darkFilterBorder : Colors.grey.shade300,
            thickness: 1,
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due Amount",
                    style: TextHelper.max1.copyWith(
                      color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${executive.dueAmount?.currencyIndian ?? 0.00}",
                    style: TextHelper.max2.copyWith(
                      color: Color(0xFFEE0023),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Wallet Amount",
                    style: TextHelper.max1.copyWith(
                      color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (executive.walletBalance ?? 0.00).currencyIndian,
                    style: TextHelper.max2.copyWith(
                      color: AppColors.clrPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: .end,
            children: [
              RetailerListCardButton(
                color: executive.isActive == 1
                    ? AppColors.activeBtn
                    : Color(0xFFEE0023),
                onPressed: () {},
                textColor: AppColors.white,
                text: executive.isActive == 1 ? "Active" : "Inactive",
              ),

              const SizedBox(width: 6),

              GetBuilder<ExecutiveController>(
                builder: (controller) {
                  return Obx(() {
                    return RetailerListCardButton(
                      color: Color(0xFFEE0023),

                      onPressed: controller.isDetailLoading.value
                          ? () {}
                          : () {
                              if (executive.id != null) {
                                controller.fetchExecutiveDetail(
                                  executive.id.toString(),
                                );
                              }
                            },
                      text: "View Details",
                      textColor: AppColors.white,
                    );
                  });
                },
              ),

              const SizedBox(width: 6),

              RetailerListCardButton(
                color: AppColors.activeBtn,
                onPressed: () {
                  final executiveId = executive.id;
                  Get.toNamed(
                    AppRoutes.exeAddWalletScreen,
                    arguments: executiveId,
                  );
                },
                text: "Add Wallet",
                textColor: AppColors.activeBg,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
