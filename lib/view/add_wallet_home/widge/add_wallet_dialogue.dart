import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';

import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddWalletPopup extends StatefulWidget {
  final String amount;
  final String url;
  final String txtionId;

  const AddWalletPopup({
    super.key,
    required this.amount,
    required this.url,
    required this.txtionId,
  });

  @override
  State<AddWalletPopup> createState() => _AddWalletPopupState();
}

class _AddWalletPopupState extends State<AddWalletPopup> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        (_scrollController.offset - 80).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        (_scrollController.offset + 80).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text(
                    "Account Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final controller = Get.find<AddWalletController>();
                      controller.stopTimer();
                      controller.amountController.clear();
                      Get.back();
                      await controller.getWalletHistory();
                    },
                    child: const Icon(
                      Icons.cancel,
                      size: 24,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// QR Code
              Container(
                width: 220,
                height: 220,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: QrImageView(
                    data: widget.url,
                    version: QrVersions.auto,
                    size: 220,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Amount & Expiry Box (matching image design)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkplceholder : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.clrPrimary, width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(() {
                          final controller = Get.find<AddWalletController>();
                          final minutes =
                              (controller.remainingSeconds.value ~/ 60)
                                  .toString()
                                  .padLeft(2, '0');
                          final seconds =
                              (controller.remainingSeconds.value % 60)
                                  .toString()
                                  .padLeft(2, '0');

                          return Text(
                            "Expiry: $minutes.$seconds",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkbgBlack
                            : const Color(0xFFF6F8FA),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        widget.amount.currencyIndian,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// "Pay Using" Card (matching image design)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkplceholder : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.2 : 0.05,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: isDark
                      ? Border.all(color: AppColors.darkFilterBorder)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pay Using",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.clrPrimary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Obx(() {
                      final controller = Get.find<AddWalletController>();

                      if (controller.isLoadingUpiApps.value) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (controller.upiApps.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "No UPI apps installed",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        );
                      }

                      return Row(
                        children: [
                          /// Left Scroll Button
                          GestureDetector(
                            onTap: _scrollLeft,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF8CE0EE),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          /// UPI Apps List
                          Expanded(
                            child: SizedBox(
                              height: 62,
                              child: ListView.separated(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.upiApps.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  final app = controller.upiApps[index];
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      controller.openSpecificUpiApp(
                                        packageName: app["packageName"],
                                        url: widget.url,
                                      );
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? AppColors.darkbgBlack
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isDark
                                              ? Colors.grey.shade800
                                              : Colors.grey.shade200,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.04,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.memory(
                                            app["icon"],
                                            width: 42,
                                            height: 42,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          /// Right Scroll Button
                          GestureDetector(
                            onTap: _scrollRight,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF8CE0EE),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
