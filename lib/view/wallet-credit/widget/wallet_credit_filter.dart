import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class WalletCreditFilterWidget extends StatelessWidget {
  final WalletController controller;

  const WalletCreditFilterWidget({
    super.key,
    required this.controller,
  });

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
            return DropdownButtonFormField<String>(
              value: controller.selectedCreditTypeName.value,
              isExpanded: true,

              decoration: InputDecoration(
                hintText: "Select Credit Type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              items: controller.walletCreditTypes.map((item) {
                return DropdownMenuItem<String>(
                  value: item.name,
                  child: Text(item.name ?? ""),
                );
              }).toList(),

              onChanged: (value) {
                controller.selectedCreditTypeName.value = value;
                controller.applyFilters();
              },
            );
          }),

          const SizedBox(height: 8),

          /// DATE
          Obx(() => Row(
            children: [
              _DateField(
                hint: controller.fromDate.value.isEmpty ? "DD.MM.YYYY" : controller.fromDate.value,
                style: TextHelper.max1,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    controller.fromDate.value = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                    controller.applyFilters();
                  }
                },
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 16),
              const SizedBox(width: 8),
              _DateField(
                hint: controller.toDate.value.isEmpty ? "DD.MM.YYYY" : controller.toDate.value,
                style: TextHelper.max1,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    controller.toDate.value = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                    controller.applyFilters();
                  }
                },
              ),
            ],
          )),

          const SizedBox(height: 8),

          /// SEARCH
          TextField(
            onChanged: (value) {
              controller.searchQuery.value = value;
            },
            onSubmitted: (value) {
              controller.applyFilters();
            },
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  AssetImages.search,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String hint;
  final TextStyle? style;
  final VoidCallback? onTap;

  const _DateField({
    required this.hint,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            hint,
            style: style,
          ),
        ),
      ),
    );
  }
}