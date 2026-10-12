import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/data/model/partner/partner_list_response_model.dart';

class PartnerCard extends StatelessWidget {
  final StockistItem partner;
  final VoidCallback? onAddWallet;

  const PartnerCard({super.key, required this.partner, this.onAddWallet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final labelColor = isDark ? AppColors.textclr : const Color(0xFF5A6A80);
    final valueColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3349) : const Color(0xFFF8F9FD),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark ? AppColors.darkFilterBorder : const Color(0xFFE5E9F2),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Retailers Name
          Text.rich(
            TextSpan(
              text: "Distributor Name: ",
              style: TextStyle(
                color: labelColor,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              children: [
                TextSpan(
                  text: partner.displayName,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 6.h),

          // Reg Mob no
          Text.rich(
            TextSpan(
              text: "Reg Mob no: ",
              style: TextStyle(
                color: labelColor,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              children: [
                TextSpan(
                  text: partner.displayPhone,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),

          if (onAddWallet != null) ...[
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onAddWallet,
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0EA5B6),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "Add Wallet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
