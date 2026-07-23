import 'package:flutter/material.dart';

import 'package:maxpay/view/transfer&details/retailers/widgets/retailer_card.dart';
import 'package:maxpay/view/transfer&details/retailers/widgets/retailer_top_tabs.dart';

import '../../../core/constants/colors.dart';
import '../../../global_widget/custom_app.dart';

class RetailerScreen extends StatelessWidget {
  const RetailerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;


    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Retailers",

      ),
      body: SafeArea(
        child: Column(
          children: [
            const RetailerTopTabs(),
            const SizedBox(height: 18),

            Center(
              child: SizedBox(
                width: 300, // Adjust width as needed
                child: Divider(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),



            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  RetailerCard(isActive: true),
                  RetailerCard(isActive: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}