import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/controller/wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class WalletCreditFilterWidget extends StatelessWidget {
  final WalletController controller;

  const WalletCreditFilterWidget({super.key, required this.controller});

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime now = DateTime.now();
    DateTime initial = now;
    try {
      final currentStr = isFromDate
          ? controller.fromDate.value
          : controller.toDate.value;
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
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          /// Dropdown
          Obx(() {
            return DropdownButtonFormField<String?>(
              initialValue: controller.selectedCreditTypeId.value,
              isExpanded: true,
              style: TextHelper.max1.copyWith(fontSize: 14),
              decoration: InputDecoration(
                hintText: "Select Credit Type",
                hintStyle: TextHelper.max1.copyWith(fontSize: 12),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkFilterBorder
                        : Colors.grey.withValues(alpha: 0.4),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkFilterBorder
                        : Colors.grey.withValues(alpha: 0.4),
                  ),
                ),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text("All Credit Types"),
                ),
                ...controller.walletCreditTypes.map((item) {
                  return DropdownMenuItem<String?>(
                    value: item.name,
                    child: Text(item.name ?? ""),
                  );
                }),
              ],
              onChanged: (value) {
                controller.updateSelectedType(value);
              },
            );
          }),

          const SizedBox(height: 8),

          /// DATE
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => _DateField(
                    text: controller.fromDate.value.isEmpty
                        ? "DD.MM.YYYY"
                        : controller.fromDate.value,
                    style: TextHelper.max1,
                    onTap: () => _selectDate(context, true),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(
                  () => _DateField(
                    text: controller.toDate.value.isEmpty
                        ? "DD.MM.YYYY"
                        : controller.toDate.value,
                    style: TextHelper.max1,
                    onTap: () => _selectDate(context, false),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// SEARCH
          TextField(
            controller: controller.searchController,
            onChanged: controller.onSearchChanged,
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              prefixIcon: FittedBox(
                fit: .scaleDown,
                child: SvgPicture.asset(
                  AssetImages.search,
                  height: 20,
                  width: 12,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkFilterBorder
                      : Colors.grey.withValues(alpha: 0.4),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkFilterBorder
                      : Colors.grey.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback onTap;

  const _DateField({required this.text, this.style, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkFilterBorder
                : Colors.grey.withValues(alpha: 0.4),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: style),
            const Icon(Icons.calendar_today, size: 14),
          ],
        ),
      ),
    );
  }
}
