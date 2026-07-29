import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/settings/commission_settings/widget/commission_card.dart';
import 'package:maxpay/controller/commission_settings_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/data/model/settings/commission_settings_model.dart';
import '../../../core/constants/colors.dart';

class CommissionSettingsScreen extends StatefulWidget {
  const CommissionSettingsScreen({super.key});

  @override
  State<CommissionSettingsScreen> createState() => _CommissionSettingsScreenState();
}

class _CommissionSettingsScreenState extends State<CommissionSettingsScreen> {
  final CommissionSettingsController controller = Get.put(sl<CommissionSettingsController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Commission Settings",
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (controller.commissionSettingsList.isEmpty) {
            return const Center(
              child: Text("No commission settings found"),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: controller.commissionSettingsList.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCommissionCard(item),
                );
              }).toList(),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCommissionCard(CommissionSettingItem item) {
    final packageName = item.packageName ?? "";
    final String badgeText = packageName;

    Gradient? badgeGradient;
    Color badgeColor;
    Color badgeTextColor;

    if (packageName.toLowerCase().contains("basic")) {
      badgeGradient = AppColors.basicGradient;
      badgeColor = const Color(0xFFB9F4E7);
      badgeTextColor = const Color(0xFF007A63);
    } else if (packageName.toLowerCase().contains("silver plus")) {
      badgeGradient = AppColors.silverPlusGradient;
      badgeColor = const Color(0xFFD9D9D9);
      badgeTextColor = const Color(0xFF333333);
    } else if (packageName.toLowerCase().contains("silver")) {
      badgeGradient = AppColors.silverGradient;
      badgeColor = const Color(0xFFE5E5E5);
      badgeTextColor = const Color(0xFF666666);
    } else if (packageName.toLowerCase().contains("gold plus")) {
      badgeGradient = AppColors.goldPlusGradient;
      badgeColor = const Color(0xFFF8D04F);
      badgeTextColor = const Color(0xFF8C5A00);
    } else if (packageName.toLowerCase().contains("gold")) {
      badgeGradient = AppColors.goldGradient;
      badgeColor = const Color(0xFFFFD979);
      badgeTextColor = const Color(0xFF9B5A00);
    } else {
      badgeGradient = AppColors.basicGradient;
      badgeColor = const Color(0xFFB9F4E7);
      badgeTextColor = const Color(0xFF007A63);
    }

    final statusText = item.status ?? "Inactive";
    Color statusColor;
    if (statusText.toLowerCase() == "active" || statusText.toLowerCase() == "enable") {
      statusColor = const Color(0xFF00BC62);
    } else if (statusText.toLowerCase() == "pending") {
      statusColor = const Color(0xFFFF9800);
    } else {
      statusColor = const Color(0xFFF40C29);
    }

    return CommissionCard(
      packageName: packageName,
      badgeText: badgeText,
      badgeGradient: badgeGradient,
      badgeColor: badgeColor,
      badgeTextColor: badgeTextColor,
      totalProducts: (item.noOfProducts ?? 0).toString(),
      updatedProducts: (item.updateProducts ?? 0).toString(),
      pendingProducts: (item.updatePending ?? 0).toString(),
      showResetButton: (item.canReset ?? 0) == 1,
      statusText: statusText,
      statusColor: statusColor,
      resetColor: const Color(0xFF17A2B8),
      onResetPressed: () {
        if (item.id != null) {
          controller.resetPackageCommission(id: item.id!);
        }
      },
      onStatusPressed: () {
        if (item.id != null) {
          String nextStatus = statusText.toLowerCase() == 'active' ? 'Inactive' : 'Active';
          controller.updatePackageStatus(
            id: item.id!,
            type: 'retailer', // Using 'retailer' as per the curl example
            status: nextStatus,
          );
        }
      },
    );
  }
}