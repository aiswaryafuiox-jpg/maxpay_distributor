import 'package:flutter/material.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/view/transfer&details/retailers/widgets/retailor_cardbutton.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/routes_path.dart';
import '../../../../core/utils/texthelper.dart';

import '../../../../data/model/retailer/retailer_list_response_model.dart';
import '../../../../controller/retailer_controller.dart';
import 'package:get/get.dart';

class RetailerCard extends StatelessWidget {
  final Retailer retailer;

  const RetailerCard({super.key, required this.retailer});

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
                  text: "Retailer Name: ",
                  style: TextHelper.max1.copyWith(
                    color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                  ),
                ),
                TextSpan(
                  text: retailer.retailerName ?? "-",
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
                  text: retailer.regMobileNumber != null
                      ? "+91 ${retailer.regMobileNumber}"
                      : "-",
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
                    (retailer.dueAmount ?? 0.00).currencyIndian,
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
                    (retailer.walletAmount ?? 0.00).currencyIndian,
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

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Executive Name: ",
                        style: TextHelper.max1.copyWith(
                          color: isDark
                              ? AppColors.textclr
                              : AppColors.clrTextgrey,
                        ),
                      ),
                      TextSpan(
                        text: retailer.executiveName ?? "-",
                        style: TextHelper.max1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textclr
                              : AppColors.clrTextblack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.silverGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Silver",
                  style: TextHelper.max1.copyWith(
                    color: Colors.black87,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Row(
          //   children: [
          //     Expanded(
          //       child: SizedBox(
          //         height: 34,
          //         child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             elevation: 0,
          //             backgroundColor: isActive ? Colors.green : Colors.red,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(6),
          //             ),
          //           ),
          //           onPressed: () {},
          //           child: Text(
          //             isActive ? "Active" : "Inactive",
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //             style: TextHelper.max1.copyWith(
          //               color: Colors.white,
          //               fontSize: 10,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //
          //     const SizedBox(width: 8),
          //
          //     Expanded(
          //       child: SizedBox(
          //         height: 34,
          //         child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             elevation: 0,
          //             backgroundColor: AppColors.view,
          //             alignment: Alignment.centerLeft,
          //             padding: const EdgeInsets.symmetric(horizontal: 8),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(6),
          //             ),
          //           ),
          //           onPressed: () {},
          //           child: Text(
          //             "View Details",
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //             style: TextHelper.max1.copyWith(
          //               color: Colors.white,
          //               fontSize: 10,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //
          //     const SizedBox(width: 8),
          //
          //     Expanded(
          //       child: SizedBox(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RetailerListCardButton(
                color: retailer.isActive == 1
                    ? AppColors.activeBtn
                    : AppColors.redClr,
                textColor: AppColors.white,
                onPressed: () {},
                text: retailer.isActive == 1 ? "Active" : "Inactive",
              ),

              const SizedBox(width: 6),

              RetailerListCardButton(
                onPressed: () {
                  if (retailer.id != null) {
                    Get.toNamed(
                      AppRoutes.retviewDetailsScreen,
                      arguments: {'id': retailer.id.toString()},
                    );
                  }
                },
                color: AppColors.view,
                textColor: AppColors.white,
                text: "View Details",
              ),

              const SizedBox(width: 6),

              RetailerListCardButton(
                color: AppColors.activeBtn,
                textColor: AppColors.white,
                onPressed: () {
                  Get.find<RetailerController>().fetchAddWalletDetails(
                    retailer.id.toString(),
                  );
                },
                text: "Add Wallet",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
