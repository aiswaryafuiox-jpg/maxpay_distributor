import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/data/model/wallet_credit_list_model.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/wallet-credit/widget/wallet_credit_filter.dart';

class WalletCreditScreen extends StatelessWidget {
  WalletCreditScreen({super.key});

  final WalletController controller = Get.isRegistered<WalletController>()
      ? Get.find<WalletController>()
      : Get.put(sl<WalletController>());

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
            WalletCreditFilterWidget(controller: controller),

            const SizedBox(height: 16),

            Divider(color: AppColors.darktextclr.withValues(alpha: 0.5)),

            const SizedBox(height: 16),

            /// 🔹 Credit Amount Card
            Obx(
              () => Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Credit Amount", style: TextHelper.max16),
                    const SizedBox(height: 4),
                    Text(
                      "₹ ${controller.totalCreditAmount.value}",
                      style: TextHelper.lato12,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 List
            Expanded(
              child: Obx(() {
                if (controller.isLoadingList.value &&
                    controller.walletCreditItems.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.walletCreditItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "No wallet credit records found",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchWalletCreditList();
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.walletCreditItems.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = controller.walletCreditItems[index];
                      return _WalletCreditCard(item: item);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Wallet Credit Card
class _WalletCreditCard extends StatelessWidget {
  final WalletCreditItem item;

  const _WalletCreditCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: !isDark ? AppColors.background : const Color(0xFF2F3349),
        borderRadius: BorderRadius.circular(12),
        border: isDark ? Border.all(color: const Color(0xFF3C3F52)) : null,
      ),
      child: Column(
        children: [
          /// 🔹 Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Transaction ID: ${item.transactionId ?? 'N/A'}",
                  style: TextHelper.max1.copyWith(
                    color: isDark
                        ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                        : AppColors.darktextclr,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
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
                    item.dateTime ?? 'N/A',
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
                ? const Color(0xFFFFFFFF).withValues(alpha: 0.3)
                : AppColors.darktextclr.withValues(alpha: 0.2),
          ),

          const SizedBox(height: 8),

          /// 🔹 Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Credit Type",
                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.creditType ?? 'N/A',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Amount",
                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹ ${item.amount ?? '0.00'}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
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
