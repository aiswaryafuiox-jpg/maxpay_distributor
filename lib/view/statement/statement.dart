
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/controller/statement_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/data/model/statement/statement_list_model.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:intl/intl.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  final StatementController controller = Get.put(sl<StatementController>());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Statement"),
      body: Column(
        children: [
          /// 🔹 Filter Section
          Container(
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
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
                /// Description Selector
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkplceholder : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkFilterBorder
                          : Colors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedDescription.value,
                      hint: Text(
                        'Select Description',
                        style: TextHelper.max1.copyWith(
                          color: isDark
                              ? AppColors.textclr
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 24.sp,
                        color: isDark
                            ? AppColors.textclr
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      dropdownColor: isDark ? AppColors.darkplceholder : Colors.white,
                      items: controller.descriptions.map((desc) {
                        return DropdownMenuItem<String>(
                          value: desc.name,
                          child: Text(
                            desc.name ?? "",
                            style: TextHelper.max1.copyWith(
                              color: isDark
                                  ? AppColors.textclr
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectDescription(value);
                      },
                    ),
                  ),
                )),
                SizedBox(height: 12.h),

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
                  onSubmitted: (value) => controller.updateSearchQuery(value),
                  decoration: _getInputDecoration(
                    hint: 'Search',
                    isDark: isDark,
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
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 8.h),

          /// 🔹 Statement List
          Expanded(
            child: Obx(() {
              if (controller.isListLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.transactions.isEmpty) {
                return const Center(child: Text("Data not found"));
              }
              return ListView.builder(
                padding: EdgeInsets.all(16.r),
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  return _buildStatementCard(controller.transactions[index], isDark, theme);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration({
    required String hint,
    required bool isDark,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefixIcon,
      hintStyle: TextHelper.max1.copyWith(
        color: isDark
            ? AppColors.textclr
            : Theme.of(context).colorScheme.onSurfaceVariant,
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

  Widget _buildStatementCard(
    StatementItem item,
    bool isDark,
    ThemeData theme,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            :  Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time:",
                style: TextHelper.max1.copyWith(
                color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                ),
              ),
              Text(
                item.dateTime ?? "N/A",
                style: TextHelper.max1.copyWith(
                  color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
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
          _buildCardRow('Description', item.description ?? "N/A", theme),
          _buildCardRow('Transaction ID', item.transactionId ?? "N/A", theme),
          _buildCardRow('Opening Balance', "\u{20B9}${item.openingBalance ?? '0.00'}", theme),
          _buildCardRow(
            'Credit',
            "\u{20B9}${item.credit ?? '0.00'}",
            theme,
            valueColor: Colors.green,
          ),
          _buildCardRow('Debit', "\u{20B9}${item.debit ?? '0.00'}", theme, valueColor: Colors.red),
          _buildCardRow(
            'Closing Balance',
            "\u{20B9}${item.closingBalance ?? '0.00'}",
            theme,
            isBold: true,
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.statementReadMore,
                  arguments: {
                    'id': item.id,
                  },
                );
              },
              borderRadius: BorderRadius.circular(4.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.clrPrimary
                      : AppColors.lightbg,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Read More',
                  style: TextHelper.max1.copyWith(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
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
   // color: isDark
   //                     ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)

}

