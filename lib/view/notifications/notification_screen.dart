import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/notification_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: "Notifications",
        action: Obx(() {
          if (controller.notifications.isEmpty) return const SizedBox.shrink();
          return TextButton(
            onPressed: () => controller.clearAll(),
            child: Text(
              "Clear All",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.redClr,
              ),
            ),
          );
        }),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        size: 48.sp,
                        color: isDark
                            ? AppColors.textclr
                            : Colors.grey.shade400,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "No notifications yet",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.textclr
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  itemCount: controller.notifications.length,
                  separatorBuilder: (_, _) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final item = controller.notifications[index];
                    final bool isRead = item["isRead"] == true;

                    return GestureDetector(
                      onTap: () => controller.markAsRead(index),
                      child: Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: isDark
                              ? (isRead
                                    ? AppColors.darkplceholder
                                    : AppColors.darkplceholder.withValues(
                                        alpha: 0.8,
                                      ))
                              : (isRead
                                    ? Colors.white
                                    : const Color(0xFFF0F7FF)),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkFilterBorder
                                : (isRead
                                      ? const Color(0xFFE5E7EB)
                                      : AppColors.clrPrimary.withValues(
                                          alpha: 0.25,
                                        )),
                            width: 1,
                          ),
                          boxShadow: [
                            if (!isDark && !isRead)
                              BoxShadow(
                                color: AppColors.clrPrimary.withValues(
                                  alpha: 0.05,
                                ),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ICON AVATAR
                            Container(
                              width: 38.w,
                              height: 38.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _getIconBgColor(
                                  item["title"],
                                  isRead,
                                  isDark,
                                ),
                              ),
                              child: Icon(
                                _getNotificationIcon(item["title"]),
                                color: _getIconColor(
                                  item["title"],
                                  isRead,
                                  isDark,
                                ),
                                size: 18.sp,
                              ),
                            ),

                            SizedBox(width: 12.w),

                            /// CONTENT
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item["title"] ?? "",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13.5.sp,
                                            fontWeight: isRead
                                                ? FontWeight.w600
                                                : FontWeight.w700,
                                            color: isDark
                                                ? Colors.white
                                                : const Color(0xFF1E293B),
                                          ),
                                        ),
                                      ),
                                      if (!isRead)
                                        Container(
                                          width: 8.w,
                                          height: 8.w,
                                          margin: EdgeInsets.only(left: 6.w),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.clrPrimary,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    item["message"] ?? "",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.75)
                                          : const Color(0xFF475467),
                                      height: 1.35,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    item["time"] ?? "",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isDark
                                          ? AppColors.textclr
                                          : const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String? title) {
    final t = (title ?? '').toLowerCase();
    if (t.contains('approved') || t.contains('success')) {
      return Icons.check_circle_outline_rounded;
    } else if (t.contains('request') || t.contains('fund')) {
      return Icons.swap_horiz_rounded;
    } else if (t.contains('commission') || t.contains('credit')) {
      return Icons.account_balance_wallet_outlined;
    } else if (t.contains('alert') || t.contains('low balance')) {
      return Icons.warning_amber_rounded;
    } else if (t.contains('retailer') || t.contains('registered')) {
      return Icons.person_add_alt_1_outlined;
    } else if (t.contains('kyc')) {
      return Icons.verified_user_outlined;
    }
    return Icons.notifications_outlined;
  }

  Color _getIconBgColor(String? title, bool isRead, bool isDark) {
    if (isDark) {
      return isRead
          ? const Color(0xFF334155)
          : AppColors.clrPrimary.withValues(alpha: 0.25);
    }
    final t = (title ?? '').toLowerCase();
    if (t.contains('approved')) {
      return const Color(0xFFDCFCE7); // Light green
    } else if (t.contains('alert')) {
      return const Color(0xFFFEE2E2); // Light red
    } else if (t.contains('request')) {
      return const Color(0xFFFFEDD5); // Light orange
    }
    return const Color(0xFFE0F2FE); // Light blue
  }

  Color _getIconColor(String? title, bool isRead, bool isDark) {
    final t = (title ?? '').toLowerCase();
    if (t.contains('approved')) {
      return const Color(0xFF16A34A);
    } else if (t.contains('alert')) {
      return const Color(0xFFDC2626);
    } else if (t.contains('request')) {
      return const Color(0xFFEA580C);
    }
    return AppColors.clrPrimary;
  }
}
