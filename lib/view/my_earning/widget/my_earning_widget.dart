// import 'package:flutter/material.dart';
// import 'package:maxpay/core/constants/colors.dart';
//
// class EarningsCard extends StatelessWidget {
//   const EarningsCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: theme.brightness == Brightness.light
//             ? AppColors.background
//             : const Color(0xFF2F3349),
//
//         borderRadius: BorderRadius.circular(12),
//
//         border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
//       ),
//
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Date & Time:",
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: isDark
//                       ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
//                       : AppColors.darktextclr,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//
//               Text(
//                 "2026-11-29 14:38:43",
//                 style: TextStyle(
//                   fontSize: 12,
//                  color: isDark
//                       ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
//                       : AppColors.darktextclr,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 8),
//
//           /// 🔹 Divider
//           Divider(color: AppColors.darktextclr),
//
//           const SizedBox(height: 8),
//
//           /// 🔹 Bottom Row
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               /// Avatar
//               Row(
//                 children: const [
//                   CircleAvatar(
//                     radius: 18,
//                     backgroundColor: Colors.red,
//                     child: Text("J", style: TextStyle(color: Colors.white)),
//                   ),
//
//                   SizedBox(width: 10),
//                 ],
//               ),
//
//               /// Name + Amount
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Jio",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w500,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//
//                     const SizedBox(height: 4),
//
//                     Text(
//                       "Total Amount : ₹100",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// Earnings
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "My Earnings",
//                     style: TextStyle(
//                       fontSize: 11,
//                         color: isDark
//                       ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
//                       : AppColors.darktextclr,
//                     ),
//                   ),
//
//                   const SizedBox(height: 4),
//
//                   const Text(
//                     "₹ 5",
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';


class EarningsCard extends StatelessWidget {
  final String transactionNo;
  final String dateTime;
  final String productName;
  final String productType;
  final String productLogo;
  final String transactionAmount;
  final String myEarnings;

  const EarningsCard({
    super.key,
    required this.transactionNo,
    required this.dateTime,
    required this.productName,
    required this.productType,
    required this.productLogo,
    required this.transactionAmount,
    required this.myEarnings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final secondaryTextColor = isDark
        ? Colors.white.withValues(alpha: 0.7)
        : AppColors.darktextclr;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3349) : AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          /// Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Transaction No: $transactionNo",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: secondaryTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateTime,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.withValues(alpha: 0.4), thickness: 0.8),
          const SizedBox(height: 10),

          /// Bottom Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Logo
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.transparent,
                backgroundImage: productLogo.isNotEmpty 
                    ? NetworkImage(productLogo) 
                    : null,
                child: productLogo.isEmpty
                    ? Text(
                        productName.isNotEmpty ? productName[0] : "?",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),

              const SizedBox(width: 12),

              /// Recharge Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productType,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tr.Amount : ₹$transactionAmount",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              /// Earnings
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "My Earnings",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹ $myEarnings",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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
