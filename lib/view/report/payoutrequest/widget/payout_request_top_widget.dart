import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import '../../../../global_widget/commom_button.dart';

class PayoutRequestTopWidget extends StatelessWidget {
  const PayoutRequestTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : AppColors.border,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.withValues(alpha: .10),
        ),
      ),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Total",

              hintStyle: TextHelper.max12(context),

              filled: true,

              fillColor: isDark
                  ? AppColors.darkplceholder
                  : theme.colorScheme.surface,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Center(
            child: CommonButton(
              title: "Submit",
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}