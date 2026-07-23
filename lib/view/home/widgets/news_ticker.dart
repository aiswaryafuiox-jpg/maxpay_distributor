import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class NewsTicker extends StatefulWidget {
  const NewsTicker({super.key});

  @override
  State<NewsTicker> createState() => _NewsTickerState();
}

class _NewsTickerState extends State<NewsTicker> {
  late ScrollController _scrollController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Start scrolling after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    if (!_scrollController.hasClients) return;

    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    // Calculate duration based on distance to maintain constant speed
    final remainingDistance = maxScrollExtent - currentScroll;
    final duration = Duration(milliseconds: (remainingDistance * 50).toInt());

    if (duration.inMilliseconds <= 0) {
      // If we are at the end, reset and start over
      _scrollController.jumpTo(0);
      _startScrolling();
      return;
    }

    _scrollController
        .animateTo(maxScrollExtent, duration: duration, curve: Curves.linear)
        .then((_) {
          if (mounted) {
            // Jump back to start and repeat
            _scrollController.jumpTo(0);
            _startScrolling();
          }
        });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    const newsText =
        'LOREM IPSUM IS SIMPLY DUMMY TEXT OF THE PRINTING AND TYPESETTING INDUSTRY. STAY TUNED FOR MORE UPDATES!';

    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : Colors.white,
        border: Border.all(
          color: theme.brightness == Brightness.light
                    ? colorScheme.primary
                    : AppColors.sim2,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3.r),
        child: Row(
          children: [
            /// 🔹 Slanted News Label
            ClipPath(
              clipper: NewsClipper(),
              child: Container(
                width: 100.w,
                color: theme.brightness == Brightness.light
                    ? colorScheme.primary
                    : AppColors.sim2,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 15.w),
                child: Text(
                  'NEWS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            /// 🔹 Auto-Scrolling Ticker Text
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Text(
                        newsText,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(width: 50.w), // Gap before repeat
                      Text(
                        newsText, // Duplicate for seamless feel
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
