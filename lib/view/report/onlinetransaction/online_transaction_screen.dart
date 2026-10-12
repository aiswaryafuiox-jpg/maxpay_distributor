import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controller/online_transaction_controller.dart';
import 'package:maxpay/view/report/onlinetransaction/widget/online_transaction_card.dart';

class OnlineTransactionScreen extends StatefulWidget {
  const OnlineTransactionScreen({super.key});

  @override
  State<OnlineTransactionScreen> createState() =>
      _OnlineTransactionScreenState();
}

class _OnlineTransactionScreenState extends State<OnlineTransactionScreen> {
  final OnlineTransactionController controller = Get.put(
    sl<OnlineTransactionController>(),
  );
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Online Transaction"),
      body: Column(
        children: [
          /// Filter Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Obx(
              () => CommonFilterBox(
                fromDateText: controller.fromDate.value.isEmpty
                    ? null
                    : controller.fromDate.value,
                toDateText: controller.toDate.value.isEmpty
                    ? null
                    : controller.toDate.value,
                onFromDateTap: () => _selectDate(context, true),
                onToDateTap: () => _selectDate(context, false),
                searchController: _searchController,
                onSearchChanged: (val) {
                  controller.updateSearchQuery(val);
                },
                bottomWidget: TransactionTypeField(
                  value: controller.status.value,
                  onChanged: (val) {
                    if (val != null) {
                      controller.updateStatus(val);
                    }
                  },
                ),
              ),
            ),
          ),

          /// Total Amount Card (Matching Reference Design)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() {
              final amountStr = controller.totalAmount.value.isEmpty
                  ? '0'
                  : controller.totalAmount.value;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Total Amount", style: TextHelper.max16),
                    const SizedBox(height: 4),
                    Text(amountStr.currencyIndian, style: TextHelper.lato12),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          /// Divider below Total Amount card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: isDark
                  ? AppColors.darkFilterBorder
                  : Colors.grey.withValues(alpha: 0.3),
              thickness: 1,
            ),
          ),

          const SizedBox(height: 8),

          /// Transaction List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.items.isEmpty) {
                return const Center(child: Text("Data not found"));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: controller.items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return OnlineTransactionCard(
                    dateTime: item.dateTime ?? "N/A",
                    retailerName: item.retailerName ?? "N/A",
                    mobileNo: item.mobileNo ?? "N/A",
                    amount: "\u{20B9}${item.amount ?? '0.00'}",
                    status: item.status ?? "pending",
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      if (isFromDate) {
        controller.updateDateRange(formattedDate, controller.toDate.value);
      } else {
        controller.updateDateRange(controller.fromDate.value, formattedDate);
      }
    }
  }
}
