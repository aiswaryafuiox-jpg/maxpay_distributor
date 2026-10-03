import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String? value;
  final Widget imageWidget;
  final TextStyle? titletextStyle;
  final TextStyle? valuetextStyle;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? valueColor;
  final bool needSpacingbwImage;
  final double borderWidth;

  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    this.value,
    required this.imageWidget,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.valueColor,
    this.onTap,
    this.needSpacingbwImage = true,
    this.borderWidth = 1.0,
    this.titletextStyle,
    this.valuetextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.15,
        child: Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color:
                bgColor ?? (isDark ? theme.colorScheme.surface : Colors.white),

            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                offset: const Offset(0, 4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
            border: Border.all(
              color: borderColor ?? AppColors.clrPrimary,
              width: borderWidth,
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              /// IMAGE / ICON
              SizedBox(
                height: 38.h,
                child: Center(child: imageWidget),
              ),
              if (needSpacingbwImage) SizedBox(height: 5.h),

              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style:
                    titletextStyle ??
                    TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 9.sp,
                      color: textColor ?? theme.colorScheme.onSurface,
                    ),
              ),

              if (value != null) ...[
                SizedBox(height: 2.h),
                Text(
                  value!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style:
                      valuetextStyle ??
                      TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        height: 1.2,
                        color: valueColor,
                      ),
                ),
              ],
            ],
          ),
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
