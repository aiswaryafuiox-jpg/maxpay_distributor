// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:maxpay/core/constants/colors.dart';
// import 'package:maxpay/global_widget/custom_app.dart';
//
// class GradeScreen extends StatelessWidget {
//   const GradeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//
//       /// Custom AppBar
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.h),
//         child: const CommonAppBar(
//           title: "Grade",
//         ),
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding:
//                 EdgeInsets.symmetric(horizontal: 20.w),
//
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//
//               children: [
//                 SizedBox(height: 30.h),
//
//                 /// Congratulations Section
//                 Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         "Congratulations!",
//
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w600,
//                           color: theme
//                               .colorScheme.onSurface,
//                         ),
//                       ),
//
//                       SizedBox(height: 10.h),
//
//                       Text(
//                         "This month grade is",
//
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: theme.colorScheme
//                               .onSurfaceVariant,
//                         ),
//                       ),
//
//                       SizedBox(height: 25.h),
//
//                       /// Grade
//                       Text(
//                         "A",
//
//                         style: TextStyle(
//                           fontSize: 110.sp,
//                           fontWeight: FontWeight.bold,
//                           color:
//                               AppColors.clrPrimary,
//                           height: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 45.h),
//
//                 /// Details
//                 Text(
//                   "Details",
//
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                     color:
//                         theme.colorScheme.onSurface,
//                   ),
//                 ),
//
//                 SizedBox(height: 15.h),
//
//                 /// Table
//                 Container(
//                   width: double.infinity,
//
//                   decoration: BoxDecoration(
//                     color: theme.brightness ==
//                             Brightness.light
//                         ? Colors.white
//                         : theme.colorScheme
//                             .surfaceContainer,
//
//                     border: Border.all(
//                       color:
//                           theme.colorScheme.outline,
//                     ),
//
//                     borderRadius:
//                         BorderRadius.circular(10.r),
//                   ),
//
//                   child: Column(
//                     children: [
//                       /// Header Row
//                       Row(
//                         children: [
//                           _headerCell(
//                             context,
//                             title: "Grade",
//                             color:
//                                 const Color(0xFFF4D6A6),
//                           ),
//
//                           _headerCell(
//                             context,
//                             title:
//                                 "Daily Average\nBalance",
//                             color: AppColors.box1,
//                           ),
//
//                           _headerCell(
//                             context,
//                             title:
//                                 "Monthly\nCashback",
//                             color:
//                                 const Color(0xFFB9D9F7),
//                             isLast: true,
//                           ),
//                         ],
//                       ),
//
//                       /// Body Rows
//                       _tableRow(
//                         context,
//                         "A",
//                         "5000",
//                         "250",
//                       ),
//
//                       _tableRow(
//                         context,
//                         "B",
//                         "3000",
//                         "150",
//                       ),
//
//                       _tableRow(
//                         context,
//                         "C",
//                         "2000",
//                         "100",
//                       ),
//
//                       _tableRow(
//                         context,
//                         "D",
//                         "1000",
//                         "50",
//                       ),
//
//                       _tableRow(
//                         context,
//                         "E",
//                         "500",
//                         "25",
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 30.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Header Cell
//   Widget _headerCell(
//     BuildContext context, {
//     required String title,
//     required Color color,
//     bool isLast = false,
//   }) {
//     final theme = Theme.of(context);
//
//     return Expanded(
//       child: Container(
//         height: 72.h,
//
//         alignment: Alignment.center,
//
//         decoration: BoxDecoration(
//           color: color,
//
//           border: Border(
//             right: isLast
//                 ? BorderSide.none
//                 : BorderSide(
//                     color:
//                         theme.colorScheme.outline,
//                   ),
//           ),
//         ),
//
//         child: Text(
//           title,
//
//           textAlign: TextAlign.center,
//
//           style: TextStyle(
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Table Row
//   Widget _tableRow(
//     BuildContext context,
//     String grade,
//     String balance,
//     String cashback,
//   ) {
//     return Row(
//       children: [
//         _bodyCell(
//           context,
//           grade,
//         ),
//
//         _bodyCell(
//           context,
//           balance,
//         ),
//
//         _bodyCell(
//           context,
//           cashback,
//           isLast: true,
//         ),
//       ],
//     );
//   }
//
//   /// Body Cell
//   Widget _bodyCell(
//     BuildContext context,
//     String text, {
//     bool isLast = false,
//   }) {
//     final theme = Theme.of(context);
//
//     return Expanded(
//       child: Container(
//         height: 50.h,
//
//         alignment: Alignment.center,
//
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(
//               color:
//                   theme.colorScheme.outline,
//             ),
//
//             right: isLast
//                 ? BorderSide.none
//                 : BorderSide(
//                     color:
//                         theme.colorScheme.outline,
//                   ),
//           ),
//         ),
//
//         child: Text(
//           text,
//
//           style: TextStyle(
//             fontSize: 14.sp,
//             color:
//                 theme.colorScheme.onSurface,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controller/grade_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';


class GradeScreen extends StatelessWidget {
  const GradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final gradeController = Get.put(sl<GradeController>());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CommonAppBar(
          title: "Grade",
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (gradeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gradeController.errorMessage.isNotEmpty) {
            return Center(child: Text(gradeController.errorMessage.value));
          }

          final gradeData = gradeController.gradeData.value;
          if (gradeData == null) {
            return const Center(child: Text("No grade data found."));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.h),

                /// Congratulations
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        gradeData.monthLabel != null 
                            ? "This month (${gradeData.monthLabel}) grade is" 
                            : "This month grade is",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),

                      SizedBox(height: 18.h),

                      Text(
                        gradeData.currentGrade ?? "-",
                        style: TextStyle(
                          fontSize: 105.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.clrPrimary,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 35.h),

                Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 16.h),

                /// Table
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark
                        ? theme.colorScheme.surfaceContainer
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: .5),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      /// Header
                      Row(
                        children: [
                          _headerCell(
                            context,
                            title: "Grade",
                            color: const Color(0xFFFAD9A5),
                          ),
                          _headerCell(
                            context,
                            title: "Daily Average\nBalance",
                            color: const Color(0xFFBDF5D6),
                          ),
                          _headerCell(
                            context,
                            title: "Monthly\nCashback",
                            color: const Color(0xFFBCD9F7),
                            isLast: true,
                          ),
                        ],
                      ),

                      if (gradeData.details != null)
                        ...gradeData.details!.map((detail) => _tableRow(
                              context,
                              detail.grade ?? "-",
                              detail.dailyAverageBalance?.toString() ?? "-",
                              detail.monthlyCashback?.toString() ?? "-",
                            )),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _headerCell(
      BuildContext context, {
        required String title,
        required Color color,
        bool isLast = false,
      }) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        height: 72.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border(
            right: isLast
                ? BorderSide.none
                : BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: .5),
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _tableRow(
      BuildContext context,
      String grade,
      String balance,
      String cashback,
      ) {
    return IntrinsicHeight(
      child: Row(
        children: [
          _bodyCell(context, grade),
          _bodyCell(context, balance),
          _bodyCell(
            context,
            cashback,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _bodyCell(
      BuildContext context,
      String text, {
        bool isLast = false,
      }) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        height: 42.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            right: isLast
                ? BorderSide.none
                : BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: .5),
              width: 1,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}