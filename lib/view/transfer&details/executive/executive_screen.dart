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

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!controller.isLoadMore.value &&
                              scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
                            controller.fetchExecutives();
                          }
                          return false;
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.executives.length + (controller.isLoadMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.executives.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final executive = controller.executives[index];
                            return ExecutiveCard(executive: executive);
                          },
                        ),
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
            initialValue: Get.find<ExecutiveController>().currentStatusFilter ?? 'all',
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
            items: ["all", "active", 'inactive'].map((pkg) {
              return DropdownMenuItem<String>(
                value: pkg,
                child: Text(pkg.capitalize ?? 'Select'),
              );
            }).toList(),
            onChanged: (v) {
              if (v != null) {
                Get.find<ExecutiveController>().fetchExecutives(isRefresh: true, statusFilter: v);
              }
            },
          ),
          const SizedBox(height: 12),
          SearchBox(
            onChanged: (v) {
              Get.find<ExecutiveController>().searchQuery.value = v;
            },
          ),
        ],
      ),
    );
  }
}
