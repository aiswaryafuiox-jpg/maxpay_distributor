import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/controller/my_earnings_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/my_earning/widget/my_earning_widget.dart';

class MyEarningsScreen extends StatefulWidget {
  const MyEarningsScreen({super.key});

  @override
  State<MyEarningsScreen> createState() => _MyEarningsScreenState();
}

class _MyEarningsScreenState extends State<MyEarningsScreen> {
  late final MyEarningsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<MyEarningsController>()
        ? Get.find<MyEarningsController>()
        : Get.put(sl<MyEarningsController>());
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime now = DateTime.now();
    DateTime initial = now;
    try {
      final currentStr =
          isFromDate ? controller.fromDate.value : controller.toDate.value;
      if (currentStr.isNotEmpty) {
        initial = DateFormat('yyyy-MM-dd').parse(currentStr);
      }
    } catch (_) {}

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "My Earnings"),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchMyEarnings();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              /// 🔹 Filter Box
              Obx(
                () => CommonFilterBox(
                  fromDateText: controller.fromDate.value.isEmpty
                      ? "DD.MM.YYYY"
                      : controller.fromDate.value,
                  toDateText: controller.toDate.value.isEmpty
                      ? "DD.MM.YYYY"
                      : controller.toDate.value,
                  onFromDateTap: () => _selectDate(context, true),
                  onToDateTap: () => _selectDate(context, false),
                  searchController: controller.searchController,
                  onSearchChanged: controller.onSearchChanged,
                ),
              ),

              const SizedBox(height: 16),

              Divider(
                color: theme.colorScheme.outline.withValues(alpha: 0.5),
              ),

              const SizedBox(height: 16),

              /// 🔹 Total Earnings Card
              Obx(
                () => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text("Total Earnings", style: TextHelper.max16),
                      const SizedBox(height: 4),
                      Text(
                        "₹ ${controller.totalEarnings.value}",
                        style: TextHelper.lato12,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 Earnings List
              Obx(() {
                if (controller.isLoading.value &&
                    controller.earningsList.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.earningsList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "No earnings found",
                            style: TextStyle(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.earningsList.length,
                  itemBuilder: (context, index) {
                    final item = controller.earningsList[index];
                    return EarningsCard(item: item);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
