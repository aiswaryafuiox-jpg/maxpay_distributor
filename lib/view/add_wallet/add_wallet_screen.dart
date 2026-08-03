import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

import '../../global_widget/commom_button.dart';

// class AddWalletScreen extends StatefulWidget {
//   const AddWalletScreen({super.key});

//   @override
//   State<AddWalletScreen> createState() => _AddWalletScreenState();
// }

// class _AddWalletScreenState extends State<AddWalletScreen> {
//   final AddWalletController _controller = Get.put(sl<AddWalletController>());

//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController bankController = TextEditingController();
//   final TextEditingController utrController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController receiptController = TextEditingController();

//   String? paymentType;

//   final List<String> paymentTypes = [
//     "IMPS",
//     "Bank Transfer",
//     "Cash Deposit",
//     "Others",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDark
//           ? Theme.of(context).scaffoldBackgroundColor
//           : Colors.white,
//       appBar: const CommonAppBar(title: "Add Wallet", showBack: false),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             /// Due Amount Card
// Obx(
//   () => Container(
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(vertical: 14),
//     decoration: BoxDecoration(
//       color: Colors.red,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Column(
//       children: [
//         Text(
//           "Due Amount",
//           style: TextHelper.max16.copyWith(fontSize: 16),
//         ),
//         const SizedBox(height: 4),
//         _controller.isLoading.value
//             ? const CircularProgressIndicator(color: Colors.white)
//             : Text(
//                 _controller.walletBalance.value.currencyIndian,
//                 style: TextHelper.lato12.copyWith(fontSize: 18),
//               ),
//       ],
//     ),
//   ),
// ),

//             const SizedBox(height: 20),

//             _label("Amount"),
//             _textField(amountController, "Enter Amount"),

//             const SizedBox(height: 15),

//             _label("Payment Type"),
//             DropdownButtonFormField<String>(
//               initialValue: paymentType,
//               decoration: _decoration("Select"),
//               dropdownColor: isDark ? const Color(0xff2F3349) : Colors.white,
//               items: paymentTypes.map((e) {
//                 return DropdownMenuItem(
//                   value: e,
//                   child: Text(
//                     e,
//                     style: TextHelper.max2.copyWith(
//                       color: isDark ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   paymentType = value;
//                 });
//               },
//             ),

//             const SizedBox(height: 15),

//             _label("Bank Name"),
//             _textField(bankController, "Enter Bank Name"),

//             const SizedBox(height: 15),

//             _label("UTR No"),
//             _textField(utrController, "Enter UTR No"),

//             const SizedBox(height: 15),

//             _label("Description"),
//             _textField(descriptionController, "Write Here", maxLines: 3),
//             const SizedBox(height: 15),
//             _label("Receipt"),
//             _textField(receiptController, "Enter"),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: 170,
//               child: CommonButton(title: "Submit", onTap: () {}),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _label(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 6),
//         child: Text(text, style: TextHelper.max2),
//       ),
//     );
//   }

//   Widget _textField(
//     TextEditingController controller,
//     String hint, {
//     int maxLines = 1,
//   }) {
//     return TextField(
//       controller: controller,
//       maxLines: maxLines,
//       decoration: _decoration(hint),
//     );
//   }

//   InputDecoration _decoration(String hint) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextHelper.max2.copyWith(color: Colors.grey),
//       filled: true,
//       fillColor: isDark ? const Color(0xff2F3349) : const Color(0xffF7F8FA),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _WalletRequestScreenState();
}

class _WalletRequestScreenState extends State<AddWalletScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _utrController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final AddWalletController _controller = Get.put(sl<AddWalletController>());
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
              const SizedBox(height: 20),
              Obx(
                () => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Due Amount",
                        style: TextHelper.max16.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      _controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              _controller.walletBalance.value.currencyIndian,
                              style: TextHelper.lato12.copyWith(fontSize: 18),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                maxLines: 4,
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
    this.maxLines = 1, // ✅ Added label
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: maxLines == 1 ? 12.w : 12.h,
          ),
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
                    fontSize: 12.sp,
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
                      fontSize: 12.sp,
                      height: 1.25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 8.h),
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF007E63),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 20.sp),
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
