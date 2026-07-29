import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class WalletRequestScreen extends StatefulWidget {
  const WalletRequestScreen({super.key});

  @override
  State<WalletRequestScreen> createState() => _WalletRequestScreenState();
}

class _WalletRequestScreenState extends State<WalletRequestScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _utrController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _paymentType;
  PlatformFile? _pickedFile;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pickedFile = result.files.first;
        });
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _bankNameController.dispose();
    _utrController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: 'Wallet Request',
        onBack: () {
          Get.find<NavbarController>().setIndex(0);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            MediaQuery.viewInsetsOf(context).bottom + 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WalletFieldLabel(label: 'Amount'),
              _WalletTextField(
                controller: _amountController,
                hintText: 'Enter Amount',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 14.h),

              _WalletFieldLabel(label: 'Payment Type'),
              _PaymentTypeField(
                value: _paymentType,
                onChanged: (value) {
                  setState(() => _paymentType = value);
                },
              ),
              SizedBox(height: 14.h),

              _WalletFieldLabel(label: 'Bank Name'),
              _WalletTextField(
                controller: _bankNameController,
                hintText: 'Enter Bank Name',
              ),
              SizedBox(height: 14.h),

              _WalletFieldLabel(label: 'UTR No'),
              _WalletTextField(
                controller: _utrController,
                hintText: 'Enter UTR No',
              ),
              SizedBox(height: 14.h),

              _WalletFieldLabel(label: 'Description'),
              _WalletTextField(
                controller: _descriptionController,
                hintText: 'Write Here',
              ),
              SizedBox(height: 14.h),

              _WalletFieldLabel(label: 'Upload'),
              SizedBox(height: 6.h),
              _UploadBox(pickedFile: _pickedFile, onTap: _pickFile),

              SizedBox(height: 24.h),
              Center(
                child: CommonButton(title: 'Submit', onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletFieldLabel extends StatelessWidget {
  const _WalletFieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.h),
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class _WalletTextField extends StatelessWidget {
  const _WalletTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 52.h,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 14.sp,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? AppColors.textclr : const Color(0xFFB8B8B8),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
          ),
          filled: true,
          fillColor: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.totalborde2.withValues(alpha: 0.5),
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.totalborde2.withValues(alpha: 0.5),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.clrPrimary, width: 1.w),
          ),
        ),
      ),
    );
  }
}

class _PaymentTypeField extends StatelessWidget {
  const _PaymentTypeField({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 52.h,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: isDark ? AppColors.textclr : const Color(0xFFB8B8B8),
          size: 22.sp,
        ),
        dropdownColor: isDark ? AppColors.darkplceholder : Colors.white,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 14.sp,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Select',
          hintStyle: TextStyle(
            color: isDark ? AppColors.textclr : const Color(0xFFB8B8B8),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
          ),
          filled: true,
          fillColor: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.totalborde2.withValues(alpha: 0.5),
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.totalborde2.withValues(alpha: 0.5),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.clrPrimary, width: 1.w),
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'UPI', child: Text('UPI')),
          DropdownMenuItem(
            value: 'Bank Transfer',
            child: Text('Bank Transfer'),
          ),
          DropdownMenuItem(value: 'Cash Deposit', child: Text('Cash Deposit')),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  const _UploadBox({this.pickedFile, required this.onTap});

  final PlatformFile? pickedFile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : const Color(0xFFE4E4E4),
          radius: 8.r,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pickedFile != null && pickedFile!.path != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    File(pickedFile!.path!),
                    height: 60.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  pickedFile!.name,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 23.sp,
                  color: theme.colorScheme.onSurface,
                ),
                SizedBox(height: 7.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Text(
                    'Browse and chose the files you want to upload\nfrom your Device',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                      fontSize: 10.sp,
                      height: 1.25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 8.h),
              Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF007E63),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 17.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      const dashWidth = 5.0;
      const dashGap = 4.0;

      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
