import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/routes_path.dart';
import '../../../../core/utils/texthelper.dart';
import '../../../../data/model/retailer/retailer_list_response_model.dart';
import '../../../../controller/retailer_controller.dart';
import 'package:get/get.dart';

class RetailerCard extends StatelessWidget {
  final Retailer retailer;

  const RetailerCard({super.key, required this.retailer});

  Widget _buildIconButton(Color bgColor, String svgPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          svgPath,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildAmountColumn(
    String title,
    num? amount,
    Color amountColor,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextHelper.max1.copyWith(
            fontSize: 8.sp,
            fontWeight: .w400,
            color: AppColors.clrTextgrey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          (amount ?? 0.00).currencyIndian,
          style: TextHelper.max2.copyWith(
            color: amountColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    String label,
    String value,
    bool isDark, [
    bool isName = false,
  ]) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            label,
            style: TextHelper.max1.copyWith(
              fontSize: 11.sp,
              fontWeight: .w500,

              color: AppColors.clrTextgrey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            " : ",
            style: TextHelper.max1.copyWith(
              color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            value,
            style: TextHelper.max1.copyWith(
              fontSize: 12.sp,
              fontWeight: isName ? .w700 : .w500,
              color: AppColors.clrTextblack,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5FBFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0x0A000000), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 6,
                child: Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    _buildTableRow(
                      "Retailer Name",
                      retailer.retailerName?.capitalize ?? "-",
                      isDark,
                      true,
                    ),
                    _buildTableRow(
                      "Reg. Mobile No",
                      retailer.regMobileNumber != null
                          ? "+91 ${retailer.regMobileNumber}"
                          : "-",
                      isDark,
                    ),
                    _buildTableRow(
                      "Exe. Name",
                      retailer.executiveName ?? "-",
                      isDark,
                    ),
                  ],
                ),
              ),
              FittedBox(
                fit: .scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Wallet Amount",
                      style: TextHelper.max1.copyWith(
                        fontWeight: .w400,
                        fontSize: 10,
                        color: AppColors.clrTextgrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      (retailer.walletAmount ?? '0.00').currencyIndian,
                      style: TextHelper.max2.copyWith(
                        color: const Color(0xFF17A2B8), // cyan
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Divider(
            color: isDark ? AppColors.darkFilterBorder : Colors.grey.shade300,
            thickness: 1,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAmountColumn(
                "Due Amount",
                num.parse(retailer.dueAmount ?? '0.00'),
                const Color(0xFFEE0023),
                isDark,
              ),
              _buildAmountColumn(
                "Today Online",
                num.parse(retailer.todayOnline ?? '0.00'),
                const Color(0xFFFD7E14),
                isDark,
              ),
              _buildAmountColumn(
                "Today Transfer",
                num.parse(retailer.todayTransfer ?? '0.00'),
                const Color(0xFF28A745),
                isDark,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient:
                      retailer.commissionPackage?.toLowerCase() == 'silver'
                      ? AppColors.silverGradient
                      : retailer.commissionPackage?.toLowerCase() == 'platinum'
                      ? AppColors.platinumGradient
                      : retailer.commissionPackage?.toLowerCase() == 'emerald'
                      ? AppColors.emeraldGradient
                      : AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  retailer.commissionPackage ?? "Silver",
                  style: TextHelper.max1.copyWith(
                    color:
                        retailer.commissionPackage?.toLowerCase() == 'emerald'
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 38,
                  width: 60,
                  decoration: BoxDecoration(
                    color: retailer.isActive == 1
                        ? AppColors.activeBtn
                        : AppColors.redClr,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    retailer.isActive == 1 ? "Active" : "Inactive",
                    style: TextHelper.max1.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIconButton(
                    const Color(0xFF007BFF),
                    AssetImages.receipt,
                    () {
                      // Action for receipt
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildIconButton(
                    const Color(0xFFFD7E14),
                    AssetImages.profileSolo,
                    () {
                      if (retailer.userId != null) {
                        Get.toNamed(
                          AppRoutes.retviewDetailsScreen,
                          arguments: {'id': retailer.id},
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildIconButton(
                    const Color(0xFF17A2B8),
                    AssetImages.walletAdd,
                    () {
                      Get.find<RetailerController>().fetchAddWalletDetails(
                        retailer.id!,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
