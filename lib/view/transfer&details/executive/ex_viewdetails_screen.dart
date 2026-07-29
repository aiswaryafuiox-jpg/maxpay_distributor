import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import '../../../controller/executive_controller.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class ExeViewDetailsScreen extends StatefulWidget {
  const ExeViewDetailsScreen({super.key});

  @override
  State<ExeViewDetailsScreen> createState() => _ExeViewDetailsScreenState();
}

class _ExeViewDetailsScreenState extends State<ExeViewDetailsScreen> {
  final ExecutiveController _controller = Get.find<ExecutiveController>();

  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController whatsappController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController pinCodeController;
  late TextEditingController minAmountController;
  late TextEditingController autoTransferAmountController;

  String selectedPackage = "Select";
  String autoTransfer = "Auto";
  String status = "Active";

  @override
  void initState() {
    super.initState();
    final detail = _controller.executiveDetail.value;

    nameController = TextEditingController(text: detail?.executiveName ?? '');
    mobileController = TextEditingController(
      text: detail?.regMobileNumber ?? '',
    );
    whatsappController = TextEditingController(
      text: detail?.whatsappNumber ?? '',
    );
    emailController = TextEditingController(text: detail?.email ?? '');
    addressController = TextEditingController(text: detail?.address ?? '');
    pinCodeController = TextEditingController(text: detail?.pinCode ?? '44');
    minAmountController = TextEditingController(
      text: detail?.minimumAmount?.toString() ?? '',
    );
    autoTransferAmountController = TextEditingController(
      text: detail?.autoTransferAmount?.toString() ?? '',
    );

    // Initialize dropdowns (Ensure values match the dropdown items)
    if (detail?.commissionPackage != null &&
        (detail!.commissionPackage == "Gold" ||
            detail.commissionPackage == "Silver")) {
      selectedPackage = detail.commissionPackage!;
    }
    if (detail?.autoTransfer != null &&
        (detail!.autoTransfer == "Auto" || detail.autoTransfer == "Manual")) {
      autoTransfer = detail.autoTransfer!;
    }
    if (detail?.status != null &&
        (detail!.status == "Active" || detail.status == "Inactive")) {
      status = detail.status!;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    addressController.dispose();
    pinCodeController.dispose();
    minAmountController.dispose();
    autoTransferAmountController.dispose();
    super.dispose();
  }

  void _markDirty() {
    if (!_controller.isDirty.value) {
      _controller.isDirty.value = true;
    }
  }

  Widget buildLabel(String text, bool isDark, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextHelper.max9(
          context,
        ).copyWith(color: isDark ? AppColors.textclr : AppColors.clrTextblack),
      ),
    );
  }

  Widget buildReadOnlyField(
    BuildContext context,
    String value, {
    Color? valueColor,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.darkFilterBorder : Colors.grey.shade300,
        ),
      ),
      child: Text(
        value,
        style: TextHelper.max1.copyWith(
          color:
              valueColor ??
              (isDark ? AppColors.textclr : AppColors.clrTextblack),
        ),
      ),
    );
  }

  Widget buildField(
    BuildContext context,
    TextEditingController controller, {
    bool isPhoneNumber = false,
    bool isDigitsOnly = false,
    bool isEmailAdres = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      onChanged: (_) => _markDirty(),
      keyboardType: (isPhoneNumber || isDigitsOnly)
          ? TextInputType.number
          : isEmailAdres
          ? TextInputType.emailAddress
          : TextInputType.text,
      inputFormatters: isPhoneNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ]
          : isDigitsOnly
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      style: TextHelper.max1.copyWith(
        color: isDark ? AppColors.textclr : AppColors.clrTextblack,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkFilterBorder : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.clrPrimary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final detail = _controller.executiveDetail.value;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "View Details"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel("User ID", isDark, context),
            buildReadOnlyField(context, detail?.userId ?? "-"),

            SizedBox(height: 14.h),

            buildLabel("Executive Name", isDark, context),
            buildField(context, nameController),

            SizedBox(height: 14.h),

            buildLabel("Reg. Mob No", isDark, context),
            buildField(context, mobileController, isPhoneNumber: true),

            SizedBox(height: 14.h),

            buildLabel("WhatsApp No", isDark, context),
            buildField(context, whatsappController, isPhoneNumber: true),

            SizedBox(height: 14.h),

            buildLabel("Email ID", isDark, context),
            buildField(context, emailController, isEmailAdres: true),

            SizedBox(height: 14.h),

            buildLabel("Address", isDark, context),
            buildField(context, addressController),

            SizedBox(height: 14.h),

            buildLabel("Pin Code", isDark, context),
            buildField(context, pinCodeController, isDigitsOnly: true),

            SizedBox(height: 14.h),

            buildLabel("Wallet Balance", isDark, context),
            buildReadOnlyField(context, "₹${detail?.walletBalance ?? 0.00}"),

            SizedBox(height: 14.h),

            buildLabel("Due Amount", isDark, context),
            buildReadOnlyField(
              context,
              (detail?.dueAmount ?? 0.00).currencyIndian,
              valueColor: Colors.red,
            ),

            SizedBox(height: 14.h),

            buildLabel("Commission Package", isDark, context),

            SizedBox(height: 6.h),

            DropdownButtonFormField<String>(
              initialValue: selectedPackage,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark
                    ? AppColors.darkplceholder
                    : AppColors.lightbg2,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: isDark
                        ? AppColors.darkFilterBorder
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(value: "Select", child: Text("Select")),
                DropdownMenuItem(value: "Gold", child: Text("Gold")),
                DropdownMenuItem(value: "Silver", child: Text("Silver")),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() => selectedPackage = val);
                  _markDirty();
                }
              },
            ),

            SizedBox(height: 14.h),

            buildLabel("Auto Transfer", isDark, context),

            SizedBox(height: 6.h),

            DropdownButtonFormField<String>(
              initialValue: autoTransfer,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark
                    ? AppColors.darkplceholder
                    : AppColors.lightbg2,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: isDark
                        ? AppColors.darkFilterBorder
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(value: "Auto", child: Text("Auto")),
                DropdownMenuItem(value: "Manual", child: Text("Manual")),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() => autoTransfer = val);
                  _markDirty();
                }
              },
            ),

            // SizedBox(height: 14.h),
            //
            // buildLabel("Transaction", isDark,context),
            //
            // SizedBox(height: 6.h),
            //
            // DropdownButtonFormField<String>(
            //   value: "Active",
            //   style: TextStyle(
            //     fontSize: 14.sp, // Selected value font size
            //     color: Theme.of(context).colorScheme.onSurface,
            //     fontFamily: "Poppins",
            //     fontWeight: FontWeight.w500,
            //   ),
            //
            //   decoration: InputDecoration(
            //     filled: true,
            //     fillColor: isDark
            //         ? AppColors.darkplceholder
            //         : AppColors.lightbg2,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //       borderSide: BorderSide(
            //         color: isDark
            //             ? AppColors.darkFilterBorder
            //             : Colors.grey.shade300,
            //       ),
            //     ),
            //   ),
            //   items: const [
            //     DropdownMenuItem(
            //       value: "Active",
            //       child: Text("Active"),
            //     ),
            //     DropdownMenuItem(
            //       value: "Inactive",
            //       child: Text("Inactive"),
            //     ),
            //   ],
            //   onChanged: (_) {},
            // ),
            SizedBox(height: 14.h),

            buildLabel("Created on Time", isDark, context),
            buildReadOnlyField(context, detail?.createdOnTime ?? "-"),

            SizedBox(height: 14.h),

            buildLabel("Status", isDark, context),

            SizedBox(height: 6.h),

            DropdownButtonFormField<String>(
              initialValue: status,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark
                    ? AppColors.darkplceholder
                    : AppColors.lightbg2,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: isDark
                        ? AppColors.darkFilterBorder
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(value: "Active", child: Text("Active")),
                DropdownMenuItem(value: "Inactive", child: Text("Inactive")),
              ],
              onChanged: (value) {
                setState(() {
                  status = value ?? 'Active';
                  _markDirty();
                });
              },
            ),
            const SizedBox(height: 16),

            Text(
              "Minimum Amount",
              style: TextHelper.max4.copyWith(
                color: isDark ? AppColors.textclr : AppColors.clrTextblack,
              ),
            ),
            const SizedBox(height: 8),
            buildField(context, minAmountController, isDigitsOnly: true),

            const SizedBox(height: 16),

            Text(
              "Auto Transfer Amount",
              style: TextHelper.max4.copyWith(
                color: isDark ? AppColors.textclr : AppColors.clrTextblack,
              ),
            ),
            const SizedBox(height: 8),
            buildField(
              context,
              autoTransferAmountController,
              isDigitsOnly: true,
            ),

            SizedBox(height: 30.h),

            Center(
              child: Obx(
                () => CommonButton(
                  title: "Update",
                  isLoading: _controller.isUpdatingExecutive.value,
                  onTap: _controller.isDirty.value
                      ? () {
                          if (detail?.id == null) return;

                          final data = {
                            "id": detail!.id.toString(),
                            "executive_name": nameController.text,
                            "reg_mobile_number": mobileController.text,
                            "whatsapp_number": whatsappController.text,
                            "email": emailController.text,
                            "address": addressController.text,
                            "pincode": pinCodeController.text,
                            "package_name": selectedPackage,
                            "auto_transfer": autoTransfer,
                            "minimum_amount": minAmountController.text,
                            "auto_transfer_amount":
                                autoTransferAmountController.text,
                            "status": status,
                          };

                          _controller.updateExecutive(data);
                        }
                      : () {},
                  color: _controller.isDirty.value
                      ? AppColors.clrPrimary
                      : Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
