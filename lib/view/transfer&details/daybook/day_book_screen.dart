import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controller/day_book_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:get/get.dart';
import 'day_book_card.dart';

class DayBookScreen extends StatefulWidget {
  const DayBookScreen({super.key});

  @override
  State<DayBookScreen> createState() => _DayBookScreenState();
}

class _DayBookScreenState extends State<DayBookScreen> {
  final DayBookController controller = Get.put(sl<DayBookController>());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Day Book",
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// FILTER CONTAINER
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkplceholder
                    : AppColors.lightbg2,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2.withValues(alpha: .2),
                ),
              ),
              child: Column(
                children: [
                  /// SELECT PRODUCT
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DropdownButtonFormField<int>(
                      value: controller.selectedProduct.value?.id,
                      decoration: InputDecoration(
                        hintText: "Select Product",
                        hintStyle: TextHelper.max1.copyWith(
                          color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                        ),
                        filled: true,
                        fillColor: isDark ? AppColors.darkplceholder : Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
                          ),
                        ),
                      ),
                      items: controller.products.map((product) {
                        return DropdownMenuItem<int>(
                          value: product.id,
                          child: Text(
                            product.name ?? "",
                            style: TextHelper.max1.copyWith(
                              color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          final selected = controller.products.firstWhere((p) => p.id == value);
                          controller.selectProduct(selected);
                        }
                      },
                      dropdownColor: isDark ? AppColors.darkplceholder : Colors.white,
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18.sp,
                        color: theme.colorScheme.onSurface,
                      ),
                    );
                  }),

                  SizedBox(height: 10.h),

                  /// DATE
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Icon(
                          Icons.arrow_forward,
                          color: theme.colorScheme.onSurface,
                          size: 18.sp,
                        ),
                      ),
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

                  SizedBox(height: 10.h),

                  /// SEARCH
                  /// SEARCH
                  _searchField(
                    context,
                    hint: "Search",
                    textController: controller.searchController,
                    isDark: isDark,
                    onSearch: () {
                      controller.fetchDayBookList();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 18.h),

            /// LIST
            Expanded(
              child: Obx(() {
                if (controller.isListLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (controller.dayBookList.isEmpty) {
                  return Center(
                    child: Text(
                      "Data not found",
                      style: TextHelper.max2.copyWith(
                        color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.dayBookList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    final item = controller.dayBookList[index];
                    return Column(
                      children: [
                        DayBookCard(
                          retailerName: item.retailerName ?? "N/A",
                          mobileNo: item.mobileNo ?? "N/A",
                          transactionId: item.transactionId ?? "N/A",
                          transactionType: item.transactionType ?? "N/A",
                          receivedAmount: item.amount ?? "N/A",
                          dateTime: item.dateTime ?? "N/A",
                        ),
                        SizedBox(height: 14.h),
                        SizedBox(
                          width: 120.w,
                          height: 36.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (item.transactionId != null) {
                                // Assuming transactionId is the correct ID to pass for delete,
                                // or item.id if available. The json mapper mapped transactionId to json['id'].
                                controller.deleteDayBook(item.transactionId!);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFDDE2),
                              foregroundColor: const Color(0xFFEE0023),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            child: Text(
                              "Delete",
                              style: TextHelper.max4.copyWith(
                                color: const Color(0xFFEE0023),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
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
          this.controller.fetchDayBookList();
        }
      },
      style: TextHelper.max1.copyWith(
        color: isDark ? AppColors.textclr : AppColors.clrTextblack,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextHelper.max1.copyWith(
          color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
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
        color: isDark ? AppColors.textclr : AppColors.clrTextblack,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextHelper.max1.copyWith(
          color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        isDense: true,
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
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
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
      ),
    );
  }
}