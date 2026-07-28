import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import '../nav_page/navbar_provider.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(
        title: "Support",
        onBack: () {
          Get.find<NavbarController>().setIndex(0);
        },
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _supportCard(
              context,
              isDark,
              title: "Customer Support",
              phone: "+91 0005451152",
            ),

            const SizedBox(height: 16),

            _supportCard(
              context,
              isDark,
              title: "Accounts Support",
              phone: "+91 0005451152",
            ),
          ],
        ),
      ),
    );
  }

  Widget _supportCard(
      BuildContext context,
      bool isDark, {
        required String title,
        required String phone,
      }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : Colors.grey.withValues(alpha: .12),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          /// Profile Image
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFEAEAEA),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                AssetImages.iconPerson,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// Title & Number
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextHelper.max1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? theme.colorScheme.onSurface
                        : const Color(0xFF344054),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  phone,
                  style: TextHelper.max9(context).copyWith(
                    fontSize: 16,
                    color: isDark
                        ? theme.colorScheme.onSurface.withValues(alpha: 0.8)
                        : const Color(0xFF667085),
                  ),
                ),
              ],
            ),
          ),

          /// Action Buttons
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SvgPicture.asset(
                    AssetImages.whatsapp,
                    // colorFilter: const ColorFilter.mode(
                    //   Colors.white,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SvgPicture.asset(
                    AssetImages.call,
                    // colorFilter: const ColorFilter.mode(
                    //   Colors.white,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}