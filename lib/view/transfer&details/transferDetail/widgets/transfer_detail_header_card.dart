import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class TransferDetailHeaderCard extends StatelessWidget {
  final String title;
  final String amount;
  final bool isReverse;

  const TransferDetailHeaderCard({
    super.key,
    required this.title,
    required this.amount,
    required this.isReverse,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: isReverse
            ? const Color(0xFFFFE4E8)
            : AppColors.clrPrimary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextHelper.max4.copyWith(
              color: isReverse
                  ? Colors.red
                  : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            amount,
            style: TextHelper.lat014(context).copyWith(
              color: isReverse
                  ? Colors.red
                  : Colors.white,
              // fontWeight: FontWeight.w700,
              // fontSize: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}