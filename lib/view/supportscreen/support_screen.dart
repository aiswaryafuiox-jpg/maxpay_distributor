import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controller/support_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../nav_page/navbar_provider.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final supportController = Get.put(sl<SupportController>());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(
        title: "Support",
        onBack: () {
          Get.find<NavbarController>().setIndex(0);
        },
      ),

      body: SafeArea(
        child: Obx(() {
          if (supportController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (supportController.errorMessage.isNotEmpty) {
            return Center(child: Text(supportController.errorMessage.value));
          }

          final list = supportController.supportData.value?.list ?? [];

          if (list.isEmpty) {
            return const Center(child: Text("No support contacts available."));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final contact = list[index];
              return _supportCard(
                context,
                isDark,
                title: contact.title ?? "Support",
                phone: contact.phoneNumber ?? "",
                whatsappNumber: contact.whatsappNumber ?? "",
                whatsappEnabled: contact.whatsappEnabled == 1,
                callEnabled: contact.callEnabled == 1,
              );
            },
          );
        }),
      ),
    );
  }

  Widget _supportCard(
    BuildContext context,
    bool isDark, {
    required String title,
    required String phone,
    required String whatsappNumber,
    bool whatsappEnabled = true,
    bool callEnabled = true,
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
          Card(
            elevation: 12,
            shadowColor: AppColors.silverLight,
            shape: CircleBorder(),
            child: Container(
              height: 53,
              width: 53,
              padding: EdgeInsets.all(8),
              child: FittedBox(
                fit: .scaleDown,
                child: SvgPicture.asset(AssetImages.logo),
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
              if (whatsappEnabled)
                GestureDetector(
                  onTap: () async {
                    if (whatsappNumber.isEmpty) return;
                    final cleanPhone = whatsappNumber.replaceAll(
                      RegExp(r'\D'),
                      '',
                    );
                    final formattedPhone = cleanPhone.length == 10
                        ? '91$cleanPhone'
                        : cleanPhone;
                    final url = Uri.parse("https://wa.me/$formattedPhone");
                    try {
                      final launched = await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                      if (!launched) {
                        Get.snackbar("Error", "Could not open WhatsApp");
                      }
                    } catch (e) {
                      Get.snackbar("Error", "Could not open WhatsApp");
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.clrPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: SvgPicture.asset(AssetImages.whatsapp),
                  ),
                ),

              if (whatsappEnabled && callEnabled) const SizedBox(height: 8),

              if (callEnabled)
                GestureDetector(
                  onTap: () async {
                    if (phone.isEmpty) return;
                    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
                    final url = Uri.parse("tel:$cleanPhone");
                    try {
                      final launched = await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                      if (!launched) {
                        Get.snackbar("Error", "Could not open phone dialer");
                      }
                    } catch (e) {
                      Get.snackbar("Error", "Could not open phone dialer");
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.clrPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: SvgPicture.asset(AssetImages.call),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
