import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/profile_controller.dart';

import 'package:maxpay/core/constants/colors.dart';

import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
import 'package:maxpay/data/model/transaction/transaction_detail_response_model.dart';

import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareReceipt {
  static Future<void> shareScreenshot({
    required BuildContext context,
    required TransactionDetailData data,
  }) async {
    try {
      final screenshotController = ScreenshotController();
      ProfileController? profileController;

      if (Get.isRegistered<ProfileController>()) {
        profileController = Get.find<ProfileController>();
      }
      final profile = profileController?.profileData.value;

      // Show loader
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final widgetToCapture = MediaQuery(
        data: MediaQuery.of(context),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Theme(
            data: Theme.of(context),
            child: Material(
              color: Colors.transparent,
              child: Wrap(
                children: [_buildReceiptContent(context, profile, data)],
              ),
            ),
          ),
        ),
      );

      final Uint8List imageBytes = await screenshotController.captureFromWidget(
        widgetToCapture,
        delay: const Duration(milliseconds: 200),
      );

      final directory = Directory("/storage/emulated/0/Download");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final id = data.transactionId?.isNotEmpty == true
          ? data.transactionId!.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_')
          : DateTime.now().millisecondsSinceEpoch.toString();

      final savePath = '${directory.path}/Receipt_$id.png';
      final file = File(savePath);
      await file.writeAsBytes(imageBytes);

      final xFile = XFile(file.path, mimeType: 'image/png');

      // Close loader
      if (context.mounted) Navigator.pop(context);

      await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: 'Hello, here is your Transaction Receipt.',
          subject: 'Transaction Receipt',
        ),
      );
    } catch (e) {
      debugPrint('SHARE ERROR: $e');
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unable to share receipt: $e')));
      }
    }
  }

  static Future<void> downloadScreenshot({
    required BuildContext context,
    required TransactionDetailData data,
  }) async {
    try {
      final screenshotController = ScreenshotController();
      ProfileController? profileController;

      if (Get.isRegistered<ProfileController>()) {
        profileController = Get.find<ProfileController>();
      }
      final profile = profileController?.profileData.value;

      // Show loader
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final widgetToCapture = MediaQuery(
        data: MediaQuery.of(context),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Theme(
            data: Theme.of(context),
            child: Material(
              color: Colors.transparent,
              child: Wrap(
                children: [_buildReceiptContent(context, profile, data)],
              ),
            ),
          ),
        ),
      );

      final Uint8List imageBytes = await screenshotController.captureFromWidget(
        widgetToCapture,
        delay: const Duration(milliseconds: 200),
      );

      final directory = Directory("/storage/emulated/0/Download");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final id = data.transactionId?.isNotEmpty == true
          ? data.transactionId!.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_')
          : DateTime.now().millisecondsSinceEpoch.toString();

      final savePath = '${directory.path}/Receipt_$id.png';
      final file = File(savePath);
      await file.writeAsBytes(imageBytes);

      // Close loader
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt saved to Downloads')),
        );
      }
    } catch (e) {
      debugPrint('DOWNLOAD ERROR: $e');
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unable to save receipt: $e')));
      }
    }
  }

  static Widget _buildReceiptContent(
    BuildContext context,
    dynamic profile,
    TransactionDetailData data,
  ) {
    return Container(
      width: 340.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.clrPrimary,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: Text(
                "Transaction Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(height: 15.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transaction ID : ${data.transactionId ?? '-'}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Date & Time : ${data.dateTime?.isNotEmpty == true ? formatTransactionDate(data.dateTime!) : '-'}",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              if (data.productLogo?.isNotEmpty == true)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    data.productLogo!,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => _fallbackLogo(data),
                  ),
                )
              else
                _fallbackLogo(data),
            ],
          ),

          SizedBox(height: 12.h),
          Divider(),

          _detailRow(
            context,
            "Transaction",
            (data.status?.toLowerCase() == 'received' ||
                    data.status?.toLowerCase() == 'success')
                ? "Success"
                : (data.status ?? "-"),
            valueColor:
                (data.status?.toLowerCase() == 'received' ||
                    data.status?.toLowerCase() == 'success')
                ? Colors.green
                : Colors.black,
          ),

          _detailRow(
            context,
            "Transaction No",
            data.mobile ?? data.mobile ?? "-",
          ),
          _detailRow(context, "Amount", (data.amount ?? 0).currencyIndian),
          _detailRow(
            context,
            "Product",
            data.productName ?? data.productName ?? "-",
          ),
          _detailRow(context, "Product Ref. Id", data.transactionId ?? "-"),

          SizedBox(height: 12.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.clrPrimary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                _detailRow(
                  context,
                  "Retailer Name",
                  profile?.name ?? "N/A",
                  textColor: Colors.white,
                ),
                _detailRow(
                  context,
                  "Contact No",
                  profile?.phoneNumber ?? "N/A",
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            "T & C Apply",
            style: TextStyle(color: Colors.blue, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  static Widget _fallbackLogo(TransactionDetailData data) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: Colors.red,
      child: Text(
        (data.productName?.isNotEmpty == true)
            ? data.productName![0].toUpperCase()
            : 'J',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _detailRow(
    BuildContext context,
    String title,
    String value, {
    Color? valueColor,
    Color? textColor,
  }) {
    final color = textColor ?? Colors.black;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
            child: Text(
              ":",
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: valueColor ?? color,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
