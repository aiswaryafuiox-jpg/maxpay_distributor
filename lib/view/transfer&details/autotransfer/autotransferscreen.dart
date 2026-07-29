import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';
import 'package:maxpay/controller/auto_transfer_controller.dart';
import 'package:maxpay/controller/profile_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class AutoTransferScreen extends StatefulWidget {
  const AutoTransferScreen({super.key});

  @override
  State<AutoTransferScreen> createState() => _AutoTransferScreenState();
}

class _AutoTransferScreenState extends State<AutoTransferScreen> {
  final TextEditingController lowWalletController =
  TextEditingController();

  final TextEditingController transferAmountController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileController = Get.find<ProfileController>();
      final String id = profileController.profileData.value?.id?.toString() ?? "";
      controller.fetchAutoTransferDetails(id);
    });
  }

  Widget buildLabel(
      BuildContext context,
      String text,
      bool isDark,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextHelper.max9(context).copyWith(
          color: isDark
              ? AppColors.textclr
              : AppColors.clrTextblack,
        ),
      ),
    );
  }

  InputDecoration buildDecoration(
      BuildContext context,
      String hint,
      bool isDark,
      ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextHelper.max9(context).copyWith(
        color: AppColors.clrTextgrey,
      ),
      filled: true,
      fillColor: isDark
          ? AppColors.darkplceholder
          : AppColors.lightbg2,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 15.h,
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
        borderSide: BorderSide(
          color: AppColors.clrPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Auto Transfer",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              buildLabel(
                context,
                "Low Wallet",
                isDark,
              ),

              TextField(
                controller: lowWalletController,
                keyboardType: TextInputType.number,
                style: TextHelper.max9(context).copyWith(
                  color: isDark
                      ? AppColors.textclr
                      : AppColors.clrTextblack,
                ),
                decoration: buildDecoration(
                  context,
                  "Enter Wallet Amount",
                  isDark,
                ),
              ),

              SizedBox(height: 22.h),

              buildLabel(
                context,
                "Transfer Amount",
                isDark,
              ),

              TextField(
                controller: transferAmountController,
                keyboardType: TextInputType.number,
                style: TextHelper.max9(context).copyWith(
                  color: isDark
                      ? AppColors.textclr
                      : AppColors.clrTextblack,
                ),
                decoration: buildDecoration(
                  context,
                  "Enter Transfer Amount",
                  isDark,
                ),
              ),

              const Spacer(),

              Center(
                child: CommonButton(
                  title: "Update",
                  onTap: () {
                    // Update API
                  },
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}