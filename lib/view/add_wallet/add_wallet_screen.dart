import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/controller/bank_controller.dart';
import 'package:maxpay/data/model/bank_details_model.dart' as bank_model;
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

import '../../global_widget/commom_button.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _WalletRequestScreenState();
}

class _WalletRequestScreenState extends State<AddWalletScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _utrController = TextEditingController();
  final BankDetailController _bankController = Get.put(
    sl<BankDetailController>(),
  );
  bank_model.Data? _selectedBank;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _receiptController = TextEditingController();
  final AddWalletController _controller = Get.put(sl<AddWalletController>());
  String? _paymentType;
  PlatformFile? _pickedFile;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (!mounted) return;

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pickedFile = result.files.first;
          _receiptController.text = result.files.first.path ?? '';
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
    _receiptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: 'Wallet Request',
        onBack: () {
          Get.find<NavbarController>().setIndex(0);
        },
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "Due Amount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Obx(() {
                      return _controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              _controller.walletBalance.value.currencyIndian,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 22.h),

              /// Amount
              buildLabel(context, "Amount"),
              buildTextField(
                context: context,
                controller: _amountController,
                hint: "Enter Amount",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),

              /// Payment Type
              buildLabel(context, "Payment Type"),
              DropdownButtonFormField<String>(
                dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                value:
                    ["Bank Transfer", "Stock Exchange"].contains(_paymentType)
                    ? _paymentType
                    : null,
                decoration: inputDecoration(context, "Select"),
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontFamily: 'Poppins',
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select payment type";
                  }
                  return null;
                },
                items: const [
                  DropdownMenuItem(
                    value: "Bank Transfer",
                    child: Text("Bank Transfer"),
                  ),

                  DropdownMenuItem(
                    value: "Stock Exchange",
                    child: Text("Stock Exchange"),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    _paymentType = value;
                  });
                },
              ),
              SizedBox(height: 16.h),

              if (_paymentType != "Stock Exchange") ...[
                /// Bank Name
                buildLabel(context, "Bank Name"),
                Obx(() {
                  final banks = _bankController.bankData.value?.data ?? [];
                  return DropdownButtonFormField<bank_model.Data>(
                    dropdownColor: isDark
                        ? const Color(0xFF1E1E1E)
                        : Colors.white,
                    value: _selectedBank,
                    decoration: inputDecoration(context, "Select Bank"),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'Poppins',
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Please select bank";
                      }
                      return null;
                    },
                    items: banks.map((bank) {
                      return DropdownMenuItem<bank_model.Data>(
                        value: bank,
                        child: Text(bank.bankName ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBank = value;
                      });
                    },
                  );
                }),
                SizedBox(height: 16.h),

                /// UTR
                buildLabel(context, "UTR No"),
                buildTextField(
                  context: context,
                  controller: _utrController,
                  hint: "Enter UTR No",
                ),
                SizedBox(height: 16.h),
              ],

              /// Description
              buildLabel(context, "Description"),
              buildTextField(
                context: context,
                controller: _descriptionController,
                hint: "Write Here",
                maxLines: 3,
              ),
              SizedBox(height: 16.h),

              if (_paymentType != "Stock Exchange") ...[
                /// Upload
                buildLabel(context, "Upload"),
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E1E1E)
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: _pickedFile != null && _pickedFile!.path != null
                        ? Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.file(
                                  File(_pickedFile!.path!),
                                  height: 160.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Image Selected",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 32.sp,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                "Browse and choose the files you want to upload from your device",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 18.h),
                              Container(
                                width: 36.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
              if (_paymentType == "Stock Exchange") SizedBox(height: 30.h),

              /// Submit Button
              Center(
                child: SizedBox(
                  width: 140.w,
                  height: 46.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_paymentType != "Stock Exchange") {
                        if (_pickedFile == null) {
                          Get.snackbar(
                            "Error",
                            "Please upload receipt image",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }
                      }

                      await _controller.createWalletRequest(
                        amount: _amountController.text.trim(),
                        paymenttype: _paymentType ?? "",
                        utrno: _paymentType == "Stock Exchange"
                            ? ""
                            : _utrController.text.trim(),
                        bankid: _paymentType == "Stock Exchange"
                            ? ""
                            : (_selectedBank?.id ?? 1).toString(),
                        description: _descriptionController.text.trim(),
                        receipt: _paymentType == "Stock Exchange"
                            ? ""
                            : _pickedFile!.path!,
                        onSuccess: () {
                          _amountController.clear();
                          _utrController.clear();
                          _descriptionController.clear();
                          setState(() {
                            _paymentType = null;
                            _selectedBank = null;
                            _pickedFile = null;
                          });
                        },
                      );

                      // Optionally pop or clear fields
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1CA3BA),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Label
  Widget buildLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  /// TextField
  Widget buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 15,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter this field";
        }
        return null;
      },
      decoration: inputDecoration(context, hint),
    );
  }

  /// Input Decoration
  InputDecoration inputDecoration(BuildContext context, String hint) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: 14.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: isDark ? AppColors.darkFilterBorder : const Color(0xFFF2F2F2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF1CA3BA)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}
