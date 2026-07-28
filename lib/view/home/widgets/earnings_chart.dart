import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkFilterBorder : Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.redAccent, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      height: 190.h,
      width: double.infinity,
      // padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 8.h),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(18.r),

      // ),
      child: Column(
        children: [
          /// GRAPH
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// LEFT VALUES
                SizedBox(
                  width: 28.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _leftText("3k", isDark),
                      _leftText("2k", isDark),
                      _leftText("1k", isDark),
                      _leftText("0", isDark),
                    ],
                  ),
                ),

                SizedBox(width: 6.w),

                Expanded(
                  child: Stack(
                    children: [
                      /// GRID
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) => Container(
                              height: 1,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : const Color(0xffE7E8F2),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// CHART
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 18.h),
                          child: LineChart(
                            LineChartData(
                              minX: 0,
                              maxX: 3,
                              minY: 0,
                              maxY: 3,
                              clipData: FlClipData.all(),
                              borderData: FlBorderData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: 1,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : const Color(0xffE7E8F2),
                                    dashArray: [6, 6],
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  curveSmoothness: .45,
                                  color: const Color(0xffFF6385),
                                  barWidth: 2.2,
                                  isStrokeCapRound: true,

                                  spots: const [
                                    FlSpot(0.00, 2.08),
                                    FlSpot(.38, 1.55),
                                    FlSpot(.80, 1.72),
                                    FlSpot(1.12, 2.35),
                                    FlSpot(1.36, 2.70),
                                    FlSpot(1.62, 2.58),
                                    FlSpot(2.00, 1.35),
                                    FlSpot(2.28, 1.25),
                                    FlSpot(2.58, 1.70),
                                    FlSpot(2.98, 1.42),
                                  ],

                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(
                                          0xffFF6385,
                                        ).withValues(alpha: .20),
                                        const Color(
                                          0xffFF6385,
                                        ).withValues(alpha: 0),
                                      ],
                                    ),
                                  ),

                                  dotData: FlDotData(
                                    show: true,
                                    checkToShowDot: (spot, barData) {
                                      return spot.x == 0 ||
                                          spot.x == 1.36 ||
                                          spot.x == 2.00 ||
                                          spot.x == 2.98;
                                    },
                                    getDotPainter: (spot, percent, bar, index) {
                                      return FlDotCirclePainter(
                                        radius: 3.6,
                                        color: const Color(0xffFF6385),
                                        strokeWidth: 2.5,
                                        strokeColor: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// RED BAR
                      Positioned(
                        left: 10.w,
                        bottom: 18.h,
                        child: _bar(
                          height: 72.h,
                          colors: const [Color(0xffFF303A), Color(0xffFF7A86)],
                        ),
                      ),

                      /// GREEN BAR
                      Positioned(
                        left: 83.w,
                        bottom: 18.h,
                        child: _bar(
                          height: 95.h,
                          colors: const [Color(0xff39DE95), Color(0xff8EE6B7)],
                        ),
                      ),

                      /// BLUE BAR
                      Positioned(
                        left: 156.w,
                        bottom: 18.h,
                        child: _bar(
                          height: 44.h,
                          colors: const [Color(0xff1686EA), Color(0xff56A9F2)],
                        ),
                      ),

                      /// ORANGE BAR
                      Positioned(
                        right: 12.w,
                        bottom: 18.h,
                        child: _bar(
                          height: 52.h,
                          colors: const [Color(0xffFF8C21), Color(0xffFFA54A)],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 62.w, child: _bottomText("Purchase", isDark)),
              SizedBox(
                width: 62.w,
                child: _bottomText("Online\nPurchase", isDark),
              ),
              SizedBox(width: 62.w, child: _bottomText("Transfer", isDark)),
              SizedBox(width: 62.w, child: _bottomText("Transaction", isDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _leftText(String text, bool isDark) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 9.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white70 : const Color(0xff5B5A82),
        height: 1,
      ),
    );
  }

  Widget _bottomText(String text, bool isDark) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 8.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white70 : const Color(0xff5B5A82),
        height: 1.15,
      ),
    );
  }

  Widget _bar({required double height, required List<Color> colors}) {
    return Container(
      width: 20.w,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: colors,
        ),
      ),
    );
  }
}
