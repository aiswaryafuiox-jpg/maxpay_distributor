import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class ProfileTextField extends StatelessWidget {
  final String title;
  final String value;
  final int maxLines;

  const ProfileTextField({
    super.key,
    required this.title,
    required this.value,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isAddressField =
    title.toLowerCase().contains('address');

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

        /// Value Box
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: isAddressField ? 80 : 48,
          ),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
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

          child: Align(
            alignment: isAddressField
                ? Alignment.topLeft
                : Alignment.centerLeft,
            child: Text(
              value,
              maxLines: maxLines,
              style: TextHelper.max9(context).copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}