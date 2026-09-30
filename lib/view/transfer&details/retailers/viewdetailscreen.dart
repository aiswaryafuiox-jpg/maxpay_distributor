import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/controller/profile_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import 'package:get/get.dart';
import '../../../controller/retailer_controller.dart';
import '../../../domain/usecase/retailer/update_retailer_usecase.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class RetViewDetailsScreen extends StatefulWidget {
  const RetViewDetailsScreen({super.key});

  @override
  State<RetViewDetailsScreen> createState() => _RetViewDetailsScreenState();
}

class _RetViewDetailsScreenState extends State<RetViewDetailsScreen> {
  final RetailerController _controller = Get.find<RetailerController>();

  String? selectedPackage;
  String? selectedAutoTransfer;
  String? selectedTransaction;
  String? selectedStatus;

  bool isDirty = false;
  Map<String, String> editedFields = {};

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('id')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.fetchRetailerDetail(args['id']);
      });
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

  Widget buildField(
    BuildContext context,
    String value, {
    Color? valueColor,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    bool isPhoneNumber = false,
    bool isDigitsOnly = false,
    bool isEmailAdres = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      initialValue: value,
      readOnly: readOnly,
      onChanged: onChanged,
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
        color:
            valueColor ?? (isDark ? AppColors.textclr : AppColors.clrTextblack),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : AppColors.lightbg2,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
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
    final profileController = Get.find<ProfileController>();
    final retailerController = Get.put(sl<RetailerController>());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "View Details"),
      body: Obx(() {
        final isExecutive =
            profileController.profileData.value?.userType == "executive";
        if (_controller.isDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detail = _controller.retailerDetail.value;

        if (detail == null) {
          return const Center(child: Text("No details available."));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabel("User ID", isDark, context),
              buildField(context, detail.userId ?? "-", readOnly: true),

              SizedBox(height: 14.h),

              buildLabel("Retailer Name", isDark, context),
              buildField(
                context,
                detail.retailerName ?? "-",
                onChanged: (val) {
                  editedFields['retailerName'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Reg. Mob No", isDark, context),
              buildField(
                context,
                detail.regMobileNumber ?? "-",
                onChanged: (val) {
                  editedFields['regMobileNumber'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
                isPhoneNumber: true,
              ),

              SizedBox(height: 14.h),

              buildLabel("WhatsApp No", isDark, context),
              buildField(
                context,
                detail.whatsappNumber ?? "-",
                onChanged: (val) {
                  editedFields['whatsappNumber'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
                isPhoneNumber: true,
              ),

              SizedBox(height: 14.h),

              buildLabel("Email ID", isDark, context),
              buildField(
                context,
                detail.email ?? "-",
                isEmailAdres: true,
                onChanged: (val) {
                  editedFields['email'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Address", isDark, context),
              buildField(
                context,
                detail.address ?? "-",
                onChanged: (val) {
                  editedFields['address'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("GST No", isDark, context),
              buildField(
                context,
                detail.gstNo ?? "-",
                onChanged: (val) {
                  editedFields['gstNo'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Pin Code", isDark, context),
              buildField(
                context,
                detail.pincode ?? "-",
                isDigitsOnly: true,
                isPhoneNumber: false,

                onChanged: (val) {
                  editedFields['pincode'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Executive Name", isDark, context),
              buildField(
                context,
                detail.executiveName ?? "-",
                onChanged: (val) {
                  editedFields['executiveName'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Wallet Balance", isDark, context),
              buildField(
                context,
                isDigitsOnly: true,
                (detail.walletBalance ?? 0.00).currencyIndian,
                readOnly: true,
              ),

              SizedBox(height: 14.h),

              if (isExecutive == false) ...[
                buildLabel("Due Amount", isDark, context),
                buildField(
                  context,
                  (detail.dueAmount ?? 0.00).currencyIndian,
                  valueColor: Colors.red,
                  isDigitsOnly: true,
                  readOnly: true,
                ),
              ],

              SizedBox(height: 14.h),

              buildLabel("Registration Charge", isDark, context),
              buildField(
                context,
                "${detail.registrationCharge ?? 0}",
                isDigitsOnly: true,
                onChanged: (val) {
                  editedFields['registrationCharge'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Low Wallet Amount", isDark, context),
              buildField(
                context,
                "${detail.lowWalletAmount ?? 0}",
                isDigitsOnly: true,
                onChanged: (val) {
                  editedFields['lowWalletAmount'] = val;

                  if (!isDirty) setState(() => isDirty = true);
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Package Name", isDark, context),

              SizedBox(height: 6.h),

              DropdownButtonFormField<String>(
                initialValue: () {
                  final packages = retailerController.commissionPackages
                      .map((e) => e.packageName)
                      .where((e) => e != null)
                      .toSet();
                  String? val = selectedPackage ?? detail.packageName;
                  if (packages.contains(val)) return val;
                  if (packages.contains(val?.toLowerCase()))
                    return val?.toLowerCase();
                  return null;
                }(),
                style: TextStyle(
                  fontSize: 14.sp, // Selected value font size
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkFilterBorder
                          : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColors.clrPrimary),
                  ),
                ),
                items: retailerController.commissionPackages
                    .map((e) => e.packageName)
                    .where((e) => e != null)
                    .toSet()
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e ?? "")),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedPackage = val;
                    isDirty = true;
                  });
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Auto Transfer", isDark, context),

              SizedBox(height: 6.h),

              DropdownButtonFormField<String>(
                initialValue:
                    selectedAutoTransfer ??
                    (["Active", "Inactive"].contains(detail.autoTransfer)
                        ? detail.autoTransfer
                        : "Active"),
                style: TextStyle(
                  fontSize: 14.sp, // Selected value font size
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
                onChanged: (val) {
                  setState(() {
                    selectedAutoTransfer = val;
                    isDirty = true;
                  });
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Transaction", isDark, context),

              SizedBox(height: 6.h),

              DropdownButtonFormField<String>(
                initialValue:
                    selectedTransaction ??
                    (["Active", "Inactive"].contains(detail.transaction)
                        ? detail.transaction
                        : "Active"),
                style: TextStyle(
                  fontSize: 14.sp, // Selected value font size
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
                onChanged: (val) {
                  setState(() {
                    selectedTransaction = val;
                    isDirty = true;
                  });
                },
              ),

              SizedBox(height: 14.h),

              buildLabel("Created Date & Time", isDark, context),
              buildField(context, detail.createdAt ?? "-", readOnly: true),

              SizedBox(height: 14.h),

              buildLabel("Status", isDark, context),

              SizedBox(height: 6.h),

              DropdownButtonFormField<String>(
                initialValue:
                    selectedStatus ??
                    (["Active", "Inactive"].contains(detail.status)
                        ? detail.status
                        : "Active"),
                style: TextStyle(
                  fontSize: 14.sp, // Selected value font size
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
                onChanged: (val) {
                  setState(() {
                    selectedStatus = val;
                    isDirty = true;
                  });
                },
              ),

              SizedBox(height: 30.h),

              Obx(() {
                if (_controller.isUpdatingRetailer.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: CommonButton(
                    title: "Update",
                    onTap: isDirty
                        ? () {
                            _controller.updateRetailer(
                              UpdateRetailerParams(
                                id: detail.id?.toString() ?? "",
                                retailerName:
                                    editedFields['retailerName'] ??
                                    detail.retailerName ??
                                    "",
                                regMobileNumber:
                                    editedFields['regMobileNumber'] ??
                                    detail.regMobileNumber ??
                                    "",
                                whatsappNumber:
                                    editedFields['whatsappNumber'] ??
                                    detail.whatsappNumber ??
                                    "",
                                email:
                                    editedFields['email'] ?? detail.email ?? "",
                                address:
                                    editedFields['address'] ??
                                    detail.address ??
                                    "",
                                gstNo:
                                    editedFields['gstNo'] ?? detail.gstNo ?? "",
                                pincode:
                                    editedFields['pincode'] ??
                                    detail.pincode?.toString() ??
                                    "",
                                executiveid: detail.executiveId?.toString(),
                                registrationCharge:
                                    editedFields['registrationCharge'] ??
                                    detail.registrationCharge?.toString() ??
                                    "",
                                lowWalletAmount:
                                    editedFields['lowWalletAmount'] ??
                                    detail.lowWalletAmount?.toString() ??
                                    "",
                                autoTransferAmount:
                                    detail.autoTransferAmount?.toString() ?? "",
                                packageName:
                                    selectedPackage ??
                                    ([
                                          "Silver",
                                          "Gold",
                                        ].contains(detail.packageName)
                                        ? detail.packageName ?? "Silver"
                                        : "Silver"),
                                autoTransfer:
                                    selectedAutoTransfer ??
                                    ([
                                          "Active",
                                          "Inactive",
                                        ].contains(detail.autoTransfer)
                                        ? detail.autoTransfer ?? "Active"
                                        : "Active"),
                                status:
                                    selectedStatus ??
                                    ([
                                          "Active",
                                          "Inactive",
                                        ].contains(detail.status)
                                        ? detail.status ?? "Active"
                                        : "Active"),
                                transaction:
                                    selectedTransaction ??
                                    ([
                                          "Active",
                                          "Inactive",
                                        ].contains(detail.transaction)
                                        ? detail.transaction ?? "Active"
                                        : "Active"),
                              ),
                            );
                          }
                        : null,
                  ),
                );
              }),

              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }
}
