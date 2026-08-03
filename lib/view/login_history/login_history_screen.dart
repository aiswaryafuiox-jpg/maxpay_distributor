import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/controller/login_history_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/data/model/login_history_model.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class LoginHistoryScreen extends StatefulWidget {
  const LoginHistoryScreen({super.key});

  @override
  State<LoginHistoryScreen> createState() => _LoginHistoryScreenState();
}

class _LoginHistoryScreenState extends State<LoginHistoryScreen> {
  final LoginHistoryController controller = Get.put(sl<LoginHistoryController>());

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      if (isFromDate) {
        controller.fromDate.value = formatted;
      } else {
        controller.toDate.value = formatted;
      }
      controller.fetchLoginHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Login History"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            /// FILTER BOX
            Obx(() => CommonFilterBox(
              fromDateText: controller.fromDate.value.isEmpty ? null : controller.fromDate.value,
              toDateText: controller.toDate.value.isEmpty ? null : controller.toDate.value,
              onFromDateTap: () => _selectDate(context, true),
              onToDateTap: () => _selectDate(context, false),
              searchController: controller.searchController,
              onSearchChanged: controller.onSearchChanged,
            )),

            const SizedBox(height: 16),
            Divider(color: AppColors.darktextclr.withValues(alpha: 0.5)),
            const SizedBox(height: 16),

            /// CARD LIST
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }

                final list = controller.loginHistoryData.value?.list ?? [];

                if (list.isEmpty) {
                  return const Center(child: Text("No login history found."));
                }

                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _LoginHistoryCard(item: list[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// LOGIN HISTORY CARD
class _LoginHistoryCard extends StatelessWidget {
  final LoginHistoryItem item;
  
  const _LoginHistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? const Color(0xFFF6F7FF)
            : const Color(0xFF2F3349),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
      ),
      child: Column(
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(AssetImages.filter),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.location ?? "Unknown",
                        style: TextHelper.max1.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
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
                    item.dateTime ?? item.loginTime ?? "",
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
          const SizedBox(height: 10),
          Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
            thickness: 1,
          ),
          const SizedBox(height: 13),
          /// BOTTOM ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Network",
                    style: TextHelper.max6.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF)
                          : AppColors.clrTextblack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "IP Address",
                    style: TextHelper.max6.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF)
                          : AppColors.clrTextblack,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.network ?? "Unknown",
                    style: TextHelper.max7.copyWith(
                      color: const Color(0xFF314CFF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.ipAddress ?? "Unknown",
                    style: TextHelper.max7.copyWith(
                      color: const Color(0xFF314CFF),
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
