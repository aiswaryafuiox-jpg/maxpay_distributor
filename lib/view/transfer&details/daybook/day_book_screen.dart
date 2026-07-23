import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import '../../../global_widget/commom_button.dart';
import 'day_book_card.dart';

class DayBookScreen extends StatelessWidget {
  const DayBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Day Book",
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// FILTER CONTAINER
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkplceholder
                    : AppColors.lightbg2,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2.withValues(alpha: .2),
                ),
              ),
              child: Column(
                children: [
                  /// SELECT PRODUCT
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkplceholder
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : AppColors.totalborde2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Product",
                          style: TextHelper.max1.copyWith(
                            color: isDark
                                ? AppColors.textclr
                                : AppColors.clrTextgrey,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 18.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// DATE
                  Row(
                    children: [
                      Expanded(
                        child: _customField(
                          context,
                          hint: "DD.MM.YYYY",
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Icon(
                          Icons.arrow_forward,
                          color: theme.colorScheme.onSurface,
                          size: 18.sp,
                        ),
                      ),

                      Expanded(
                        child: _customField(
                          context,
                          hint: "DD.MM.YYYY",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  /// SEARCH
                  _customField(
                    context,
                    hint: "Search",
                    prefixWidget: SvgPicture.asset(
                      AssetImages.search,
                      width: 18.w,
                      height: 18.w,
                      colorFilter: ColorFilter.mode(
                        isDark
                            ? AppColors.textclr
                            : theme.colorScheme.onSurfaceVariant,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 18.h),

            /// LIST
            Column(
              children: [
                DayBookCard(
                  retailerName: "Kumar",
                  mobileNo: "9876543212",
                  transactionId: "TXN24321232323",
                  transactionType: "Wallet Transfer",
                  receivedAmount: "₹40.00",
                  dateTime: "29-11-2026 07:38:43PM",
                ),

                SizedBox(height: 14.h),

                SizedBox(
                  width: 120.w,
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFDDE2),
                      foregroundColor: const Color(0xFFEE0023),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      "Delete",
                      style: TextHelper.max4.copyWith(
                        color: const Color(0xFFEE0023),
                        fontWeight: FontWeight.w600,

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customField(
      BuildContext context, {
        required String hint,
        Widget? prefixWidget,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2,
        ),
      ),
      child: Row(
        children: [
          if (prefixWidget != null) ...[
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: prefixWidget,
            ),
            SizedBox(width: 8.w),
          ],
          Expanded(
            child: Text(
              hint,
              style: TextHelper.max1.copyWith(
                color: isDark
                    ? AppColors.textclr
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}