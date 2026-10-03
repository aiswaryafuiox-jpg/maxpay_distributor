import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/data/model/retailer/retailer_list_response_model.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';

import 'package:maxpay/view/transfer&details/retailers/widgets/retailer_card.dart';
import 'package:maxpay/view/transfer&details/retailers/widgets/retailer_top_tabs.dart';

import '../../../controller/retailer_controller.dart';
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
      appBar: const CommonAppBar(title: "Retailers"),
      body: RefreshIndicator(
        onRefresh: () => Get.find<RetailerController>().fetchRetailers(),
        child: SafeArea(
          child: Column(
            children: [
              const RetailerTopTabs(),
              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: RetailersFilterWidget(),
              ),

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
                child: GetBuilder<RetailerController>(
                  init:
                      Get.find<
                        RetailerController
                      >(), // Explicitly initialize if needed
                  builder: (controller) {
                    return Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.retailers.value.retailers?.isEmpty ??
                          true) {
                        return const Center(child: Text("No retailers found."));
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!controller.isLoadMore.value &&
                              scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
                            controller.fetchRetailers();
                          }
                          return false;
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: (controller.retailers.value.retailers?.length ?? 0) +
                              (controller.isLoadMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == (controller.retailers.value.retailers?.length ?? 0)) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final retailer =
                                controller.retailers.value.retailers?[index] ?? Retailer();
                            return RetailerCard(retailer: retailer);
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

class RetailersFilterWidget extends StatelessWidget {
  const RetailersFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerController retailerController = Get.put(
      RetailerController(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
    );

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
            initialValue: retailerController.currentStatusFilter ?? 'all',
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
              return DropdownMenuItem<String>(value: pkg, child: Text(pkg.capitalizeFirst ?? pkg));
            }).toList(),
            onChanged: (v) {
              if (v != null) {
                retailerController.fetchRetailers(isRefresh: true, statusFilter: v);
              }
            },
          ),

          const SizedBox(height: 12),

          SearchBox(
            onChanged: (v) {
              retailerController.searchQuery.value = v;
            },
          ),
        ],
      ),
    );
  }
}
