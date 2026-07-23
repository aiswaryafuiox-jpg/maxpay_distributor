import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class RetViewDetailsScreen extends StatelessWidget {
  const RetViewDetailsScreen({super.key});

  Widget buildLabel(String text, bool isDark,  BuildContext context,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextHelper.max9(context).copyWith(
          color: isDark ? AppColors.textclr : AppColors.clrTextblack,
        ),
      ),
    );
  }

  Widget buildField(
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
        color: isDark
            ? AppColors.darkplceholder
            : AppColors.lightbg2,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.shade300,
        ),
      ),
      child: Text(
        value,
        style: TextHelper.max1.copyWith(
          color: valueColor ??
              (isDark
                  ? AppColors.textclr
                  : AppColors.clrTextblack),
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
        title: "View Details",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            buildLabel("User ID", isDark,context),
            buildField(context, "U4431439269"),

            SizedBox(height: 14.h),

            buildLabel("Retailer Name", isDark,context),
            buildField(context, "John Williamson"),

            SizedBox(height: 14.h),

            buildLabel("Reg. Mob No", isDark,context),
            buildField(context, "+91 9987657260"),

            SizedBox(height: 14.h),

            buildLabel("WhatsApp No", isDark,context),
            buildField(context, "+91 9987657260"),

            SizedBox(height: 14.h),

            buildLabel("Email ID", isDark,context),
            buildField(context, "demo@gmail.com"),

            SizedBox(height: 14.h),

            buildLabel("Address", isDark,context),
            buildField(context, "Trivandrum"),

            SizedBox(height: 14.h),

            buildLabel("GST No", isDark,context),
            buildField(context, "24AAAAG3092G2P"),

            SizedBox(height: 14.h),

            buildLabel("Pin Code", isDark,context),
            buildField(context, "676206"),

            SizedBox(height: 14.h),

            buildLabel("Executive Name", isDark,context),
            buildField(context, "Klein Moriarti"),

            SizedBox(height: 14.h),

            buildLabel("Wallet Balance", isDark,context),
            buildField(context, "₹10000.00"),

            SizedBox(height: 14.h),

            buildLabel("Due Amount", isDark,context),
            buildField(
              context,
              "₹100.00",
              valueColor: Colors.red,
            ),
            buildLabel("Registration Charge", isDark,context),
            buildField(
              context,
              "₹50.00",
            ),

            SizedBox(height: 14.h),

            buildLabel("Live Wallet Amount", isDark,context),
            buildField(
              context,
              "₹3000.00",
            ),

            SizedBox(height: 14.h),

            buildLabel("Package Name", isDark,context),

            SizedBox(height: 6.h),

            DropdownButtonFormField<String>(
              value: "Silver",
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
                  vertical: 12.h,),
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
              ),
              items: const [
                DropdownMenuItem(
                  value: "Silver",
                  child: Text("Silver"),
                ),
                DropdownMenuItem(
                  value: "Gold",
                  child: Text("Gold"),
                ),
              ],
              onChanged: (_) {},
            ),

            SizedBox(height: 14.h),

            buildLabel("Auto Transfer", isDark,context),

            SizedBox(height: 6.h),

            DropdownButtonFormField<String>(
              value: "Auto",
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
                  vertical: 12.h,),
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
                DropdownMenuItem(
                  value: "Auto",
                  child: Text("Auto"),
                ),
                DropdownMenuItem(
                  value: "Manual",
                  child: Text("Manual"),
                ),
              ],
              onChanged: (_) {},
            ),

            SizedBox(height: 14.h),

            buildLabel("Transaction", isDark,context),

            SizedBox(height: 6.h),

            DropdownButtonFormField<String>(
              value: "Active",
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
                  vertical: 12.h,),
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
                DropdownMenuItem(
                  value: "Active",
                  child: Text("Active"),
                ),
                DropdownMenuItem(
                  value: "Inactive",
                  child: Text("Inactive"),
                ),
              ],
              onChanged: (_) {},
            ),

            SizedBox(height: 14.h),

            buildLabel("Created Date & Time", isDark,context),
            buildField(
              context,
              "13-03-2023 10:30:22 pm",
            ),

            SizedBox(height: 14.h),

            buildLabel("Status", isDark,context),

            SizedBox(height: 6.h),

            DropdownButtonFormField<String>(
              value: "Active",
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
                  vertical: 12.h,),
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
                DropdownMenuItem(
                  value: "Active",
                  child: Text("Active"),
                ),
                DropdownMenuItem(
                  value: "Inactive",
                  child: Text("Inactive"),
                ),
              ],
              onChanged: (_) {},
            ),

            SizedBox(height: 30.h),

            Center(
              child: CommonButton(
                title: "Update",
                onTap: () {},
              ),
            ),

            SizedBox(height: 20.h),



          ],
        ),
      ),
    );
  }
}