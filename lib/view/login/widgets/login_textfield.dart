import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;

  const LoginTextField({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextField(
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: 'Lufga',
          color: theme.colorScheme.onTertiaryFixedVariant,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Lufga',
            color: theme.colorScheme.onTertiaryFixedVariant,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
