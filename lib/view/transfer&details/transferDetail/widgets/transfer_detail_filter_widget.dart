import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
class TransferDetailFilterWidget extends StatefulWidget {
  final String selectedType;
  final ValueChanged<String> onChanged;

  const TransferDetailFilterWidget({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  State<TransferDetailFilterWidget> createState() =>
      _TransferDetailFilterWidgetState();
}


class _TransferDetailFilterWidgetState
    extends State<TransferDetailFilterWidget> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : AppColors.lightbg2,
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
              const _DateField(hint: "DD.MM.YYYY"),

              SizedBox(width: 10.w),

              Icon(
                Icons.arrow_forward,
                size: 18.sp,
                color: theme.colorScheme.onSurface,
              ),

              SizedBox(width: 10.w),

              const _DateField(hint: "DD.MM.YYYY"),
            ],
          ),

          SizedBox(height: 10.h),

          /// SEARCH
          TextField(
            style: TextHelper.max9(context),
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextHelper.max1.copyWith(
                color: isDark
                    ? AppColors.textclr
                    : AppColors.clrTextgrey,
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
              fillColor: isDark
                  ? AppColors.darkplceholder
                  : Colors.white,
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
                borderSide: const BorderSide(
                  color: AppColors.clrPrimary,
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          /// TRANSACTION TYPE
          DropdownButtonFormField<String>(
            initialValue: widget.selectedType,            isExpanded: true,

            hint: Text(
              "Transaction Type",
              style: TextHelper.max9(context).copyWith(
                color: isDark
                    ? AppColors.textclr
                    : AppColors.clrTextgrey,
              ),
            ),

            style: TextHelper.max9(context),

            decoration: InputDecoration(
              filled: true,
              fillColor: isDark
                  ? AppColors.darkplceholder
                  : Colors.white,

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
                borderSide: const BorderSide(
                  color: AppColors.clrPrimary,
                ),
              ),
            ),

            items: [
              DropdownMenuItem(
                value: "Reverse",
                child: Text(
                  "Reverse",
                  style: TextHelper.max9(context),
                ),
              ),
              DropdownMenuItem(
                value: "Transfer",
                child: Text(
                  "Transfer",
                  style: TextHelper.max9(context),
                ),
              ),
            ],

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
  final String hint;

  const _DateField({
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkplceholder
              : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isDark
                ? AppColors.darkFilterBorder
                : AppColors.totalborde2,
          ),
        ),
        child: Text(
          hint,
          style: TextHelper.max1.copyWith(
            color: isDark
                ? AppColors.textclr
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}