import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String? value;
  final Widget imageWidget;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final Border? border;

  const StatCard({
    super.key,
    required this.title,
    this.value,
    required this.imageWidget,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final keepsTintInDark =
        border?.top.color == Colors.transparent && border?.top.width == 0;
    final effectiveBgColor = isDark && !keepsTintInDark
        ? AppColors.darkplceholder
        : bgColor ?? (isDark ? theme.colorScheme.surface : Colors.white);
    final effectiveBorder = isDark && !keepsTintInDark
        ? Border.all(color: const Color(0xFF3A4058), width: 0.8)
        : border ??
              Border.all(
                color: borderColor ?? AppColors.clrPrimary,
                width: 0.8,
              );
    final titleColor = isDark && !keepsTintInDark
        ? Colors.white
        : textColor ?? theme.colorScheme.onSurface;
    final valueColor = isDark && keepsTintInDark
        ? AppColors.clrTextblack
        : theme.textTheme.bodyLarge?.color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: effectiveBgColor,
          borderRadius: BorderRadius.circular(isDark ? 8.r : 12.r),

          /// 🔵 Blue Border
          border: effectiveBorder,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 CUSTOM IMAGE / ICON WIDGET
            imageWidget,

            SizedBox(height: 10.h),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
                fontSize: 10.sp,
                color: titleColor,
              ),
            ),

            if (value != null) ...[
              SizedBox(height: 2.h),

              Text(
                value!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  color: valueColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 🔥 Zoom In + Zoom Out + Blink Animation
class BlinkingZoomCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const BlinkingZoomCard({super.key, required this.child, this.onTap});

  @override
  State<BlinkingZoomCard> createState() => _BlinkingZoomCardState();
}

class _BlinkingZoomCardState extends State<BlinkingZoomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    /// 🔍 Zoom Animation
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    /// ✨ Blink Animation
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
      ),
    );
  }
}
