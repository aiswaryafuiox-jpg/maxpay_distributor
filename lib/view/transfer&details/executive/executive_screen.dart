import 'package:flutter/material.dart';
import 'package:maxpay/view/transfer&details/executive/widget/executive_card.dart';
import 'package:maxpay/view/transfer&details/executive/widget/executive_top_tabs.dart';


import '../../../core/constants/colors.dart';
import '../../../global_widget/custom_app.dart';

class ExecutiveScreen extends StatelessWidget {
  const ExecutiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;


    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Executive",

      ),
      body: SafeArea(
        child: Column(
          children: [
            const ExecutiveTopTabs(),
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
                  ExecutiveCard(isActive: true),
                  ExecutiveCard(isActive: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}