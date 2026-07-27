// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:maxpay/core/constants/colors.dart';
// //
// // class EarningsChart extends StatelessWidget {
// //   const EarningsChart({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return Container(
// //       height: 150.h,
// //       width: MediaQuery.of(context).size.width.w,
// //
// //       decoration: BoxDecoration(
// //         color: !isDark
// //             ? AppColors.clrBg
// //             : AppColors.clrBg.withValues(alpha: .1),
// //         borderRadius: BorderRadius.circular(8.r),
// //         boxShadow: [
// //           if (!isDark)
// //             BoxShadow(
// //               color: Colors.black.withValues(alpha: 0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 4),
// //             ),
// //         ],
// //       ),
// //       child: LineChart(
// //         LineChartData(
// //           gridData: FlGridData(
// //             show: true,
// //             drawVerticalLine: true,
// //             horizontalInterval: 1,
// //             verticalInterval: 1,
// //             getDrawingHorizontalLine: (value) {
// //               return const FlLine(color: Colors.transparent, strokeWidth: 0);
// //             },
// //             getDrawingVerticalLine: (value) {
// //               return FlLine(
// //                 color: isDark
// //                     ? Colors.white.withValues(alpha: 0.21)
// //                     : AppColors.clrTextgrey.withValues(alpha: 0.2),
// //                 strokeWidth: .8,
// //                 dashArray: [5, 5],
// //               );
// //             },
// //           ),
// //           titlesData: const FlTitlesData(show: false),
// //           borderData: FlBorderData(show: false),
// //           minX: 0,
// //           maxX: 11,
// //           minY: 0,
// //           maxY: 6,
// //           lineBarsData: [
// //             LineChartBarData(
// //               spots: const [
// //                 FlSpot(0, 3),
// //                 FlSpot(1, 4),
// //                 FlSpot(2, 3.2),
// //                 FlSpot(3, 4.2),
// //                 FlSpot(4, 4),
// //                 FlSpot(5, 5),
// //                 FlSpot(6, 2),
// //                 FlSpot(7, 2.5),
// //                 FlSpot(8, 3.5),
// //                 FlSpot(9, 2.8),
// //                 FlSpot(10, 2),
// //               ],
// //               isCurved: true,
// //               color: isDark ? AppColors.redClr : AppColors.blueColor,
// //               barWidth: 3,
// //               isStrokeCapRound: true,
// //               dotData: const FlDotData(show: false),
// //               belowBarData: BarAreaData(
// //                 show: true,
// //                 gradient: LinearGradient(
// //                   colors: [
// //                     isDark
// //                         ? AppColors.redClr.withValues(alpha: 0.3)
// //                         : AppColors.blueColor.withValues(alpha: 0.3),
// //                     isDark
// //                         ? AppColors.redClr.withValues(alpha: 0.01)
// //                         : AppColors.blueColor.withValues(alpha: 0.01),
// //                   ],
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class EarningsChart extends StatelessWidget {
//   const EarningsChart({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150.h,
//       width: double.infinity,
//       padding: EdgeInsets.all(8.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.08),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 /// LEFT Y AXIS
//                 SizedBox(
//                   width: 22.w,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _leftText("3M"),
//                       _leftText("2M"),
//                       _leftText("1M"),
//                       _leftText("0"),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(width: 6.w),
//
//                 /// GRAPH
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       /// Horizontal Grid
//                       Positioned.fill(
//                         child: Column(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: List.generate(
//                             4,
//                                 (index) => Container(
//                               width: double.infinity,
//                               height: 1,
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   top: BorderSide(
//                                     color: Colors.grey.shade300,
//                                     width: .8,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       /// RED BAR
//                       Positioned(
//                         left: 8.w,
//                         bottom: 18.h,
//                         child: _bar(
//                           height: 65.h,
//                           colors: const [
//                             Color(0xffFF5252),
//                             Color(0xffFF8A80),
//                           ],
//                         ),
//                       ),
//
//                       /// GREEN BAR
//                       Positioned(
//                         left: 48.w,
//                         bottom: 18.h,
//                         child: _bar(
//                           height: 42.h,
//                           colors: const [
//                             Color(0xff00C853),
//                             Color(0xff69F0AE),
//                           ],
//                         ),
//                       ),
//
//                       /// BLUE BAR
//                       Positioned(
//                         left: 88.w,
//                         bottom: 18.h,
//                         child: _bar(
//                           height: 74.h,
//                           colors: const [
//                             Color(0xff2979FF),
//                             Color(0xff82B1FF),
//                           ],
//                         ),
//                       ),
//
//                       /// ORANGE BAR
//                       Positioned(
//                         right: 10.w,
//                         bottom: 18.h,
//                         child: _bar(
//                           height: 52.h,
//                           colors: const [
//                             Color(0xffFF9100),
//                             Color(0xffFFD180),
//                           ],
//                         ),
//                       ),
//
//                       /// LINE CHART
//                       Positioned.fill(
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: 18.h),
//                           child: LineChart(
//                             LineChartData(
//                               minX: 0,
//                               maxX: 3,
//                               minY: 0,
//                               maxY: 3,
//                               borderData: FlBorderData(show: false),
//                               titlesData:
//                               const FlTitlesData(show: false),
//                               gridData: FlGridData(
//                                 show: true,
//                                 drawVerticalLine: false,
//                                 horizontalInterval: 1,
//                                 getDrawingHorizontalLine: (value) {
//                                   return FlLine(
//                                     color: Colors.grey.shade300,
//                                     dashArray: [6, 6],
//                                     strokeWidth: .8,
//                                   );
//                                 },
//                               ),
//                               lineBarsData: [
//                                 LineChartBarData(
//                                   spots: const [
//                                     FlSpot(0.00, 2.05),
//                                     FlSpot(0.35, 1.65),
//                                     FlSpot(0.80, 1.60),
//                                     FlSpot(1.15, 2.20),
//                                     FlSpot(1.50, 2.65),
//                                     FlSpot(1.80, 2.55),
//                                     FlSpot(2.10, 1.45),
//                                     FlSpot(2.40, 1.25),
//                                     FlSpot(2.75, 1.65),
//                                     FlSpot(3.00, 1.45),
//                                   ],
//                                   isCurved: true,
//                                   curveSmoothness: 0.42,
//                                   color: const Color(0xffFF5A76),
//                                   barWidth: 2.2,
//                                   isStrokeCapRound: true,
//                                   belowBarData: BarAreaData(
//                                     show: true,
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                       colors: [
//                                         const Color(0xffFF5A76).withOpacity(.18),
//                                         const Color(0xffFF5A76).withOpacity(.02),
//                                       ],
//                                     ),
//                                   ),
//                                   dotData: FlDotData(
//                                     show: true,
//                                     getDotPainter: (spot, percent, barData, index) {
//                                       return FlDotCirclePainter(
//                                         radius: 3.5,
//                                         color: Colors.white,
//                                         strokeWidth: 2,
//                                         strokeColor: const Color(0xffFF5A76),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 6.h),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(width: 50.w, child: _bottomText("Purchase")),
//               SizedBox(width: 50.w, child: _bottomText("Online\nPurchase")),
//               SizedBox(width: 50.w, child: _bottomText("Transfer")),
//               SizedBox(width: 50.w, child: _bottomText("Transaction")),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _leftText(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         color: Colors.grey,
//         fontSize: 8.sp,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
//
//   Widget _bottomText(String text) {
//     return SizedBox(
//       width: 42.w,
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.black87,
//           fontSize: 6.5.sp,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   Widget _bar({
//     required double height,
//     required List<Color> colors,
//   }) {
//     return Container(
//       width: 16.w,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.r),
//         gradient: LinearGradient(
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//           colors: colors,
//         ),
//       ),
//     );
//   }
// }
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:maxpay/core/constants/colors.dart';
//
// class EarningsChart extends StatelessWidget {
//   const EarningsChart({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       height: 150.h,
//       width: MediaQuery.of(context).size.width.w,
//
//       decoration: BoxDecoration(
//         color: !isDark
//             ? AppColors.clrBg
//             : AppColors.clrBg.withValues(alpha: .1),
//         borderRadius: BorderRadius.circular(8.r),
//         boxShadow: [
//           if (!isDark)
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//         ],
//       ),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(
//             show: true,
//             drawVerticalLine: true,
//             horizontalInterval: 1,
//             verticalInterval: 1,
//             getDrawingHorizontalLine: (value) {
//               return const FlLine(color: Colors.transparent, strokeWidth: 0);
//             },
//             getDrawingVerticalLine: (value) {
//               return FlLine(
//                 color: isDark
//                     ? Colors.white.withValues(alpha: 0.21)
//                     : AppColors.clrTextgrey.withValues(alpha: 0.2),
//                 strokeWidth: .8,
//                 dashArray: [5, 5],
//               );
//             },
//           ),
//           titlesData: const FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 11,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: const [
//                 FlSpot(0, 3),
//                 FlSpot(1, 4),
//                 FlSpot(2, 3.2),
//                 FlSpot(3, 4.2),
//                 FlSpot(4, 4),
//                 FlSpot(5, 5),
//                 FlSpot(6, 2),
//                 FlSpot(7, 2.5),
//                 FlSpot(8, 3.5),
//                 FlSpot(9, 2.8),
//                 FlSpot(10, 2),
//               ],
//               isCurved: true,
//               color: isDark ? AppColors.redClr : AppColors.blueColor,
//               barWidth: 3,
//               isStrokeCapRound: true,
//               dotData: const FlDotData(show: false),
//               belowBarData: BarAreaData(
//                 show: true,
//                 gradient: LinearGradient(
//                   colors: [
//                     isDark
//                         ? AppColors.redClr.withValues(alpha: 0.3)
//                         : AppColors.blueColor.withValues(alpha: 0.3),
//                     isDark
//                         ? AppColors.redClr.withValues(alpha: 0.01)
//                         : AppColors.blueColor.withValues(alpha: 0.01),
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
                      _leftText("3M"),
                      _leftText("2M"),
                      _leftText("1M"),
                      _leftText("0"),
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
                                    color: const Color(0xffE7E8F2),
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
                                    color: const Color(0xffE7E8F2),
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
              SizedBox(width: 62.w, child: _bottomText("Purchase")),
              SizedBox(width: 62.w, child: _bottomText("Online\nPurchase")),
              SizedBox(width: 62.w, child: _bottomText("Transfer")),
              SizedBox(width: 62.w, child: _bottomText("Transaction")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _leftText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 9.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xff5B5A82),
        height: 1,
      ),
    );
  }

  Widget _bottomText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 8.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: const Color(0xff5B5A82),
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
