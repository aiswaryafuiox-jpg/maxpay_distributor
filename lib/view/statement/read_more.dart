import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class StatementReadMoreScreen extends StatelessWidget {
  const StatementReadMoreScreen({super.key, this.details});

  final Map<String, String>? details;

  Map<String, String> get _data {
    return {
      'product': 'Jio',
      'description': 'Cashback',
      'dateTime': '11.04.2026 14:32:43',
      'transactionId': 'TNX46468745',
      'transactionNo': '9876543120',
      'openingBalance': '\u{20B9}400.00',
      'credit': '\u{20B9}5.00',
      'debit': '0',
      'closingBalance': '\u{20B9}395.00',
      ...?details,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final data = _data;

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
        child: Padding(
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
                  value: data['product']!,
                  trailing: _ProductBadge(text: data['product']!),
                ),
                _DetailRow(label: 'Description', value: data['description']!),
                _DetailRow(label: 'Date & Time', value: data['dateTime']!),
                _DetailRow(
                  label: 'Transaction ID',
                  value: data['transactionId']!,
                ),
                _DetailRow(
                  label: 'Transaction no',
                  value: data['transactionNo']!,
                ),
                _DetailRow(
                  label: 'Opening Balance',
                  value: data['openingBalance']!,
                ),
                _DetailRow(
                  label: 'Credit',
                  value: data['credit']!,
                  valueColor: const Color(0xFF00B050),
                ),
                _DetailRow(
                  label: 'Debit',
                  value: data['debit']!,
                  valueColor: Colors.red,
                ),
                _DetailRow(
                  label: 'Closing Balance',
                  value: data['closingBalance']!,
                ),
              ],
            ),
          ),
        ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextHelper.max1.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing ??
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
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
      height: 22.r,
      width: 22.r,
      decoration: const BoxDecoration(
        color: Color(0xFFE50914),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextHelper.max1.copyWith(
          color: Colors.white,
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
