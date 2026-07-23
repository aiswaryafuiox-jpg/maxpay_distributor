import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHistoryScreen extends StatelessWidget {
  const LoginHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "Login History"),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        child: Column(
          children: [
            /// FILTER BOX
            const CommonFilterBox(),

            const SizedBox(height: 16),

            Divider(color: AppColors.darktextclr.withValues(alpha: 0.5)),

            const SizedBox(height: 16),

            /// CARD LIST
            Expanded(
              child: ListView(
                children: const [
                  _LoginHistoryCard(),

                  SizedBox(height: 10),

                  _LoginHistoryCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// DATE FIELD
class _DateField extends StatelessWidget {
  final String hint;

  const _DateField({required this.hint});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? AppColors.white
              : theme.colorScheme.surface,

          borderRadius: BorderRadius.circular(7),

          border: Border.all(color: theme.colorScheme.outline),
        ),

        child: Text(
          hint,

          style: TextStyle(
            fontSize: 12,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// LOGIN HISTORY CARD
class _LoginHistoryCard extends StatelessWidget {
  const _LoginHistoryCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? const Color(0xFFF6F7FF)
            : const Color(0xFF2F3349),

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
      ),

      child: Column(
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                children: [
                  Image.asset(AssetImages.filter),

                  const SizedBox(width: 4),

                  Text(
                    "Madurai",

                    style: TextHelper.max1.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Text(
                    "Date & Time:",

                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "2026-11-29 14:38:43",

                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
            thickness: 1,
          ),

          const SizedBox(height: 13),

          /// BOTTOM ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Network",

                    style: TextHelper.max6.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF)
                          : AppColors.clrTextblack,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "IP Address",

                    style: TextHelper.max6.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF)
                          : AppColors.clrTextblack,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Text(
                    "http//network.router",

                    style: TextHelper.max7.copyWith(
                      color: const Color(0xFF314CFF),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "16.25.20.0.2.0000.54",

                    style: TextHelper.max7.copyWith(
                      color: const Color(0xFF314CFF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
