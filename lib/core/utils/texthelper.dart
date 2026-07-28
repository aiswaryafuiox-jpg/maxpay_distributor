import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';

class TextHelper {
  static TextStyle get max1 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.clrTextgrey,
    );
  }

  static TextStyle get max2 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.clrTextgrey,
    );
  }

  static TextStyle get max3 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: AppColors.clrSecondary,
    );
  }

  static TextStyle get max4 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.clrTextblack,
    );
  }

  static TextStyle get max5 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.clrPrimary,
    );
  }

  static TextStyle get max6 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.clrTextblack,
    );
  }

  static TextStyle get max7 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.clrSecondary,
    );
  }

  static TextStyle get pin {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.pinText,
    );
  }

  static TextStyle get max8 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.clrTextblack,
    );
  }

  static TextStyle get max16 {
    return const TextStyle(
      fontFamily: 'Poppins',

      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
  }

  static TextStyle max9(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',

      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle max10(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',

      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle max11(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',

      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
    );
  }

  static TextStyle max12(BuildContext context) {
    final theme = Theme.of(context);

    return TextStyle(
      fontFamily: 'Poppins',

      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: theme.brightness == Brightness.light
          ? AppColors.darktextclr
          : AppColors.textclr,
    );
  }

  static TextStyle max13(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',

      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle lat014(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lato', /////////

      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle max14(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',

      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle get lato14 {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.clrTextblack,
    );
  }

  static TextStyle get lato11 {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.clrTextblack,
    );
  }

  static TextStyle get lato12 {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
  }
}
