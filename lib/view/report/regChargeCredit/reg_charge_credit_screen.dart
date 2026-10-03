import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controller/reg_charge_controller.dart';
import 'package:maxpay/data/model/report/reg_charge_detail_model.dart';

class RegChargeCreditScreen extends StatefulWidget {
  const RegChargeCreditScreen({super.key});

  @override
  State<RegChargeCreditScreen> createState() => _RegChargeCreditScreenState();
}

class _RegChargeCreditScreenState extends State<RegChargeCreditScreen> {
  final RegChargeController controller = Get.put(sl<RegChargeController>());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Reg. Charge Credit"),
      body: Column(
        children: [
          /// 🔹 Filter Section
          Container(
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isDark
                    ? AppColors.darkFilterBorder
                    : theme.colorScheme.outline.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              children: [
                /// Date Range Fields
                Obx(() => Row(
                  children: [
                    _buildDateField(
                      hint: 'DD.MM.YYYY',
                      isDark: isDark,
                      dateValue: controller.fromDate.value,
                      onTap: () => _selectDate(context, true),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF051B44),
                        size: 18.sp,
                      ),
                    ),
                    _buildDateField(
                      hint: 'DD.MM.YYYY',
                      isDark: isDark,
                      dateValue: controller.toDate.value,
                      onTap: () => _selectDate(context, false),
                    ),
                  ],
                )),
                SizedBox(height: 12.h),

                /// Search Bar
                TextField(
                  controller: _searchController,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  onChanged: (value) => controller.updateSearchQuery(value),
                  onSubmitted: (value) => controller.updateSearchQuery(value),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextHelper.max1.copyWith(
                      color: isDark
                          ? AppColors.textclr
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: SvgPicture.asset(
                        AssetImages.search,
                        colorFilter: ColorFilter.mode(
                          isDark
                              ? AppColors.textclr
                              : theme.colorScheme.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                        height: 18.sp,
                      ),
                    ),
                    filled: true,
                    fillColor: isDark ? AppColors.darkplceholder : Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.clrPrimary, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Summary Cards
          Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Distributor Comm.',
                    amount: controller.totalDistributorCommission.value.toStringAsFixed(2),
                    isDark: isDark,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Executive Comm.',
                    amount: controller.totalExecutiveCommission.value.toStringAsFixed(2),
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          )),
          
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 8.h),

          /// 🔹 List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.items.isEmpty) {
                return const Center(child: Text("Data not found"));
              }
              return ListView.builder(
                padding: EdgeInsets.all(16.r),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return _buildItemCard(controller.items[index], isDark, theme);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({required String title, required String amount, required bool isDark}) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.clrPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.clrPrimary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextHelper.max1.copyWith(
              color: isDark ? Colors.white70 : AppColors.clrTextgrey,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "\u{20B9}$amount",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.clrPrimary,
            ),
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

  Widget _buildDateField({
    required String hint,
    required bool isDark,
    required String dateValue,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkplceholder : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isDark
                  ? AppColors.darkFilterBorder
                  : Colors.grey.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            dateValue.isNotEmpty ? dateValue : hint,
            style: TextStyle(
              fontSize: 12.sp,
              color: dateValue.isNotEmpty 
                  ? (isDark ? AppColors.textclr : Theme.of(context).colorScheme.onSurface)
                  : (isDark ? AppColors.textclr : Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(RegChargeDetailItem item, bool isDark, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : const Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time:",
                style: TextHelper.max1.copyWith(
                  color: isDark ? Colors.white70 : AppColors.darktextclr,
                ),
              ),
              Text(
                item.createdAt ?? "N/A",
                style: TextHelper.max1.copyWith(
                  color: isDark ? Colors.white70 : AppColors.darktextclr,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          _buildCardRow('Retailer Name', item.retailerName ?? "N/A", theme),
          _buildCardRow('Charge Amount', "\u{20B9}${item.amount ?? '0.00'}", theme),
          _buildCardRow(
            'Commission', 
            "\u{20B9}${item.commission ?? '0.00'}", 
            theme, 
            valueColor: Colors.green,
            isBold: true,
          ),
          if (item.status != null)
            _buildCardRow('Status', item.status!, theme, isBold: true),
        ],
      ),
    );
  }

  Widget _buildCardRow(
    String label,
    String value,
    ThemeData theme, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextHelper.max6.copyWith(color: theme.colorScheme.onSurface),
          ),
          Text(
            value,
            style: TextHelper.max7.copyWith(
              color: valueColor ?? theme.colorScheme.onSurface,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}