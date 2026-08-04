import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controller/statement_read_more_controller.dart';

class StatementReadMoreScreen extends StatelessWidget {
  StatementReadMoreScreen({super.key});

  final StatementReadMoreController controller = Get.put(
    sl<StatementReadMoreController>(),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18.sp,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.statementDetail.value;
          if (data == null) {
            return Center(
              child: Text(
                "Statement detail not found.",
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.fromLTRB(31.w, 24.h, 31.w, 24.h),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkplceholder : AppColors.background,
                borderRadius: BorderRadius.circular(7.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DetailRow(
                    label: 'Product',
                    value: data.product ?? 'N/A',
                    trailing: data.product != "-"
                        ? _ProductBadge(text: data.product ?? 'N/A')
                        : null,
                  ),
                  _DetailRow(
                    label: 'Description',
                    value: data.description ?? 'N/A',
                  ),
                  _DetailRow(
                    label: 'Date & Time',
                    value: formatTransactionDate(data.dateTime ?? ''),
                  ),
                  _DetailRow(
                    label: 'Transaction ID',
                    value: data.transactionId ?? 'N/A',
                  ),
                  _DetailRow(
                    label: 'Transaction no',
                    value: data.transactionNo ?? 'N/A',
                  ),
                  _DetailRow(
                    label: 'Opening Balance',
                    value: "\u{20B9}${data.openingBalance ?? '0.00'}",
                  ),
                  _DetailRow(
                    label: 'Credit',
                    value: "\u{20B9}${data.credit ?? '0.00'}",
                    valueColor: const Color(0xFF00B050),
                  ),
                  _DetailRow(
                    label: 'Debit',
                    value: "\u{20B9}${data.debit ?? '0.00'}",
                    valueColor: Colors.red,
                  ),
                  _DetailRow(
                    label: 'Closing Balance',
                    value: "\u{20B9}${data.closingBalance ?? '0.00'}",
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.trailing,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextHelper.max1.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 8.w),
          trailing ??
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextHelper.max1.copyWith(
                    color: valueColor ?? theme.colorScheme.onSurface,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _ProductBadge extends StatelessWidget {
  const _ProductBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.r,
      width: 30.r,
      decoration: const BoxDecoration(
        color: Color(0xFFE50914),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text.isNotEmpty ? text[0].toUpperCase() : '?',
        style: TextHelper.max1.copyWith(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
