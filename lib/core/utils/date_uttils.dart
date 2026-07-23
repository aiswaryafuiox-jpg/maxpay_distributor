import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/colors.dart';

class DateTimeFormater {
  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return 'N/A';
    }
    try {
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime.toUtc());
      // return DateFormat('dd MMM yyyy, hh:mm a')
      //     .format(dateTime.toUtc().toLocal());
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String formatDateOnly(DateTime? dateTime) {
    if (dateTime == null) {
      return 'N/A';
    }
    try {
      log("Original: $dateTime");
      log("Local: ${dateTime.toLocal()}");

      // Format directly after converting to local time
      return DateFormat('dd MMM yyyy').format(dateTime);
      // return DateFormat('dd MMM yyyy').format(dateTime.toLocal());
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String formatDOB(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    try {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  /// Parse a date of birth string in 'dd-MM-yyyy' format back to DateTime
  static DateTime parseDOB(String dateString) {
    if (dateString.isEmpty || dateString == 'N/A') {
      throw FormatException('Invalid date string: $dateString');
    }
    try {
      return DateFormat('dd-MM-yyyy').parse(dateString);
    } catch (e) {
      throw FormatException(
        'Unable to parse date: $dateString. Expected format: dd-MM-yyyy',
      );
    }
  }

  static String timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 30) {
      // Divide total days by 30 to get the approximate number of months
      final int months = (difference.inDays / 30).floor();
      return months > 1 ? '$months months ago' : '1 month ago';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inMinutes == 1) {
      return '1 min ago';
    } else {
      return 'Just now';
    }
  }

  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good morning,';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon,';
    } else if (hour >= 17 && hour < 21) {
      return 'Good evening,';
    } else {
      return 'Good night,';
    }
  }

  static String formatStatusText(String statusText) {
    if (statusText.toLowerCase().contains("last seen")) {
      try {
        // Extract date part
        final dateString = statusText.split("Last seen ").last.trim();
        final parsedDate = DateFormat('dd/MM/yyyy').parse(dateString);

        // Format it as 'Last seen on 2 Jun 2025'
        final formatted = DateFormat('d MMM yyyy').format(parsedDate);
        return 'Last seen on $formatted';
      } catch (e) {
        return statusText; // Fallback if parsing fails
      }
    }

    return statusText;
  }

  static String formatMessagesTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final localDate = dateTime.toLocal();

    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(localDate.year, localDate.month, localDate.day);

    if (messageDay == today) {
      // Same day – show only the time
      return DateFormat('h:mm a').format(localDate);
    }

    final startOfWeek = today.subtract(
      Duration(days: today.weekday - 1),
    ); // Monday
    final endOfWeek = today.add(
      Duration(days: DateTime.daysPerWeek - today.weekday),
    ); // Sunday

    if (messageDay.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        messageDay.isBefore(endOfWeek.add(const Duration(days: 1)))) {
      // Same week – show day name (e.g., Monday)
      return DateFormat('EEEE').format(localDate);
    }

    // Older – show date like "12 Apr"
    return DateFormat('d MMM').format(localDate);
  }

  static Widget defaultLastMessageTimeBuilder(
    DateTime? messageTime,
    BuildContext context,
  ) {
    if (messageTime == null) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final localMessageTime = messageTime.toLocal();
    final duration = now.difference(localMessageTime);

    String timeStr;

    if (duration.inMinutes < 1) {
      timeStr = 'just now';
    } else if (duration.inHours < 1) {
      timeStr = '${duration.inMinutes} minutes ago';
    } else if (duration.inDays < 1) {
      final hour = localMessageTime.hour % 12 == 0
          ? 12
          : localMessageTime.hour % 12;
      final minute = localMessageTime.minute.toString().padLeft(2, '0');
      final ampm = localMessageTime.hour >= 12 ? 'PM' : 'AM';
      timeStr = '$hour:$minute $ampm';
    } else if (now.year == localMessageTime.year) {
      timeStr = DateFormat('d MMM yyyy').format(localMessageTime);
    } else {
      timeStr = DateFormat('d MMM yyyy').format(localMessageTime);
    }

    return Opacity(
      opacity: 0.64,
      child: Text(
        timeStr,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontSize: 11.sp, color: AppColors.clrTextgrey),
      ),
    );
  }
}
