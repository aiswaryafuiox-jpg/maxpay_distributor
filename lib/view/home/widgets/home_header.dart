import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ionicons/flutter_ionicons.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/image_loader.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/date_uttils.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/controller/profile_controller.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isTablet = Responsive.isTablet(context);

    return Obx(() {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final isDark = themeController.isDarkMode;

      final profileController = Get.find<ProfileController>();
      final profileData = profileController.profileData.value;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                /// LEFT SIDE
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.red.withValues(alpha: 0.2),
                          child: NetworkImageWithLoader(
                            profileData?.profileImg ?? '',
                            radius: 20,
                            errorWidget: Text(
                              (profileData?.name != null &&
                                      profileData!.name!.isNotEmpty)
                                  ? profileData.name![0].toUpperCase()
                                  : 'M',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppColors.clrPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),

                        SizedBox(width: 10.w),

                        /// NAME & GREETING
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateTimeFormater.getGreeting(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: colorScheme.onSurface,
                                ),
                              ),

                              Text(
                                profileData?.name ?? 'Loading...',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 4.w),

                /// RIGHT SIDE
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// SEARCH
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.search_outline,
                        size: isTablet ? 32.sp : 25.sp,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    /// NOTIFICATION
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Ionicons.notifications_outline,
                            size: isTablet ? 32.sp : 25.sp,
                            color: colorScheme.onSurface,
                          ),

                          Positioned(
                            right: 3,
                            top: 2,
                            child: FadeIn(
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                padding: EdgeInsets.all(1.r),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    width: 1.5,
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 10.w,
                                  minHeight: 10.h,
                                ),
                                // child: Center(
                                //   child: Text(
                                //     "99",
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 7.sp,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //     textAlign: TextAlign.center,
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    /// THEME SWITCH
                    GestureDetector(
                      onTap: () {
                        themeController.toggleTheme();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        width: isTablet ? 76.w : 68.w,
                        height: isTablet ? 32.h : 34.h,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1E1E2D),
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.10),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.fastOutSlowIn,
                              alignment: isDark
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.all(3.r),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  width: isTablet ? 34.w : 28.w,
                                  height: isTablet ? 34.w : 28.w,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1E1E2D)
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.15,
                                        ),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      child: Icon(
                                        isDark
                                            ? Icons.nightlight_round
                                            : Icons.wb_sunny_rounded,
                                        key: ValueKey(isDark),
                                        size: 14.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            AnimatedAlign(
                              duration: const Duration(milliseconds: 400),
                              alignment: isDark
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Icon(
                                  isDark
                                      ? Icons.wb_sunny_rounded
                                      : Icons.nightlight_round,
                                  size: 13.sp,
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.4)
                                      : Colors.white.withValues(alpha: 0.4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _ThemeToggleButton extends StatefulWidget {
  const _ThemeToggleButton({
    required this.isDark,
    required this.isTablet,
    required this.onChanged,
  });

  final bool isDark;
  final bool isTablet;
  final ValueChanged<bool> onChanged;

  @override
  State<_ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<_ThemeToggleButton> {
  static const _duration = Duration(milliseconds: 420);
  static const _themeApplyDelay = Duration(milliseconds: 140);

  late bool _isDark = widget.isDark;
  Timer? _themeApplyTimer;

  @override
  void didUpdateWidget(covariant _ThemeToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDark != oldWidget.isDark && widget.isDark != _isDark) {
      _isDark = widget.isDark;
    }
  }

  @override
  void dispose() {
    _themeApplyTimer?.cancel();
    super.dispose();
  }

  void _handleTap() {
    _themeApplyTimer?.cancel();
    setState(() {
      _isDark = !_isDark;
    });

    _themeApplyTimer = Timer(_themeApplyDelay, () {
      if (!mounted) {
        return;
      }

      widget.onChanged(_isDark);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.isTablet ? 86.w : 68.w;
    final height = widget.isTablet ? 42.h : 34.h;
    final padding = 3.r;
    final thumbSize = widget.isTablet ? 34.w : 28.w;
    final travel = width - thumbSize - (padding * 2);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(end: _isDark ? 0 : 1),
        duration: _duration,
        curve: Curves.easeInOutCubicEmphasized,
        builder: (context, value, _) {
          final trackColor = Color.lerp(
            const Color(0xFF1E1E2D),
            const Color(0xFFF0F0F0),
            value,
          )!;
          final thumbColor = Color.lerp(
            const Color(0xFF0F0F1A),
            Colors.white,
            value,
          )!;
          final iconTint = Color.lerp(Colors.white, Colors.black, value)!;

          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08 * value),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 9.w,
                  top: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: value,
                    child: Icon(
                      Icons.nightlight_round,
                      size: 13.sp,
                      color: Colors.black.withValues(alpha: 0.25),
                    ),
                  ),
                ),
                Positioned(
                  right: 9.w,
                  top: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 1 - value,
                    child: Icon(
                      Icons.wb_sunny_rounded,
                      size: 13.sp,
                      color: Colors.white.withValues(alpha: 0.28),
                    ),
                  ),
                ),
                Positioned(
                  left: padding + (travel * value),
                  top: padding,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 1 - value,
                          child: Icon(
                            Icons.nightlight_round,
                            size: 14.sp,
                            color: iconTint,
                          ),
                        ),
                        Opacity(
                          opacity: value,
                          child: Icon(
                            Icons.wb_sunny_rounded,
                            size: 14.sp,
                            color: iconTint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
