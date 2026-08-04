import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class TransferDetailFilterWidget extends StatefulWidget {
  final String selectedType;
  final ValueChanged<String> onChanged;
  final List<String> transferTypes;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final String? fromDate;
  final String? toDate;
  final ValueChanged<String>? onFromDateChanged;
  final ValueChanged<String>? onToDateChanged;

  const TransferDetailFilterWidget({
    super.key,
    required this.selectedType,
    required this.onChanged,
    required this.transferTypes,
    this.searchController,
    this.onSearchChanged,
    this.fromDate,
    this.toDate,
    this.onFromDateChanged,
    this.onToDateChanged,
  });

  @override
  State<TransferDetailFilterWidget> createState() =>
      _TransferDetailFilterWidgetState();
}

class _TransferDetailFilterWidgetState
    extends State<TransferDetailFilterWidget> {
  Future<void> _pickDate(BuildContext context, bool isFrom) async {
    DateTime initial = DateTime.now();
    try {
      final currentStr = isFrom ? widget.fromDate : widget.toDate;
      if (currentStr != null && currentStr.isNotEmpty) {
        initial = DateFormat('yyyy-MM-dd').parse(currentStr);
      }
    } catch (_) {
      try {
        final currentStr = isFrom ? widget.fromDate : widget.toDate;
        if (currentStr != null && currentStr.isNotEmpty) {
          initial = DateFormat('dd.MM.yyyy').parse(currentStr);
        }
      } catch (_) {}
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      if (isFrom) {
        widget.onFromDateChanged?.call(formatted);
      } else {
        widget.onToDateChanged?.call(formatted);
      }
    }
  }

  String _formatDisplayDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return DateFormat('dd.MM.yyyy').format(DateTime.now());
    }
    try {
      final dt = DateFormat('yyyy-MM-dd').parse(dateStr);
      return DateFormat('dd.MM.yyyy').format(dt);
    } catch (_) {
      return dateStr;
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
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          /// FROM & TO DATE
          Row(
            children: [
              _DateField(
                text: _formatDisplayDate(widget.fromDate),
                onTap: () => _pickDate(context, true),
              ),

              SizedBox(width: 10.w),

              Icon(
                Icons.arrow_forward,
                size: 18.sp,
                color: theme.colorScheme.onSurface,
              ),

              SizedBox(width: 10.w),

              _DateField(
                text: _formatDisplayDate(widget.toDate),
                onTap: () => _pickDate(context, false),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// SEARCH
          TextField(
            controller: widget.searchController,
            onChanged: widget.onSearchChanged,
            style: TextHelper.max9(context),
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextHelper.max1.copyWith(
                color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(12.w),
                child: SvgPicture.asset(
                  AssetImages.search,
                  width: 18.w,
                  height: 18.w,
                  colorFilter: ColorFilter.mode(
                    isDark
                        ? AppColors.textclr
                        : theme.colorScheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              filled: true,
              fillColor: isDark ? AppColors.darkplceholder : Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: AppColors.clrPrimary),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          /// TRANSACTION TYPE
          DropdownButtonFormField<String>(
            initialValue: widget.selectedType.isNotEmpty
                ? widget.selectedType
                : null,
            isExpanded: true,
            hint: Text(
              "Transaction Type",
              style: TextHelper.max9(context).copyWith(
                color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
              ),
            ),
            style: TextHelper.max9(context),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? AppColors.darkplceholder : Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: AppColors.clrPrimary),
              ),
            ),
            items: (() {
              final distinctTypes = <String>[];
              for (final type in widget.transferTypes) {
                if (type.isNotEmpty && !distinctTypes.contains(type)) {
                  distinctTypes.add(type);
                }
              }
              if (widget.selectedType.isNotEmpty &&
                  !distinctTypes.contains(widget.selectedType)) {
                distinctTypes.add(widget.selectedType);
              }
              return distinctTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type, style: TextHelper.max9(context)),
                );
              }).toList();
            })(),
            onChanged: (value) {
              if (value != null) {
                widget.onChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _DateField({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkplceholder : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isDark
                  ? AppColors.darkFilterBorder
                  : AppColors.totalborde2,
            ),
          ),
          child: Text(
            text,
            style: TextHelper.max1.copyWith(
              color: isDark ? Colors.white : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
