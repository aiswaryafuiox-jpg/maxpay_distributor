import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme Controller to handle persistence
class ThemeController extends GetxController {
  final SharedPreferences _prefs;
  static const _themeKey = 'app_theme_mode';

  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  ThemeController(this._prefs) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeIndex = _prefs.getInt(_themeKey);
    if (themeIndex != null) {
      _themeMode.value = ThemeMode.values[themeIndex];
      Get.changeThemeMode(_themeMode.value);
    }
  }

  void toggleTheme() {
    _themeMode.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _prefs.setInt(_themeKey, _themeMode.value.index);
    Get.changeThemeMode(_themeMode.value);
  }

  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;
    _prefs.setInt(_themeKey, mode.index);
    Get.changeThemeMode(mode);
  }
}

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.clrPrimary,
    scaffoldBackgroundColor: AppColors.clrBg,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.light(
      primary: AppColors.clrPrimary,
      secondary: AppColors.clrSecondary,
      surface: AppColors.clrBg,
      onSurface: AppColors.clrTextblack,
      onSurfaceVariant: AppColors.clrTextgrey,
      surfaceContainer: AppColors.darkbgBlack,
      outline: AppColors.clrTextgrey,
      surfaceBright: AppColors.clrplceholder,
      onTertiaryFixedVariant: AppColors.darktextclr,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.clrBg,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.clrTextblack),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.clrTextblack),
      bodyLarge: TextStyle(color: AppColors.clrTextblack),
      bodyMedium: TextStyle(color: AppColors.clrTextblack),
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.clrPrimary,
    scaffoldBackgroundColor: AppColors.darkbgBlack,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.clrPrimary,
      secondary: AppColors.clrPrimary,
      surface: AppColors.darkbgBlack,
      surfaceContainer: AppColors.darkbgBlack,
      onSurface: AppColors.clrBg,
      onSurfaceVariant: AppColors.clrTextgrey,
      onTertiaryFixedVariant: AppColors.textclr,
      outline: AppColors.clrplceholder,
      surfaceBright: AppColors.darkplceholder,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkbgBlack,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.clrBg),
      bodyLarge: TextStyle(color: AppColors.clrBg),
      bodyMedium: TextStyle(color: AppColors.clrBg),
    ),
  );
}
