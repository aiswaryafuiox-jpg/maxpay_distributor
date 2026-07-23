import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';

class EarningsCard1 extends StatelessWidget {
  const EarningsCard1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : const Color(0xFF2F3349),

        borderRadius: BorderRadius.circular(12),

        border: theme.brightness == Brightness.dark
            ? Border.all(
                color: const Color(0xFF3C3F52),
              )
            : null,
      ),

      child: Column(
        children: [
          /// 🔹 TOP ROW
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "Date & Time:",

                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                "2026-11-29 14:38:43",

                style: TextStyle(
                  fontSize: 12,
                 color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// 🔹 Divider
          Divider(
            color:AppColors.darktextclr.withValues(alpha: 0.5) ,
          ),

          const SizedBox(height: 8),

          /// 🔹 Bottom Row
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,

            children: [
              /// Avatar
              Row(
                children: const [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,

                    child: Text(
                      "J",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(width: 10),
                ],
              ),

              /// Name + Amount
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Jio",

                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color:
                            theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Transaction No: 9865647823",

                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color:
                            theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              /// Earnings
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  Text(
                    "₹ 365",

                    style: TextStyle(
                      color:
                          theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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