import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/routes_path.dart';
import '../../../../core/utils/texthelper.dart';


class RetailerCard extends StatelessWidget {
  final bool isActive;

  const RetailerCard({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : AppColors.lightbg2,
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
                  text: "John Williamson",
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
                  text: "+91 9876546271",
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

          const SizedBox(height: 12),

          Divider(
            color: isDark
                ? AppColors.darkFilterBorder
                : Colors.grey.shade300,
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
                      color: isDark
                          ? AppColors.textclr
                          : AppColors.clrTextgrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹100.00",
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
                      color: isDark
                          ? AppColors.textclr
                          : AppColors.clrTextgrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹500.00",
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
                          color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                        ),
                      ),
                      TextSpan(
                        text: "Klein Moriarti",
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
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffF7F7F7),
                      Color(0xffD8DEE6),
                    ],
                  ),
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
      //         height: 34,
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             elevation: 0,
      //             backgroundColor: Colors.green,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(6),
      //             ),
      //           ),
      //           onPressed: () {},
      //           child: Text(
      //             "Add Wallet",
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
      //   ],
      // )]));}}
        Row(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 34,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isActive ? Colors.green : Colors.red,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    isActive ? "Active" : "Inactive",
                    maxLines: 1,
                    style: TextHelper.max1.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            Expanded(
              flex: 4,
              child: SizedBox(
                height: 34,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.view,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {

                      Get.toNamed(AppRoutes.retviewDetailsScreen);
                    },

                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "View Details",
                      maxLines: 1,
                      style: TextHelper.max1.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            Expanded(
              flex: 4,
              child: SizedBox(
                height: 34,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.retaddWalletScreen);
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Add Wallet",
                      maxLines: 1,
                      style: TextHelper.max1.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )]));}}