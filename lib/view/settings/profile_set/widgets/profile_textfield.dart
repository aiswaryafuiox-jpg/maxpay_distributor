import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class ProfileTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? initialValue;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const ProfileTextField({
    super.key,
    required this.title,
    this.controller,
    this.initialValue,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          title,
          style: TextHelper.max6.copyWith(
            color: theme.colorScheme.onSurface,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkplceholder
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark
                  ? AppColors.darkFilterBorder
                  : AppColors.totalborde2,
            ),
          ),
          child: TextFormField(
            controller: controller,
            initialValue: initialValue,
            maxLines: maxLines,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            style: TextHelper.max9(context).copyWith(
              color: theme.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              counterText: maxLength != null ? "" : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}