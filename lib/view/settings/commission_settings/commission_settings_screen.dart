import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/settings/commission_settings/widget/commission_card.dart';

class CommissionSettingsScreen extends StatelessWidget {
  const CommissionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Commission Settings",
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// BASIC
              CommissionCard(
                packageName: "Package Name",
                badgeText: "Basic",
                badgeColor: Color(0xFFB9F4E7),
                badgeTextColor: Color(0xFF007A63),

                totalProducts: "50",
                updatedProducts: "40",
                pendingProducts: "10",

                showResetButton: false,

                statusText: "Active",
                statusColor: Color(0xFF00BC62),
              ),

              SizedBox(height: 16),

              /// SILVER
              CommissionCard(
                packageName: "Package Name",
                badgeText: "Silver",
                badgeColor: Color(0xFFE5E5E5),
                badgeTextColor: Color(0xFF666666),

                totalProducts: "50",
                updatedProducts: "40",
                pendingProducts: "10",

                showResetButton: false,

                statusText: "Active",
                statusColor: Color(0xFF00BC62),
              ),

              SizedBox(height: 16),

              /// SILVER PLUS
              CommissionCard(
                packageName: "Package Name",
                badgeText: "Silver Plus",
                badgeColor: Color(0xFFD9D9D9),
                badgeTextColor: Color(0xFF333333),

                totalProducts: "50",
                updatedProducts: "40",
                pendingProducts: "10",

                showResetButton: true,

                statusText: "Inactive",
                statusColor: Color(0xFFF40C29),

                resetColor: Color(0xFF17A2B8),
              ),

              SizedBox(height: 16),

              /// GOLD
              CommissionCard(
                packageName: "Package Name",
                badgeText: "Gold",
                badgeColor: Color(0xFFFFD979),
                badgeTextColor: Color(0xFF9B5A00),

                totalProducts: "50",
                updatedProducts: "40",
                pendingProducts: "10",

                showResetButton: false,

                statusText: "Pending",
                statusColor: Color(0xFFFF9800),
              ),

              SizedBox(height: 16),

              /// GOLD PLUS
              CommissionCard(
                packageName: "Package Name",
                badgeText: "Gold Plus",
                badgeColor: Color(0xFFF8D04F),
                badgeTextColor: Color(0xFF8C5A00),

                totalProducts: "50",
                updatedProducts: "40",
                pendingProducts: "10",

                showResetButton: false,

                statusText: "Pending",
                statusColor: Color(0xFFFF9800),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}