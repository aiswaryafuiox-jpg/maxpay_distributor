import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transfer&details/outstanding/widget/outstanding_card.dart';
import 'package:maxpay/controller/outstanding_controller.dart';
import 'package:maxpay/domain/usecase/retailer/get_outstanding_list_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/update_outstanding_usecase.dart';
import 'package:maxpay/data/repository/outstanding_repo_impl.dart';
import 'package:maxpay/core/services/api_service.dart';

class OutstandingScreen extends StatefulWidget {
  const OutstandingScreen({super.key});

  @override
  State<OutstandingScreen> createState() => _OutstandingScreenState();
}

class _OutstandingScreenState extends State<OutstandingScreen> {
  final controller = Get.put(
    OutstandingController(
      GetOutstandingListUseCase(OutstandingRepoImpl(ApiService())),
      UpdateOutstandingUseCase(OutstandingRepoImpl(ApiService())),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Outstanding",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.outstandingList.isEmpty) {
              return const Center(child: Text("No outstanding data"));
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.outstandingList.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (_, index) {
                final item = controller.outstandingList[index];
                return OutstandingCard(
                  retailerId: item.id ?? 0,
                  retailerName: item.retailerName ?? "-",
                  mobileNo: item.regMobileNumber ?? "-",
                  outstandingAmount: "₹${item.outstandingAmount ?? '0.00'}",
                );
              },
            );
          }),
        ),
      ),
    );
  }
}