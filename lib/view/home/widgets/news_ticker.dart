import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class NewsTicker extends StatefulWidget {
  const NewsTicker({super.key});

  @override
  State<NewsTicker> createState() => _NewsTickerState();
}

class _NewsTickerState extends State<NewsTicker> {
  final HomePageController controller = Get.find<HomePageController>();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      startScrolling();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bool _isRunning = false;

  Future<void> startScrolling() async {
    if (_isRunning) return;

    _isRunning = true;

    while (mounted) {
      if (!scrollController.hasClients) {
        await Future.delayed(const Duration(milliseconds: 300));
        continue;
      }

      final max = scrollController.position.maxScrollExtent;

      if (max <= 0) {
        await Future.delayed(const Duration(seconds: 2));
        continue;
      }

      await scrollController.animateTo(
        max,
        duration: const Duration(seconds: 18),
        curve: Curves.linear,
      );

      if (!mounted) break;

      scrollController.jumpTo(0);
    }

    _isRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    AppLogger.debugPrint("🔥 NewsTicker Build Called");
    AppLogger.debugPrint("🔥 Controller Hash: ${controller.hashCode}");

    return Obx(() {
      final newsResponse = controller.news.value;

      String newsText = "No News Available";

      if (newsResponse != null &&
          newsResponse.data != null &&
          newsResponse.data!.isNotEmpty) {
        newsText = newsResponse.data!.first.message ?? "";
      }

      return RepaintBoundary(
        child: Container(
          height: 50.h,
          margin: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isDark ? colorScheme.surface : Colors.white,
            border: Border.all(
              color: theme.brightness == Brightness.light
                  ? AppColors.clrPrimary
                  : AppColors.activeBtn,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3.r),
            child: Row(
              children: [
                /// NEWS LABEL
                ClipPath(
                  clipper: NewsClipper(),
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 15.w),
                    color: theme.brightness == Brightness.light
                        ? AppColors.clrPrimary
                        : AppColors.activeBtn,
                    child: Text(
                      'NEWS',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                /// SCROLLING NEWS
                Expanded(
                  child: GestureDetector(
                    onTap: () => showNewsPopup(newsText),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            Text(
                              newsText,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(width: 50.w),
                            Text(
                              newsText,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

void showNewsPopup(String newsText) {
  final isDark = Get.isDarkMode;

  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            margin: EdgeInsets.only(top: 15.h, right: 15.w),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.clrPrimary, width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    // text: 'Title : ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text: 'Latest News',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(color: Colors.grey.shade400, thickness: 1),
                SizedBox(height: 10.h),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      newsText,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: isDark ? Colors.white70 : Colors.black87,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? Colors.grey[900]! : Colors.white,
                    width: 2.5,
                  ),
                ),
                child: Icon(Icons.close, color: Colors.white, size: 20.sp),
              ),
            ),
          ),
        ],
      ),
    ),
  );
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
