import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/controller/profile_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:get/get.dart';
import '../../../controller/retailer_controller.dart';
import '../../../data/model/retailer/retailer_detail_response_model.dart';
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
  late TextEditingController _lowWalletController;

  @override
  void initState() {
    super.initState();
    _lowWalletController = TextEditingController();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('id')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.fetchRetailerDetail(args['id']);
      });
    }
  }

  @override
  void dispose() {
    _lowWalletController.dispose();
    super.dispose();
  }

  void _showAutoTransferDialog(
    BuildContext context,
    RetailerDetailData detail,
    String previousVal,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final lowWalletVal =
        editedFields['lowWalletAmount'] ??
        (_lowWalletController.text.trim().isNotEmpty
            ? _lowWalletController.text.trim()
            : (detail.lowWalletAmount != null
                  ? detail.lowWalletAmount.toString()
                  : "0"));

    final lowWalletController = TextEditingController(text: lowWalletVal);

    final transferAmountController = TextEditingController(
      text:
          editedFields['autoTransferAmount'] ??
          (detail.autoTransferAmount != null && detail.autoTransferAmount != 0
              ? detail.autoTransferAmount.toString()
              : ""),
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkplceholder : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          title: Text(
            "Are you sure to Auto Transfer",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.clrSecondary,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Low Wallet Amount",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                  ),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: lowWalletController,
                  readOnly: true,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDark
                        ? AppColors.darkplceholder
                        : AppColors.lightbg2,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  "Transfer Amount",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                  ),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: transferAmountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.clrPrimary),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: SizedBox(
                    width: 140.w,
                    height: 42.h,
                    child: ElevatedButton(
                      onPressed: () {
                        final lowVal = lowWalletController.text.trim();
                        final transferVal = transferAmountController.text
                            .trim();
                        if (transferVal.isEmpty) {
                          Get.snackbar(
                            "Required",
                            "Please enter Transfer Amount",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }
                        Navigator.pop(dialogContext, true);
                        setState(() {
                          editedFields['lowWalletAmount'] = lowVal;
                          editedFields['autoTransferAmount'] = transferVal;
                          selectedAutoTransfer = "Active";
                          isDirty = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.clrPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((submitted) {
      if (submitted != true) {
        if (selectedAutoTransfer != "Active") {
          setState(() {
            selectedAutoTransfer = previousVal;
          });
        }
      }
    });
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

        if (_lowWalletController.text.isEmpty &&
            !editedFields.containsKey('lowWalletAmount')) {
          _lowWalletController.text = "${detail.lowWalletAmount ?? 0}";
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
                readOnly: true,
                isPhoneNumber: true,
              ),

              SizedBox(height: 14.h),

              buildLabel("WhatsApp No", isDark, context),
              buildField(
                context,
                detail.whatsappNumber ?? "-",
                readOnly: true,
                isPhoneNumber: true,
              ),

              SizedBox(height: 14.h),

              buildLabel("Email ID", isDark, context),
              buildField(
                context,
                detail.email ?? "-",
                isEmailAdres: true,
                readOnly: true,
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
              buildField(context, detail.gstNo ?? "-", readOnly: true),

              SizedBox(height: 14.h),

              buildLabel("Pin Code", isDark, context),
              buildField(
                context,
                detail.pincode ?? "-",
                isDigitsOnly: true,
                isPhoneNumber: false,
                readOnly: true,
              ),

              SizedBox(height: 14.h),

              buildLabel("Executive Name", isDark, context),
              buildField(context, detail.executiveName ?? "-", readOnly: true),

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
              TextFormField(
                controller: _lowWalletController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (val) {
                  editedFields['lowWalletAmount'] = val;
                  if (!isDirty) setState(() => isDirty = true);
                },
                style: TextHelper.max1.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark
                      ? AppColors.darkplceholder
                      : AppColors.lightbg2,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
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
                    borderSide: const BorderSide(color: AppColors.clrPrimary),
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              buildLabel("Package Name", isDark, context),

              SizedBox(height: 6.h),

              if ((detail.executiveId != null &&
                      detail.executiveId.toString().trim().isNotEmpty &&
                      detail.executiveId.toString() != "0" &&
                      detail.executiveId.toString().toLowerCase() != "null") ||
                  (detail.executiveName != null &&
                      detail.executiveName.toString().trim().isNotEmpty &&
                      detail.executiveName.toString() != "-" &&
                      detail.executiveName.toString().toLowerCase() != "null"))
                buildField(context, detail.packageName ?? "-", readOnly: true)
              else
                DropdownButtonFormField<String>(
                  initialValue: () {
                    String? val = selectedPackage ?? detail.packageName;
                    return (val != null && val.trim().isNotEmpty) ? val : null;
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
                  items: () {
                    final packages = retailerController.commissionPackages
                        .map((e) => e.packageName)
                        .where(
                          (e) => e != null && e.toString().trim().isNotEmpty,
                        )
                        .map((e) => e.toString())
                        .toSet();

                    String? val = selectedPackage ?? detail.packageName;
                    if (val != null && val.trim().isNotEmpty) {
                      packages.add(val);
                    }

                    return packages
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList();
                  }(),
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
                key: ValueKey(
                  selectedAutoTransfer ??
                      ((detail.autoTransfer != null &&
                              [
                                "Active",
                                "Inactive",
                              ].contains(detail.autoTransfer))
                          ? detail.autoTransfer!
                          : "Select"),
                ),
                initialValue:
                    selectedAutoTransfer ??
                    ((detail.autoTransfer != null &&
                            [
                              "Active",
                              "Inactive",
                            ].contains(detail.autoTransfer))
                        ? detail.autoTransfer!
                        : "Select"),
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
                  DropdownMenuItem(value: "Select", child: Text("Select")),
                  DropdownMenuItem(value: "Active", child: Text("Active")),
                  DropdownMenuItem(value: "Inactive", child: Text("Inactive")),
                ],
                onChanged: (val) {
                  if (val == null) return;
                  final currentVal =
                      selectedAutoTransfer ??
                      ((detail.autoTransfer != null &&
                              [
                                "Active",
                                "Inactive",
                              ].contains(detail.autoTransfer))
                          ? detail.autoTransfer!
                          : "Select");
                  if (val == "Active") {
                    _showAutoTransferDialog(context, detail, currentVal);
                  } else if (val == "Inactive") {
                    setState(() {
                      selectedAutoTransfer = "Inactive";
                      isDirty = true;
                    });
                  } else {
                    setState(() {
                      selectedAutoTransfer = "Select";
                      isDirty = true;
                    });
                  }
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
                                    (_lowWalletController.text.trim().isNotEmpty
                                        ? _lowWalletController.text.trim()
                                        : (detail.lowWalletAmount?.toString() ??
                                              "")),
                                autoTransferAmount:
                                    editedFields['autoTransferAmount'] ??
                                    detail.autoTransferAmount?.toString() ??
                                    "",
                                packageName:
                                    selectedPackage ??
                                    ([
                                          "Silver",
                                          "Gold",
                                        ].contains(detail.packageName)
                                        ? detail.packageName ?? "Silver"
                                        : "Silver"),
                                autoTransfer:
                                    (selectedAutoTransfer != null &&
                                        selectedAutoTransfer != "Select")
                                    ? selectedAutoTransfer!
                                    : (detail.autoTransfer ?? "Inactive"),
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
