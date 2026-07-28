import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_card.dart';

import '../../global_widget/custom_app.dart';

enum TransactionStatus { success, pending, failed }

class TransactionScreen extends StatefulWidget {
  final TransactionStatus status;

  const TransactionScreen({super.key, required this.status});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isFavorite = false;
  final Set<int> _favoriteCards = <int>{};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isSuccess = widget.status == TransactionStatus.success;
    final bool isPending = widget.status == TransactionStatus.pending;

    Color bgColor;
    String title;

    if (isSuccess) {
      bgColor = isDark ? const Color(0xFFE2F8E9) : const Color(0xFFD1FFE8);
      title = "Transaction Success";
    } else if (isPending) {
      bgColor = isDark ? const Color(0xFFFFF1DD) : const Color(0xFFFFF1DD);
      title = "Transaction Pending";
    } else {
      bgColor = isDark ? const Color(0xFFFFE4E6) : const Color(0xFFFFE4E6);
      title = "Transaction Failed";
    }
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: title,
        onBack: () {
          Get.back();
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          children: [
            /// FILTER CONTAINER
            Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? AppColors.border
                    : AppColors.darkplceholder,

                borderRadius: BorderRadius.circular(10),

                border: Border.all(
                  color: theme.brightness == Brightness.light
                      ? AppColors.totalborde2.withValues(alpha: 0.1)
                      : AppColors.darkFilterBorder,
                ),
              ),

              child: Column(
                children: [
                  /// SELECT CREDIT TYPE
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
                          ? Colors.white
                          : AppColors.darkplceholder,

                      borderRadius: BorderRadius.circular(8),

                      border: Border.all(
                        color: theme.brightness == Brightness.light
                            ? AppColors.darktextclr.withValues(alpha: 0.3)
                            : AppColors.darkFilterBorder,
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "Select Product",

                          style: TextHelper.max1.copyWith(
                            color: isDark
                                ? AppColors.textclr
                                : AppColors.clrTextgrey,
                          ),
                        ),

                        Icon(
                          Icons.chevron_right,
                          color: isDark
                              ? AppColors.textclr
                              : theme.colorScheme.onSurfaceVariant,
                          size: 18,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// DATE FIELD
                  Row(
                    children: [
                      Expanded(child: customField(context, hint: "DD/MM/YYYY")),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.arrow_forward,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      Expanded(child: customField(context, hint: "DD/MM/YYYY")),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// SEARCH FIELD
                  customField(
                    context,
                    hint: "Search",
                    prefixWidget: SvgPicture.asset(
                      AssetImages.search,
                      colorFilter: ColorFilter.mode(
                        isDark ? AppColors.textclr : AppColors.darktextclr,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// TRANSACTION LIST
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    bgColor: bgColor,
                    status: widget.status,
                    isFavorite: _favoriteCards.contains(index),
                    onFavoriteTap: () {
                      setState(() {
                        if (!_favoriteCards.add(index)) {
                          _favoriteCards.remove(index);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customField(
    BuildContext context, {
    required String hint,
    Widget? prefixWidget,
  }) {
    final theme = Theme.of(context);

    return Container(
      height: 45,

      padding: const EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.white
            : AppColors.darkplceholder,

        borderRadius: BorderRadius.circular(8),

        border: Border.all(
          color: theme.brightness == Brightness.light
              ? AppColors.darktextclr.withValues(alpha: 0.3)
              : AppColors.darkFilterBorder,
        ),
      ),

      child: Row(
        children: [
          if (prefixWidget != null) ...[
            SizedBox(width: 18, height: 18, child: prefixWidget),

            const SizedBox(width: 8),
          ],

          Expanded(
            child: Text(
              hint,

              style: TextHelper.max1.copyWith(
                color: theme.brightness == Brightness.dark
                    ? AppColors.textclr
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
