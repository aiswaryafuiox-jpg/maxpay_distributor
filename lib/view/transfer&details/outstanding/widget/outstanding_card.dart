import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class OutstandingCard extends StatelessWidget {
  final String retailerName;
  final String mobileNo;
  final String outstandingAmount;

  const OutstandingCard({
    super.key,
    required this.retailerName,
    required this.mobileNo,
    required this.outstandingAmount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2F3349)
            : AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? const Color(0xFF3C3F52)
              : AppColors.totalborde2.withValues(alpha: .35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Retailer Name & Outstanding
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Retailers Name: ",
                      style: TextHelper.max1.copyWith(
                        color: isDark
                            ? Colors.white.withValues(alpha: .65)
                            : AppColors.darktextclr,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        retailerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextHelper.max4.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                "Outstanding",
                style: TextHelper.max1.copyWith(
                  color: isDark
                      ? Colors.white.withValues(alpha: .65)
                      : AppColors.darktextclr,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          /// Mobile No & Amount
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Reg Mob no: ",
                      style: TextHelper.max1.copyWith(
                        color: isDark
                            ? Colors.white.withValues(alpha: .65)
                            : AppColors.darktextclr,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        mobileNo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextHelper.max4.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                outstandingAmount,
                style: TextHelper.max4.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// Received Amount
          Text(
            "Received Amount",
            style: TextHelper.max4.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),

          SizedBox(height: 8.h),

          TextField(
            keyboardType: TextInputType.number,
            style: TextHelper.max9(context),
            cursorColor: AppColors.clrPrimary,
            decoration: InputDecoration(
              hintText: "Enter Amount",
              hintStyle: TextHelper.max1.copyWith(
                color: const Color(0xFFB8BDC7),fontSize: 14
              ),

              filled: true,
              fillColor: const Color(0xFFE9EDF3), // Same grey shade as Figma

              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColors.clrPrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),

          SizedBox(height: 14.h),

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 82.w,
              height: 32.h,
              child: CommonButton(
                title: "Update",
                onTap: () {
                  // TODO: Update API
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}