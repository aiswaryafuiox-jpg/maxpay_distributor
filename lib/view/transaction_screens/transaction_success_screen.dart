import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controller/transaction_controller.dart';
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
  final TransactionController controller = Get.put(sl<TransactionController>());

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
            if (isSuccess)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.light ? AppColors.border : AppColors.darkplceholder,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.brightness == Brightness.light ? AppColors.totalborde2.withValues(alpha: 0.1) : AppColors.darkFilterBorder,
                  ),
                ),
                child: Column(
                  children: [
                    /// SELECT CREDIT TYPE
                    Obx(() {
                      return DropdownButtonFormField<String>(
                        value: controller.selectedProductId.value.isEmpty ? null : controller.selectedProductId.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.brightness == Brightness.light ? Colors.white : AppColors.darkplceholder,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: theme.brightness == Brightness.light ? AppColors.darktextclr.withValues(alpha: 0.3) : AppColors.darkFilterBorder,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: theme.brightness == Brightness.light ? AppColors.darktextclr.withValues(alpha: 0.3) : AppColors.darkFilterBorder,
                            ),
                          ),
                        ),
                        hint: Text(
                          "Select Product",
                          style: TextHelper.max1.copyWith(
                            color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                          ),
                        ),
                        items: controller.productList.map((product) {
                          return DropdownMenuItem<String>(
                            value: product.id?.toString() ?? "",
                            child: Text(
                              product.name ?? "Unknown",
                              style: TextHelper.max1.copyWith(
                                color: isDark ? AppColors.textclr : AppColors.darktextclr,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedProductId.value = value;
                            controller.fetchTransactionSuccessReport();
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 10),
                    /// DATE FIELD
                    Row(
                      children: [
                        Expanded(
                          child: _dateField(
                            context,
                            hint: "From Date",
                            textController: controller.fromDateController,
                            isDark: isDark,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.arrow_forward, color: theme.colorScheme.onSurface),
                        ),
                        Expanded(
                          child: _dateField(
                            context,
                            hint: "To Date",
                            textController: controller.toDateController,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    /// SEARCH FIELD
                    _searchField(
                      context,
                      hint: "Search",
                      textController: controller.searchController,
                      isDark: isDark,
                      onSearch: () {
                        controller.fetchTransactionSuccessReport();
                      },
                    ),
                  ],
                ),
              ),

            if (isSuccess) const SizedBox(height: 16),

            if (isSuccess)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Total Transactions", style: TextHelper.max16),
                        const SizedBox(height: 4),
                        Text(controller.totalTransaction.value, style: TextHelper.lato12),
                      ],
                    ),
                    Container(height: 40, width: 1, color: Colors.white.withValues(alpha: 0.5)),
                    Column(
                      children: [
                        Text("Total Profit", style: TextHelper.max16),
                        const SizedBox(height: 4),
                        Text("₹ ${controller.totalProfit.value}", style: TextHelper.lato12),
                      ],
                    ),
                  ],
                )),
              ),

            const SizedBox(height: 15),

            /// TRANSACTION LIST
            Expanded(
              child: Obx(() {
                if (isSuccess && controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (isSuccess && controller.transactionList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Text(
                        "Data not found",
                        style: TextHelper.max2.copyWith(
                          color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                        ),
                      ),
                    ),
                  );
                }

                int itemCount = isSuccess ? controller.transactionList.length : 5;

                return ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (isSuccess) {
                      final item = controller.transactionList[index];
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
                        transactionId: item.transactionNo ?? "N/A",
                        dateTime: item.dateTime ?? "N/A",
                        productName: item.productName ?? "Unknown",
                        productLogo: item.productLogo ?? "",
                        amount: item.amount ?? "0",
                        number: item.transactionNo ?? "N/A",
                        profit: item.commission?.profit ?? "0",
                      );
                    } else {
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
                        transactionId: "TXN6453564",
                        dateTime: "29-11-2026 07:38:43 PM",
                        productName: "Jio",
                        productLogo: "",
                        amount: "365.00",
                        number: "******7823",
                        profit: "0",
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField(
    BuildContext context, {
    required String hint,
    required TextEditingController textController,
    required bool isDark,
  }) {
    return TextFormField(
      controller: textController,
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          textController.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
          if (widget.status == TransactionStatus.success) {
            controller.fetchTransactionSuccessReport();
          }
        }
      },
      style: TextHelper.max1.copyWith(
        color: isDark ? AppColors.textclr : AppColors.darktextclr,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextHelper.max1.copyWith(
          color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
      ),
    );
  }

  Widget _searchField(
    BuildContext context, {
    required String hint,
    required TextEditingController textController,
    required bool isDark,
    required VoidCallback onSearch,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: textController,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (_) => onSearch(),
      style: TextHelper.max1.copyWith(
        color: isDark ? AppColors.textclr : AppColors.darktextclr,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextHelper.max1.copyWith(
          color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AssetImages.search,
            colorFilter: ColorFilter.mode(
              isDark ? AppColors.textclr : theme.colorScheme.onSurfaceVariant,
              BlendMode.srcIn,
            ),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: isDark ? AppColors.textclr : theme.colorScheme.onSurfaceVariant,
          ),
          onPressed: onSearch,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
      ),
    );
  }
}
