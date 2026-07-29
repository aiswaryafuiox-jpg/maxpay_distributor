import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class CashbackScreen extends StatelessWidget {
  const CashbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,

      /// ✅ Global AppBar
      appBar: const CommonAppBar(title: "Cash Back"),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        child: Column(
          children: [
            /// 🔵 Filter Box
            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? AppColors.border
                    : AppColors.darkplceholder,

                borderRadius: BorderRadius.circular(14),

                border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2.withValues(alpha: 0.1),
                ),
              ),

              /// Search / Dropdown
              child: Container(
                height: 52,

                padding: const EdgeInsets.symmetric(horizontal: 14),

                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.light
                      ? Colors.white
                      : AppColors.darkplceholder,

                  borderRadius: BorderRadius.circular(10),

                  border: Border.all(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkFilterBorder
                        : AppColors.darktextclr.withValues(alpha: 0.5),
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "Select Product ",

                      style: TextHelper.max1.copyWith(
                        color: theme.brightness == Brightness.dark
                            ? AppColors.textclr
                            : AppColors.clrTextgrey,
                      ),
                    ),

                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,

                      color: theme.brightness == Brightness.dark
                          ? AppColors.textclr
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// Cashback List
            Expanded(
              child: ListView(
                children: [
                  CashbackTile(cashback: "5.0%", cashbackColor: Color(0xFF00C261)),

                  SizedBox(height: 12),

                  CashbackTile(cashback: "-5.0%", cashbackColor: Color(0xFFFF0000)),

                  SizedBox(height: 12),

                  CashbackTile(cashback: "₹ 5.00", cashbackColor: Color(0xFF00C261)),

                  SizedBox(height: 12),

                  CashbackTile(cashback: "₹ -5.00", cashbackColor: Color(0xFFFF0000)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CashbackTile extends StatelessWidget {
  final String cashback;
  final Color cashbackColor;
  

  const CashbackTile({
    super.key,
    required this.cashback,
    required this.cashbackColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

      decoration: BoxDecoration(
        color: !isDark
            ? AppColors.background
            : AppColors.darkplceholder,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
      ),

      child: Row(
        children: [
          /// Jio Logo
          Container(
            height: 42,
            width: 42,

            decoration: BoxDecoration(
              color: Color(0xFFFF0000),
              shape: BoxShape.circle,
            ),

            alignment: Alignment.center,

            child: const Text(
              "Jio",

              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// Name
          Expanded(
            child: Text(
              "Jio",

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          /// Cashback
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                "Cashback",

                style: TextHelper.max2.copyWith(
                  // color: theme.colorScheme.onSurfaceVariant,
                   color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                cashback,

                style: TextStyle(
                  color: cashbackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
