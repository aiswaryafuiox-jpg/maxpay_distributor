// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:maxpay/core/constants/asset_images.dart';
// import 'package:maxpay/core/constants/colors.dart';
// import 'package:maxpay/core/utils/texthelper.dart';
//
// class CommonFilterBox extends StatelessWidget {
//   const CommonFilterBox({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkplceholder : AppColors.border,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isDark
//               ? AppColors.darkFilterBorder
//               : Colors.grey.withValues(alpha: 0.1),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               DateField(
//                 hint: "DD.MM.YYYY",
//                 style: TextHelper.max1.copyWith(
//                   color: isDark ? AppColors.textclr : AppColors.darktextclr,
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Icon(
//                 Icons.arrow_forward,
//                 size: 18,
//                 //color: theme.colorScheme.primary,
//                 color: Colors.black,
//               ),
//
//               const SizedBox(width: 8),
//
//               DateField(
//                 hint: "DD.MM.YYYY",
//                 style: TextHelper.max1.copyWith(
//                   color: isDark ? AppColors.textclr : AppColors.darktextclr,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           const SearchBox(),
//         ],
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class CommonFilterBox extends StatelessWidget {
  final Widget? bottomWidget;
  final String? fromDateText;
  final String? toDateText;
  final VoidCallback? onFromDateTap;
  final VoidCallback? onToDateTap;
  final ValueChanged<String>? onSearchChanged;
  final TextEditingController? searchController;

  const CommonFilterBox({
    super.key,
    this.bottomWidget,
    this.fromDateText,
    this.toDateText,
    this.onFromDateTap,
    this.onToDateTap,
    this.onSearchChanged,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.border,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              DateField(
                hint: fromDateText ?? "DD.MM.YYYY",
                onTap: onFromDateTap,
                style: TextHelper.max1.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.darktextclr,
                ),
              ),

              const SizedBox(width: 8),

              const Icon(Icons.arrow_forward, size: 18, color: Colors.black),

              const SizedBox(width: 8),

              DateField(
                hint: toDateText ?? "DD.MM.YYYY",
                onTap: onToDateTap,
                style: TextHelper.max1.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.darktextclr,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const SearchBox(),

          if (bottomWidget != null) ...[
            const SizedBox(height: 10),
            bottomWidget!,
          ],
        ],
      ),
    );
  }
}

class DateField extends StatelessWidget {
  final String hint;
  final TextStyle? style;
  final VoidCallback? onTap;

  const DateField({
    super.key,
    required this.hint,
    required this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkplceholder : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
          ),
        ),
        child: Text(
          hint,
          style:
              style ??
              TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
        ),
      ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchBox({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AssetImages.search,
            colorFilter: ColorFilter.mode(
              isDark ? AppColors.textclr : AppColors.darktextclr,
              BlendMode.srcIn,
            ),
          ),
        ),
        hintText: "Search",
        hintStyle: TextHelper.max1.copyWith(
          color: isDark
              ? AppColors.textclr
              : theme.colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: isDark
            ? AppColors.darkplceholder
            : theme.colorScheme.surface,
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }
}

/// Extra field for Online Transaction screen
class TransactionTypeField extends StatelessWidget {
  const TransactionTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintStyle: TextHelper.max1.copyWith(
          color: isDark
              ? AppColors.textclr
              : theme.colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: isDark
            ? AppColors.darkplceholder
            : theme.colorScheme.surface,
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}
