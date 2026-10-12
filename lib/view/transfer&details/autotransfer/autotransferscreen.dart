import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/controller/auto_transfer_controller.dart';
import 'package:maxpay/controller/retailer_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/custom_toast.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transfer&details/autotransfer/widget/partner_card.dart';

class AutoTransferScreen extends StatefulWidget {
  const AutoTransferScreen({super.key});

  @override
  State<AutoTransferScreen> createState() => _AutoTransferScreenState();
}

class _AutoTransferScreenState extends State<AutoTransferScreen> {
  final AutoTransferController controller = Get.put(
    sl<AutoTransferController>(),
  );
  late final RetailerController retailerController;

  @override
  void initState() {
    super.initState();
    // Ensure AddWalletController and RetailerController are available for wallet actions
    if (!Get.isRegistered<AddWalletController>()) {
      Get.put(sl<AddWalletController>());
    }
    retailerController = Get.isRegistered<RetailerController>()
        ? Get.find<RetailerController>()
        : Get.put(sl<RetailerController>());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMappedPartners();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Partner"),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h),

            // Search filter box
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff2F3349)
                      : const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SearchBox(
                  onChanged: (val) {
                    controller.searchQuery.value = val;
                  },
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Center(
              child: SizedBox(
                width: 300.w,
                child: Divider(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
            ),

            SizedBox(height: 8.h),

            // Partner list
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    controller.fetchMappedPartners(isRefresh: true),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final partners = controller.filteredPartners;

                  if (partners.isEmpty) {
                    return Center(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Text(
                          controller.errorMessage.value.isNotEmpty
                              ? controller.errorMessage.value
                              : "No partners found.",
                          style: TextHelper.max1.copyWith(
                            color: isDark
                                ? AppColors.textclr
                                : AppColors.clrTextgrey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    itemCount: partners.length,
                    itemBuilder: (context, index) {
                      final partner = partners[index];
                      return PartnerCard(
                        partner: partner,
                        onAddWallet: () {
                          if (partner.id != null) {
                            retailerController.fetchDisWalletDetails(
                              partner.id!,
                            );
                          } else {
                            CustomToast.error("Partner ID not found");
                          }
                        },
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
