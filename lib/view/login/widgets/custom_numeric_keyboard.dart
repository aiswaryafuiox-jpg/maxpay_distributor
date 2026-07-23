import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class CustomNumericKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomNumericKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 400 : double.infinity, // 🔥 KEY FIX
        ),
        child: Column(
          children: [
            _buildKeyboardRow(['1', '2', '3'], context),
            SizedBox(height: 16.h),
            _buildKeyboardRow(['4', '5', '6'], context),
            SizedBox(height: 16.h),
            _buildKeyboardRow(['7', '8', '9'], context),
            SizedBox(height: 16.h),
            _buildKeyboardRow(['backspace', '0', 'submit'], context),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> keys, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        return Expanded(child: _buildKeyboardButton(key, context));
      }).toList(),
    );
  }

  Widget _buildKeyboardButton(String key, BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return SizedBox(
      height: isTablet ? 80 : 60, // 🔥 SAME HEIGHT FOR ALL
      child: TextButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          onKeyPressed(key);
        },
        style: TextButton.styleFrom(shape: const CircleBorder()),
        child: key == 'backspace'
            ? const Icon(
                Icons.backspace_outlined,
                color: AppColors.clrTextblack,
                size: 22,
              )
            : key == 'submit'
            ? const Icon(
                Icons.arrow_forward,
                color: AppColors.clrPrimary,
                size: 22,
              )
            : Text(
                key,
                style: TextStyle(
                  fontSize: isTablet ? 28 : 23, // 🔥 FIXED
                ),
              ),
      ),
    );
  }
}
