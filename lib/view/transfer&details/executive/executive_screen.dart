import 'package:flutter/material.dart';
import 'package:maxpay/view/transfer&details/executive/widget/executive_card.dart';
import 'package:maxpay/view/transfer&details/executive/widget/executive_top_tabs.dart';

import 'package:get/get.dart';
import '../../../controller/executive_controller.dart';
import '../../../core/constants/colors.dart';
import '../../../global_widget/custom_app.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';

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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: ExecutiveFilterWidget(),
              ),
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

class ExecutiveFilterWidget extends StatelessWidget {
  const ExecutiveFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff2F3349) : const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            initialValue: 'active',
            decoration: InputDecoration(
              fillColor: isDark ? AppColors.darkplceholder : AppColors.white,
              filled: true,
              hintText: "Select Package",
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                fontFamily: "Poppins",
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : Color(0xFFD8DFEA), // light border
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : Color(0xFFD8DFEA),
                  width: 1,
                ),
              ),
            ),
            items: ["active", 'inactive'].map((pkg) {
              return DropdownMenuItem<String>(
                value: pkg,
                child: Text(pkg.capitalize ?? 'Select'),
              );
            }).toList(),
            onChanged: (v) {},
          ),
          const SizedBox(height: 12),
          SearchBox(),
        ],
      ),
    );
  }
}
