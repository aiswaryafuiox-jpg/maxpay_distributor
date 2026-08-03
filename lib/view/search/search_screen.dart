import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/search_transaction_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/data/model/transaction/transaction_report_response_model.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchTransactionController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<SearchTransactionController>()
        ? Get.find<SearchTransactionController>()
        : Get.put(sl<SearchTransactionController>());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Search"),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔍 SEARCH INPUT BOX
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkplceholder : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkFilterBorder
                        : AppColors.totalborde2.withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AssetImages.search,
                      width: 18.w,
                      height: 18.w,
                      colorFilter: ColorFilter.mode(
                        isDark ? AppColors.textclr : const Color(0xFF94A3B8),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: controller.searchController,
                        onChanged: controller.onSearchChanged,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : AppColors.clrTextblack,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search.....",
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark
                                ? AppColors.textclr
                                : const Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.searchQuery.value.isNotEmpty) {
                        return GestureDetector(
                          onTap: controller.clearSearch,
                          child: Icon(
                            Icons.close_rounded,
                            size: 18.sp,
                            color: isDark ? Colors.white70 : Colors.grey,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ),

            /// ➖ DIVIDER
            Divider(
              height: 1,
              thickness: 1,
              color: isDark
                  ? AppColors.darkFilterBorder
                  : const Color(0xFFE2E8F0).withValues(alpha: 0.7),
            ),

            /// 📜 TRANSACTION LIST
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.transactions.isEmpty) {
                  return Center(
                    child: Text(
                      "No transactions found",
                      style: TextHelper.max1.copyWith(
                        color: isDark
                            ? AppColors.textclr
                            : AppColors.clrTextgrey,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: controller.transactions.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = controller.transactions[index];
                    return _buildTransactionCard(context, item, isDark);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(
    BuildContext context,
    TransactionReportItem item,
    bool isDark,
  ) {
    final status = (item.status ?? 'Success').toLowerCase();
    Color statusBgColor;
    String statusText;

    if (status == 'success') {
      statusBgColor = const Color(0xFF22C55E); // Green
      statusText = "Success";
    } else if (status == 'pending') {
      statusBgColor = const Color(0xFFF97316); // Orange
      statusText = "Pending";
    } else {
      statusBgColor = const Color(0xFFEF4444); // Red
      statusText = "Failed";
    }

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : const Color(0xFFF9FAFD),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.darkFilterBorder : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW: Date & Time + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Date & Time:  ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? AppColors.textclr
                          : const Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    item.dateTime ?? "29-11-2026 07:38:43PM",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),

              /// Status Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(
              height: 1,
              thickness: 0.6,
              color: isDark
                  ? AppColors.darkFilterBorder
                  : const Color(0xFFE2E8F0),
            ),
          ),

          /// BOTTOM ROW: Logo + Details + Amount
          Row(
            children: [
              /// Operator Logo
              Container(
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                child:
                    (item.productLogo != null && item.productLogo!.isNotEmpty)
                    ? Image.network(
                        item.productLogo!,
                        width: 38.w,
                        height: 38.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _defaultLogo(),
                      )
                    : _defaultLogo(),
              ),

              SizedBox(width: 12.w),

              /// Middle Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName ?? "Prepaid",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Transaction No: ${item.transactionId ?? '9865647823'}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Provider Ref ID : ${item.mobileFull ?? (item.mobile != null ? '#${item.mobile}' : '#9876543')}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),

              /// Amount
              Text(
                "₹ ${item.amount ?? '365'}",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _defaultLogo() {
    return SvgPicture.asset(
      AssetImages.jio,
      width: 38.w,
      height: 38.w,
      fit: BoxFit.contain,
    );
  }
}
