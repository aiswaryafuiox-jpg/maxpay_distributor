import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

import '../../../core/utils/texthelper.dart';

class PinTextFieldWidget extends StatelessWidget {
  final String hintText;

  const PinTextFieldWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 4,
      style: TextHelper.max1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        hintStyle: TextHelper.max1.copyWith(
          color: isDark ? AppColors.textclr : Colors.grey.shade400,

        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : const Color(0xFFF7F7F7),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
