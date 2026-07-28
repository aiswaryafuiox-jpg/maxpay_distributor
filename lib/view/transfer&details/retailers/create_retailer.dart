import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/retailer_controller.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/texthelper.dart';
import '../../../domain/usecase/retailer/create_retailer_usecase.dart';

import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class CreateRetailerScreen extends StatefulWidget {
  const CreateRetailerScreen({super.key});

  @override
  State<CreateRetailerScreen> createState() => _CreateRetailerScreenState();
}

class _CreateRetailerScreenState extends State<CreateRetailerScreen> {
  final TextEditingController retailerNameController = TextEditingController(
    text: "",
  );

  final TextEditingController mobileController = TextEditingController(
    text: "",
  );

  final TextEditingController addressController = TextEditingController(
    text: "",
  );

  final TextEditingController pincodeController = TextEditingController(
    text: "",
  );

  final TextEditingController registrationChargeController =
      TextEditingController(text: "");

  String? selectedPackage;

  final RetailerController _retailerController = Get.find<RetailerController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _retailerController.fetchCommissionPackages();
    });
  }

  @override
  void dispose() {
    retailerNameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    registrationChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Create Retailer"),
      body: SafeArea(
        child: SingleChildScrollView(
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
                controller: retailerNameController,
                style: TextHelper.max4.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                style: TextHelper.max4.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextblack,
                ),
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
                if (_retailerController.isPackagesLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

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
                  ),
                  hint: Text(
                    "Select",
                    style: TextHelper.max1.copyWith(
                      color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                    ),
                  ),
                  items: _retailerController.commissionPackages.map((e) {
                    return DropdownMenuItem(
                      value: e.packageName,
                      child: Text(
                        e.packageName ?? "-",
                        style: TextHelper.max4.copyWith(
                          color: isDark
                              ? AppColors.textclr
                              : AppColors.clrTextblack,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPackage = value;
                    });
                  },
                );
              }),

              const SizedBox(height: 30),

              Obx(() {
                if (_retailerController.isCreatingRetailer.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: CommonButton(
                    title: "Create",
                    onTap: () {
                      if (retailerNameController.text.isEmpty ||
                          mobileController.text.isEmpty ||
                          selectedPackage == null) {
                        Get.snackbar("Error", "Please fill all fields");
                        return;
                      }

                      _retailerController.createRetailer(
                        CreateRetailerParams(
                          retailerName: retailerNameController.text,
                          regMobileNumber: mobileController.text,
                          commissionPackage: selectedPackage!,
                          billingAddress: addressController.text,
                          pincode: pincodeController.text,
                          registrationCharge: registrationChargeController.text,
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
