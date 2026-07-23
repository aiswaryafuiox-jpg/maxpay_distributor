import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transfer&details/outstanding/widget/outstanding_card.dart';

class OutstandingScreen extends StatelessWidget {
  const OutstandingScreen({super.key});

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
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 8,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (_, index) {
              return const OutstandingCard(
                retailerName: "Klein Moriarti",
                mobileNo: "+91 9782452130",
                outstandingAmount: "₹30.00",
              );
            },
          ),
        ),
      ),
    );
  }
}