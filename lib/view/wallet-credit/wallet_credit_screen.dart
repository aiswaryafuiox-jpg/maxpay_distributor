import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/wallet-credit/widget/wallet_credit_filter.dart';

class WalletCreditScreen extends StatefulWidget {
   const WalletCreditScreen({super.key});

  @override
  State<WalletCreditScreen> createState() => _WalletCreditScreenState();
}

class _WalletCreditScreenState extends State<WalletCreditScreen> {
  final WalletController controller = sl<WalletController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchWalletCreditList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "Wallet Credit"),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        child: Column(
          children: [
            /// 🔹 Filter Box
            WalletCreditFilterWidget(
  controller: controller,
),

            const SizedBox(height: 16),

            Divider(
              color:  AppColors.darktextclr.withValues(alpha: 0.5),
            ),


            const SizedBox(height: 16),

            /// 🔹 Credit Amount Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.clrPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Credit Amount",
                    style: TextHelper.max16
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                    "₹ ${controller.totalCreditAmount.value}",
                    style:TextHelper.lato12
                  )),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 List
            Expanded(
              child: Obx(() {
                if (controller.isListLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.walletCreditList.isEmpty) {
                  return const Center(child: Text("No wallet credit history found."));
                }

                return ListView.separated(
                  itemCount: controller.walletCreditList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = controller.walletCreditList[index];
                    return _WalletCreditCard(
                      transactionId: item.transactionId ?? '',
                      dateTime: item.dateTime ?? '',
                      creditType: item.creditType ?? '',
                      amount: item.amount ?? '',
                    );
                  },
                );
              }),
            ),
            //
          ],
        ),
      ),
    );
  }
}

/// 🔹 Date Field
class _DateField extends StatelessWidget {
  final String hint;
  final TextStyle? style;

  const _DateField({
    required this.hint,
  }) : style = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? Colors.white
              : theme.colorScheme.surface,

          borderRadius: BorderRadius.circular(7),

          border: Border.all(
            color: theme.brightness == Brightness.light
                ? const Color(0xFFB5D4F4)
                : theme.colorScheme.outline,
          ),
        ),

        child: Text(
          hint,

          style: style?.copyWith(
                color:
                    theme.colorScheme.onSurfaceVariant,
              ) ??
              TextStyle(
                fontSize: 13,
                color:
                    theme.colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}


/// 🔹 Wallet Credit Card
class _WalletCreditCard extends StatelessWidget {
  final String transactionId;
  final String dateTime;
  final String creditType;
  final String amount;

  const _WalletCreditCard({
    required this.transactionId,
    required this.dateTime,
    required this.creditType,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),

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
          /// 🔹 Top Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Transaction ID: $transactionId",

                  style: TextHelper.max1.copyWith(
                    color: isDark
                        ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                        : AppColors.darktextclr,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

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
                    dateTime,

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

          const SizedBox(height: 8),

          Divider(
           color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
          ),

          const SizedBox(height: 8),

          /// 🔹 Bottom Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    "Credit Type",

                    style: TextHelper.max1.copyWith(

                      color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                    ),
                  ),

                  Text(
                    creditType,

                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  Text(
                    "Amount",

                    style: TextHelper.max1.copyWith(
                      color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                    ),
                  ),

                  Text(
                    "₹ $amount",

                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color:
                          theme.colorScheme.onSurface,
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