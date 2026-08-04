import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import '../../../controller/executive_controller.dart';

import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class CreateExecutiveScreen extends StatefulWidget {
  const CreateExecutiveScreen({super.key});

  @override
  State<CreateExecutiveScreen> createState() => _CreateExecutiveScreenState();
}

class _CreateExecutiveScreenState extends State<CreateExecutiveScreen> {
  final TextEditingController executiveNameController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  String? selectedPackage;

  @override
  void dispose() {
    executiveNameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Create Executive"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Retailer Name
              Text(
                "Retailer Name",
                style: TextHelper.max4.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: executiveNameController,
                style: TextHelper.max4.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Enter Name...",
                  fillColor: isDark
                      ? AppColors.darkplceholder
                      : AppColors.lightbg2,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkFilterBorder
                          : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.clrPrimary),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Mobile
              Text(
                "Reg. Mob No",
                style: TextHelper.max4.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                style: TextHelper.max4.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Enter 10 Digit Mobile Number...",
                  fillColor: isDark
                      ? AppColors.darkplceholder
                      : AppColors.lightbg2,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkFilterBorder
                          : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.clrPrimary),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Commission Package
              Text(
                "Commission Package",
                style: TextHelper.max4.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
              ),

              const SizedBox(height: 8),

              Obx(() {
                final controller = Get.find<ExecutiveController>();
                final isLoading = controller.isCommissionPackagesLoading.value;
                final packages = controller.commissionPackages;

                return DropdownButtonFormField<String>(
                  initialValue: selectedPackage,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDark
                        ? AppColors.darkplceholder
                        : AppColors.lightbg2,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.clrPrimary),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                  hint: Text(
                    isLoading
                        ? "Loading..."
                        : (packages.isEmpty
                              ? "No packages available"
                              : "Select"),
                    style: TextHelper.max1.copyWith(
                      color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                    ),
                  ),
                  items: isLoading || packages.isEmpty
                      ? null
                      : packages.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.packageName,
                            child: Text(
                              e.packageName ?? '',
                              style: TextHelper.max4.copyWith(
                                color: isDark
                                    ? AppColors.textclr
                                    : AppColors.clrTextblack,
                              ),
                            ),
                          );
                        }).toList(),
                  onChanged: isLoading || packages.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            selectedPackage = value;
                          });
                        },
                );
              }),

              const Spacer(),

              Center(
                child: Obx(() {
                  final controller = Get.find<ExecutiveController>();
                  return CommonButton(
                    title: controller.isUpdatingExecutive.value
                        ? "Creating..."
                        : "Create",
                    onTap: controller.isUpdatingExecutive.value
                        ? () {}
                        : () {
                            final name = executiveNameController.text.trim();
                            final mobile = mobileController.text.trim();

                            if (name.isEmpty ||
                                mobile.isEmpty ||
                                selectedPackage == null) {
                              Get.snackbar(
                                "Required",
                                "All fields are required",
                              );
                              return;
                            }

                            controller.createExecutive({
                              "executive_name": name,
                              "reg_mobile_number": mobile,
                              "commission_package": selectedPackage,
                            });
                          },
                  );
                }),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
