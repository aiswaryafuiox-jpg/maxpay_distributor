import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';


import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class CreateExecutiveScreen extends StatefulWidget {
  const CreateExecutiveScreen({super.key});

  @override
  State<CreateExecutiveScreen> createState() => _CreateExecutiveScreenState();
}

class _CreateExecutiveScreenState extends State<CreateExecutiveScreen> {
  final TextEditingController executiveNameController =
  TextEditingController(text: "John Williamson");

  final TextEditingController mobileController =
  TextEditingController(text: "+91 982345755");

  String? selectedPackage;

  final List<String> packages = [
    "Silver",
    "Gold",
    "Platinum",
  ];

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
      appBar: const CommonAppBar(
        title: "Create Executive",
      ),
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
                  color: isDark
                      ? AppColors.textclr
                      : AppColors.clrTextblack,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: executiveNameController,
                style: TextHelper.max4.copyWith(
                  color: isDark
                      ? AppColors.textclr
                      : AppColors.clrTextblack,
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
                    borderSide:
                    BorderSide(color: AppColors.clrPrimary),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Mobile
              Text(
                "Reg. Mob No",
                style: TextHelper.max4.copyWith(
                  color: isDark
                      ? AppColors.textclr
                      : AppColors.clrTextblack,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                style: TextHelper.max4.copyWith(
                  color: isDark
                      ? AppColors.textclr
                      : AppColors.clrTextblack,
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
                    borderSide:
                    BorderSide(color: AppColors.clrPrimary),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Commission Package
              Text(
                "Commission Package",
                style: TextHelper.max4.copyWith(
                  color: isDark
                      ? AppColors.textclr
                      : AppColors.clrTextblack,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
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
                    borderSide:
                    BorderSide(color: AppColors.clrPrimary),
                  ),
                ),
                hint: Text(
                  "Select",
                  style: TextHelper.max1.copyWith(
                    color: isDark
                        ? AppColors.textclr
                        : AppColors.clrTextgrey,
                  ),
                ),
                items: packages.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
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
              ),

              const Spacer(),

              Center(
                child: CommonButton(
                  title: "Update",
                  onTap: () {},
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}