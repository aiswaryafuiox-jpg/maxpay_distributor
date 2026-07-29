
import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class RetailerListCardButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final VoidCallback onPressed;
  const RetailerListCardButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.activeColor,
    this.textColor = AppColors.darkbgBlack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextHelper.max1.copyWith(color: textColor, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
