import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_card.dart';
import '../../controller/transaction_controller.dart';

import '../../global_widget/custom_app.dart';

enum TransactionStatus { success, pending, failed }

class TransactionScreen extends StatefulWidget {
  final TransactionStatus status;

  const TransactionScreen({super.key, required this.status});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionController _controller = Get.find<TransactionController>();
  bool isFavorite = false;
  final Set<int> _favoriteCards = <int>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchTransactionReport(statusOverride: widget.status.name);
    });
  }

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
      title = "Transaction Processing";
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
                  /// SELECT PRODUCT DROPDOWN
                  Obx(() {
                    if (_controller.isProductsLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DropdownButtonFormField<int?>(
                      initialValue: _controller.selectedProduct.value?.id,
                      dropdownColor: isDark
                          ? AppColors.darkplceholder
                          : Colors.white,
                      decoration: InputDecoration(
                        hintText: "Select Product",
                        hintStyle: TextHelper.max1.copyWith(
                          color: isDark
                              ? AppColors.textclr
                              : AppColors.clrTextgrey,
                        ),
                        filled: true,
                        fillColor: isDark
                            ? AppColors.darkplceholder
                            : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
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
                                : AppColors.darktextclr.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.darkFilterBorder
                                : AppColors.clrPrimary,
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isDark
                            ? AppColors.textclr
                            : theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      items: [
                        DropdownMenuItem<int?>(
                          value: null,
                          child: Text(
                            "All Products",
                            style: TextHelper.max1.copyWith(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        ..._controller.products.map((product) {
                          return DropdownMenuItem<int?>(
                            value: product.id,
                            child: Row(
                              children: [
                                if (product.logo != null &&
                                    product.logo!.isNotEmpty) ...[
                                  Image.network(
                                    product.logo!,
                                    width: 20,
                                    height: 20,
                                    errorBuilder: (_, _, _) =>
                                        const SizedBox.shrink(),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  product.name ?? "Unknown",
                                  style: TextHelper.max1.copyWith(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                      onChanged: (selectedId) {
                        if (selectedId == null) {
                          _controller.selectedProduct.value = null;
                        } else {
                          _controller.selectedProduct.value = _controller
                              .products
                              .firstWhereOrNull((p) => p.id == selectedId);
                        }
                        _controller.fetchTransactionReport();
                      },
                    );
                  }),

                  const SizedBox(height: 10),

                  /// DATE FIELDS
                  if (isPending == false)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _controller.selectDate(
                              context,
                              isFromDate: true,
                            ),
                            child: customField(
                              context,
                              hint: "DD/MM/YYYY",
                              controller: _controller.fromDateController,
                              enabled: false,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.arrow_forward,
                            color: theme.colorScheme.onSurface,
                            size: 16,
                          ),
                        ),

                        Expanded(
                          child: GestureDetector(
                            onTap: () => _controller.selectDate(
                              context,
                              isFromDate: false,
                            ),
                            child: customField(
                              context,
                              hint: "DD/MM/YYYY",
                              controller: _controller.toDateController,
                              enabled: false,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 10),

                  /// SEARCH FIELD
                  customField(
                    context,
                    hint: "Search",
                    controller: _controller.searchController,
                    onChanged: _controller.onSearchChanged,
                    onSubmitted: (v) {
                      _controller.fetchTransactionReport();
                    },
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
              child: Obx(() {
                if (_controller.isReportLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_controller.transactions.isEmpty) {
                  return const Center(child: Text("No transactions found"));
                }

                return ListView.builder(
                  itemCount: _controller.transactions.length,
                  itemBuilder: (context, index) {
                    final item = _controller.transactions[index];
                    return TransactionCard(
                      item: item,
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
                );
              }),
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
    TextEditingController? controller,
    bool enabled = true,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
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
            child: TextField(
              controller: controller,
              enabled: enabled,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: TextHelper.max1.copyWith(
                color: theme.brightness == Brightness.dark
                    ? AppColors.textclr
                    : theme.colorScheme.onSurfaceVariant,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintStyle: TextHelper.max1.copyWith(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.textclr
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
