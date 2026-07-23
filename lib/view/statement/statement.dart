import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  String? _selectedDescription;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _transactions = List.generate(
    5,
    (index) => {
      'dateTime': '2026-05-20 15:30',
      'description': 'Cashback',
      'transactionId': 'TXN100023498$index',
      'openingBalance': '₹ 1,250.00',
      'credit': '₹ 250.00',
      'debit': '₹ 0.00',
      'closingBalance': '₹ 1,500.00',
    },
  );

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
                GestureDetector(
                  onTap: () {
                    // Logic to show selection
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDescription ?? 'Select Description',
                          style: TextHelper.max1.copyWith(
                            color: isDark
                                ? AppColors.textclr
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: isDark
                              ? AppColors.textclr
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                /// Date Range Fields
                Row(
                  children: [
                    _buildDateField(hint: 'DD.MM.YYYY', isDark: isDark),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF051B44),
                        size: 18.sp,
                      ),
                    ),
                    _buildDateField(hint: 'DD.MM.YYYY', isDark: isDark),
                  ],
                ),
                SizedBox(height: 12.h),

                /// Search Bar
                TextField(
                  controller: _searchController,
                  style: TextStyle(color: theme.colorScheme.onSurface),
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
            child: ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return _buildStatementCard(_transactions[index], isDark, theme);
              },
            ),
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

  Widget _buildDateField({required String hint, required bool isDark}) {
    return Expanded(
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
          hint,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark
                ? AppColors.textclr
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildStatementCard(
    Map<String, String> item,
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
                item['dateTime']!,
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
          _buildCardRow('Description', item['description']!, theme),
          _buildCardRow('Transaction ID', item['transactionId']!, theme),
          _buildCardRow('Opening Balance', item['openingBalance']!, theme),
          _buildCardRow(
            'Credit',
            item['credit']!,
            theme,
            valueColor: Colors.green,
          ),
          _buildCardRow('Debit', item['debit']!, theme, valueColor: Colors.red),
          _buildCardRow(
            'Closing Balance',
            item['closingBalance']!,
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
                    ...item,
                    'product': 'Jio',
                    'dateTime': '11.04.2026 14:32:43',
                    'transactionId': 'TNX46468745',
                    'transactionNo': '9876543120',
                    'openingBalance': '\u{20B9}400.00',
                    'credit': '\u{20B9}5.00',
                    'debit': '0',
                    'closingBalance': '\u{20B9}395.00',
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
                    fontSize: 10.sp,
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
              color:
                  valueColor ??
                  (isBold
                      ? theme.colorScheme.onSurface
                      : Colors.black),
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
