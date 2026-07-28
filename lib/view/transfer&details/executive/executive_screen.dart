import 'package:flutter/material.dart';
import 'package:maxpay/view/transfer&details/executive/widget/executive_card.dart';
import 'package:maxpay/view/transfer&details/executive/widget/executive_top_tabs.dart';

import 'package:get/get.dart';
import '../../../controller/executive_controller.dart';
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
      appBar: const CommonAppBar(title: "Executive"),
      body: RefreshIndicator(
        onRefresh: () => Get.find<ExecutiveController>().fetchExecutives(),
        child: SafeArea(
          child: Column(
            children: [
              const ExecutiveTopTabs(),
              const SizedBox(height: 18),

              Center(
                child: SizedBox(
                  width: 300,
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
                child: GetBuilder<ExecutiveController>(
                  init: Get.find<ExecutiveController>(),
                  builder: (controller) {
                    return Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.executives.isEmpty) {
                        return const Center(
                          child: Text("No executives found."),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.executives.length,
                        itemBuilder: (context, index) {
                          final executive = controller.executives[index];
                          return ExecutiveCard(executive: executive);
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
