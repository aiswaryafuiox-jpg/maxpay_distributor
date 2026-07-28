import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class PinBoxWidget extends StatelessWidget {
  final String number;

  const PinBoxWidget({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    bool isFilled = number.isNotEmpty;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(right: 12.w,),

      width: 52.w,//48.w,
      height: 52.w, //48.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFilled
            ? AppColors.clrPrimary
            : (isDark ? AppColors.darkplceholder : Colors.white),
        //borderRadius: BorderRadius.circular(8.r),
        shape: BoxShape.circle,
        border: Border.all(
          color: isFilled
              ? AppColors.clrPrimary
              : (isDark ? AppColors.darkFilterBorder : Colors.grey.shade300),
          width: 1.5,
        ),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: isFilled ? Colors.white : theme.colorScheme.onSurface,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
