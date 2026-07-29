import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/commission_settings_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/texthelper.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class BulkPackageChangeScreen extends StatefulWidget {
  const BulkPackageChangeScreen({super.key});

  @override
  State<BulkPackageChangeScreen> createState() =>
      _BulkPackageChangeScreenState();
}

class _BulkPackageChangeScreenState extends State<BulkPackageChangeScreen> {
  final CommissionSettingsController controller = Get.put(sl<CommissionSettingsController>());
  
  int? selectedPackageId;
  String? selectedUserTypeId;
  String? selectedStatusId;

  @override
  void initState() {
    super.initState();
    // Fetch bulk options when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchBulkPackageOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: const CommonAppBar(title: "Bulk Package Change"),
      body: Obx(() {
        if (controller.isUpdating.value && controller.bulkPackageOptions.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final options = controller.bulkPackageOptions.value;
        if (options == null) {
          return const Center(child: Text("No options found."));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _label("No of Retailers"),

              TextField(
                readOnly: true,
                decoration: _inputDecoration(
                  hint: (options.noOfRetailers ?? 0).toString(),
                  isDark: isDark,
                ),
              ),

              const SizedBox(height: 15),

              _label("Package"),

              _buildDropdown<int>(
                value: selectedPackageId,
                hint: "Select",
                isDark: isDark,
                items: options.packages?.map((pkg) {
                  return DropdownMenuItem<int>(
                    value: pkg.id,
                    child: Text(pkg.packageName ?? ""),
                  );
                }).toList() ?? [],
                onChanged: (value) {
                  setState(() {
                    selectedPackageId = value;
                  });
                },
              ),
              
              const SizedBox(height: 15),

              _label("User Type"),

              _buildDropdown<String>(
                value: selectedUserTypeId,
                hint: "Select",
                isDark: isDark,
                items: options.userTypes?.map((type) {
                  return DropdownMenuItem<String>(
                    value: type.id,
                    child: Text(type.name ?? ""),
                  );
                }).toList() ?? [],
                onChanged: (value) {
                  setState(() {
                    selectedUserTypeId = value;
                  });
                },
              ),

              const SizedBox(height: 15),

              _label("Status"),

              _buildDropdown<String>(
                value: selectedStatusId,
                hint: "Select",
                isDark: isDark,
                items: options.statuses?.map((status) {
                  return DropdownMenuItem<String>(
                    value: status.id,
                    child: Text(status.name ?? ""),
                  );
                }).toList() ?? [],
                onChanged: (value) {
                  setState(() {
                    selectedStatusId = value;
                  });
                },
              ),

              const Spacer(),

              SizedBox(
                width: 170,
                child: CommonButton(
                  title: "Update",
                  onTap: () {
                    if (selectedPackageId != null && selectedStatusId != null) {
                      controller.applyBulkPackageChange(
                        packageId: selectedPackageId!,
                        status: selectedStatusId!,
                        onSuccess: () {
                          // Handle success, optionally navigate back
                          Get.back();
                        },
                      );
                    } else {
                      Get.snackbar("Error", "Please select a package and status", backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _label(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          title,
          style: TextHelper.max4,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required bool isDark,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextHelper.max4,
      filled: true,
      fillColor:
      isDark ? const Color(0xff2F3349) : const Color(0xffF8F9FA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.clrPrimary,
          width: 1.2,
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required bool isDark,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: _inputDecoration(
        hint: hint,
        isDark: isDark,
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}