import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controller/my_earnings_controller.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/my_earning/widget/my_earning_widget.dart';

import '../../core/utils/texthelper.dart';

class MyEarningsScreen extends StatefulWidget {
  const MyEarningsScreen({super.key});

  @override
  State<MyEarningsScreen> createState() => _MyEarningsScreenState();
}

class _MyEarningsScreenState extends State<MyEarningsScreen> {
  final MyEarningsController controller = Get.put(sl<MyEarningsController>());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "My Earnings"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkplceholder : AppColors.border,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkFilterBorder : Colors.grey.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _dateField(
                          context,
                          hint: "From Date",
                          controller: controller.fromDateController,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _dateField(
                          context,
                          hint: "To Date",
                          controller: controller.toDateController,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _searchField(
                    context,
                    hint: "Search",
                    textController: controller.searchController,
                    isDark: isDark,
                    onSearch: () {
                      controller.fetchMyEarnings();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Divider(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.5),
            ),

            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.clrPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Total Earnings", style: TextHelper.max16),
                  SizedBox(height: 4),
                  Obx(() => Text(
                    "₹ ${controller.totalEarnings.value}", 
                    style: TextHelper.lato12,
                  )),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.earningsList.isEmpty) {
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

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.earningsList.length,
                itemBuilder: (context, index) {
                  final item = controller.earningsList[index];
                  return EarningsCard(
                    transactionNo: item.transactionNo ?? "N/A",
                    dateTime: item.dateTime ?? "N/A",
                    productName: item.productName ?? "",
                    productType: item.productType ?? "N/A",
                    productLogo: item.productLogo ?? "",
                    transactionAmount: item.transactionAmount ?? "0",
                    myEarnings: item.myEarnings ?? "0",
                  );
                },
              );
            }),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _dateField(
    BuildContext context, {
    required String hint,
    required TextEditingController controller,
    required bool isDark,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          // Format as YYYY-MM-DD
          controller.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
          this.controller.fetchMyEarnings();
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
