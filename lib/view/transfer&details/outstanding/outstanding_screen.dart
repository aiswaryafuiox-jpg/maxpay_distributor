import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/view/transfer&details/outstanding/widget/outstanding_card.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controller/outstanding_controller.dart';
// ... other imports

class OutstandingScreen extends StatefulWidget {
  const OutstandingScreen({super.key});

  @override
  State<OutstandingScreen> createState() => _OutstandingScreenState();
}

class _OutstandingScreenState extends State<OutstandingScreen> {
  final controller = Get.put(sl<OutstandingController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Outstandings")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.outstandingList.isEmpty) {
              return const Center(child: Text("No outstanding retailers"));
            }
            return ListView.separated(
              itemCount: controller.outstandingList.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (_, index) {
                final item = controller.outstandingList[index];
                return OutstandingCard(
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
