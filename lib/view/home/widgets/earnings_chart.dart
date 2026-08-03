import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/graph_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/data/model/graph_model.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final GraphController? graphController = Get.isRegistered<GraphController>()
        ? Get.find<GraphController>()
        : null;

    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 14.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkFilterBorder : Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(() {
        final data = graphController?.graphData.value;
        final String currentType =
            graphController?.selectedType.value ?? 'daily';

        List<String> categories = [];
        List<GraphSeries> seriesList = [];
        List<double> barValues = [];
        double maxY = 12.0;

        if (data != null && data.series != null && data.series!.isNotEmpty) {
          seriesList = data.series!;
          categories = data.categories ?? [];

          // Calculate total sum for each series
          barValues = seriesList.map((s) {
            final sData = s.data ?? [];
            return sData.fold<double>(0.0, (sum, val) => sum + val.toDouble());
          }).toList();

          final double maxVal = barValues.isNotEmpty
              ? barValues.reduce((a, b) => a > b ? a : b)
              : 0.0;
          final double apiYMax = data.yMax?.toDouble() ?? 0.0;

          if (apiYMax > 0 && apiYMax >= maxVal) {
            maxY = apiYMax;
          } else if (maxVal > 0) {
            maxY = (maxVal * 1.25).ceilToDouble();
          } else {
            maxY = 12.0;
          }
        }

        // Default mockup fallback if series is empty
        if (seriesList.isEmpty) {
          categories = ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"];
          seriesList = [
            GraphSeries(name: "Purchase", data: [2, 0, 0, 0, 0, 0, 0]),
            GraphSeries(name: "Online\nPurchase", data: [2, 1, 0, 0, 0, 0, 0]),
            GraphSeries(name: "Transfer", data: [1, 0, 0, 0, 0, 0, 0]),
            GraphSeries(name: "Transaction", data: [1, 1, 0, 0, 0, 0, 0]),
          ];
          barValues = [2.15, 2.70, 1.32, 1.50];
          maxY = 3.0;
        }

        final double interval = (maxY / 3.0).clamp(1.0, double.infinity);

        // Vibrant gradient colors for each series bar
        final List<List<Color>> barGradients = [
          [const Color(0xFFFF334B), const Color(0xFFFF5252)], // Red/Coral
          [const Color(0xFF2FD68E), const Color(0xFF4ADE80)], // Mint/Green
          [const Color(0xFF1E86FF), const Color(0xFF3B82F6)], // Electric Blue
          [const Color(0xFFFF8B1E), const Color(0xFFFFA726)], // Orange
          [const Color(0xFF8B5CF6), const Color(0xFFA78BFA)], // Purple
          [const Color(0xFF06B6D4), const Color(0xFF22D3EE)], // Cyan
          [const Color(0xFFEC4899), const Color(0xFFF472B6)], // Pink
        ];

        final double barWidth = (160.w / seriesList.length).clamp(16.w, 25.w);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 HEADER ROW: TITLE & TYPE DROPDOWN
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton<String>(
                  initialValue: currentType,
                  onSelected: (String value) {
                    graphController?.changeType(value);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  elevation: 6,
                  itemBuilder: (context) => [
                    _buildDropdownItem(
                      'daily',
                      'Daily',
                      isDark,
                      currentType == 'daily',
                    ),
                    _buildDropdownItem(
                      'weekly',
                      'Weekly',
                      isDark,
                      currentType == 'weekly',
                    ),
                    _buildDropdownItem(
                      'annual',
                      'Annual',
                      isDark,
                      currentType == 'annual',
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.15)
                            : const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTypeName(currentType),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16.sp,
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF64748B),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            SizedBox(
              height: 185.h,
              child: Stack(
                children: [
                  BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      minY: 0,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (group) => const Color(0xFF1E293B),
                          tooltipPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          tooltipMargin: 8,
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,
                          maxContentWidth: 220.w,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final int sIdx = group.x.toInt();
                            if (sIdx < 0 || sIdx >= seriesList.length) {
                              return null;
                            }

                            final currentSeries = seriesList[sIdx];
                            final String seriesName = currentSeries.name ?? '';
                            final List<num> sData = currentSeries.data ?? [];

                            final List<TextSpan> breakdownSpans = [];

                            for (int k = 0; k < categories.length; k++) {
                              final String cat = categories[k];
                              final num val = k < sData.length ? sData[k] : 0;
                              final String valStr = val % 1 == 0
                                  ? "${val.toInt()}"
                                  : val.toStringAsFixed(1);

                              breakdownSpans.add(
                                TextSpan(
                                  text: '\t$cat: ',
                                  children: [
                                    TextSpan(
                                      text: '$valStr\n',

                                      style: TextStyle(
                                        color: AppColors.card3.withValues(
                                          alpha: 0.85,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        fontFamily: 'Poppins',
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    fontFamily: 'Poppins',
                                    height: 1.35,
                                  ),
                                ),
                              );
                            }

                            return BarTooltipItem(
                              "$seriesName\n",
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp,
                                fontFamily: 'Poppins',
                              ),
                              children: breakdownSpans,
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36.h,
                            getTitlesWidget: (value, meta) {
                              final int index = value.toInt();
                              if (index >= 0 && index < seriesList.length) {
                                final String name =
                                    seriesList[index].name ?? '';
                                final String displayName = name;
                                return Padding(
                                  padding: EdgeInsets.only(top: 8.h),
                                  child: Text(
                                    displayName,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.8)
                                          : const Color(0xFF475467),
                                      height: 1.15,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 34.w,
                            interval: interval,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                _formatY(value),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.6)
                                      : const Color(0xFF667085),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        drawHorizontalLine: true,
                        horizontalInterval: interval,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : const Color(0xFFE5E7EB),
                            strokeWidth: 1.2,
                            dashArray: [6, 6],
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(seriesList.length, (i) {
                        final grad = barGradients[i % barGradients.length];
                        final double val = i < barValues.length
                            ? barValues[i]
                            : 0.0;

                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: val,
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: grad,
                              ),
                              width: barWidth,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r),
                              ),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: false,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),

                  /// SPLINE CURVE & PEAK DOTS OVERLAY
                  Positioned(
                    left: 34.w,
                    right: 0,
                    top: 0,
                    bottom: 36.h,
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _SplineOverlayPainter(
                          values: barValues,
                          maxY: maxY,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  PopupMenuItem<String> _buildDropdownItem(
    String value,
    String title,
    bool isDark,
    bool isSelected,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'Poppins',
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFFFF334B)
                  : (isDark ? Colors.white : const Color(0xFF334155)),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_rounded,
              size: 16.sp,
              color: const Color(0xFFFF334B),
            ),
        ],
      ),
    );
  }

  static String _formatTypeName(String type) {
    switch (type.toLowerCase()) {
      case 'daily':
        return 'Daily';
      case 'weekly':
        return 'Weekly';
      case 'annual':
        return 'Annual';
      default:
        return type.capitalizeFirst ?? type;
    }
  }

  static String _formatY(double val) {
    if (val >= 1000000) {
      double m = val / 1000000;
      return m % 1 == 0 ? "${m.toInt()}M" : "${m.toStringAsFixed(1)}M";
    } else if (val >= 1000) {
      double k = val / 1000;
      return k % 1 == 0 ? "${k.toInt()}K" : "${k.toStringAsFixed(1)}K";
    } else if (val % 1 == 0) {
      return "${val.toInt()}";
    } else {
      return val.toStringAsFixed(1);
    }
  }
}

class _SplineOverlayPainter extends CustomPainter {
  final List<double> values;
  final double maxY;

  _SplineOverlayPainter({required this.values, required this.maxY});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double safeMaxY = maxY > 0 ? maxY : 1.0;
    final int count = values.length;
    if (count == 0) return;

    final double colW = w / count;
    final List<Offset> points = [];

    for (int i = 0; i < count; i++) {
      final double cx = (i + 0.5) * colW;
      final double val = values[i].clamp(0.0, safeMaxY);
      final double cy = (h - (val / safeMaxY) * h).clamp(0.0, h);
      points.add(Offset(cx, cy));
    }

    if (points.length >= 2) {
      final path = Path();
      path.moveTo(points[0].dx, points[0].dy);

      for (int i = 0; i < points.length - 1; i++) {
        final p0 = i > 0 ? points[i - 1] : points[i];
        final p1 = points[i];
        final p2 = points[i + 1];
        final p3 = i + 2 < points.length ? points[i + 2] : p2;

        final cp1 = Offset(
          p1.dx + (p2.dx - p0.dx) / 4.2,
          (p1.dy + (p2.dy - p0.dy) / 4.2).clamp(0.0, h),
        );
        final cp2 = Offset(
          p2.dx - (p3.dx - p1.dx) / 4.2,
          (p2.dy - (p3.dy - p1.dy) / 4.2).clamp(0.0, h),
        );

        path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
      }

      // 1. Area fill underneath
      final areaPath = Path.from(path)
        ..lineTo(points.last.dx, h)
        ..lineTo(points.first.dx, h)
        ..close();

      final areaPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFF5E7E).withValues(alpha: 0.18),
            const Color(0xFFFF5E7E).withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, w, h));

      canvas.drawPath(areaPath, areaPaint);

      // 2. Spline stroke
      final linePaint = Paint()
        ..color = const Color(0xFFFF5E7E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(path, linePaint);

      // 3. Peak circular dots
      for (final pt in points) {
        canvas.drawCircle(pt, 5.0.r, Paint()..color = Colors.white);
        canvas.drawCircle(
          pt,
          5.0.r,
          Paint()
            ..color = const Color(0xFFFF5E7E)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.4,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SplineOverlayPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.maxY != maxY;
  }
}
