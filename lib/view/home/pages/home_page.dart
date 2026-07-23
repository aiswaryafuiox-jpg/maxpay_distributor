import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/home/widgets/earnings_chart.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/view/home/widgets/news_ticker.dart';
import 'package:maxpay/view/home/widgets/stat_card.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';

import '../../../controller/home_controller.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 PREMIUM HEADER
              const HomeHeaderSection(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 THE EARNINGS CHART
                    const EarningsChart(),
                    SizedBox(height: 8.h),
                    /// 🔹 NEWS TICKER
                    const NewsTicker(),
                    SizedBox(height: 8.h),
                    /// 🔹 DASHBOARD GRID
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      padding: EdgeInsets.all(4.w),
                      childAspectRatio: 0.9,
                      children: [
                        StatCard(
                          onTap: () {
                            //Get.toNamed(AppRoutes.addwallet);
                            Get.toNamed(AppRoutes.addWalletScreen);
                          },
                          title: 'Add Wallet',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          border: Border.all(color: AppColors.card4),
                          imageWidget: SvgPicture.asset(

                            AssetImages.addWallet,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          onTap: () {
                            Get.toNamed(AppRoutes.walletBalance);
                          },
                          title: 'Wallet Balance',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          value: '₹25500.00',
                          textColor: const Color(0xff636363),
                          border: Border.all(color: AppColors.card4),
                          imageWidget: SvgPicture.asset(
                            AssetImages.walletBalance,
                            height: 32.h,
                          ),
                        ),
                        BlinkingZoomCard(
                          child: StatCard(
                            onTap: () {
                              Get.toNamed(AppRoutes.menu);
                            },

                            title: 'Transfer & \n Details',
                            textColor: Colors.white,

                            bgColor: AppColors.clrPrimary,
                            border: Border.all(
                              color: const Color(0xFFFF383C),
                              width: 1.5.w,
                            ),                            imageWidget: SvgPicture.asset(
                              AssetImages.transactions,
                              height: 32.h,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,),
                            ),
                          ),
                        ),
                        StatCard(
                          title: 'Todays Credit',
                          value: '₹5,000.00 /\n 20 Nos',
                          textColor: const Color(0xff636363),
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          border: Border.all(color: AppColors.card4),
                          imageWidget: SvgPicture.asset(
                            AssetImages.todaysCredit,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: "Today's Transfer",
                          value: '₹5,000.00 /\n 20 Nos',
                          textColor: const Color(0xff636363),
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          border: Border.all(color: AppColors.card4),
                          imageWidget: SvgPicture.asset(
                            AssetImages.refunded,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          onTap: () {

                            Get.toNamed(AppRoutes.myearning);
                          },
                          title: 'Today Earnings',
                          textColor: const Color(0xff636363),
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          value: '₹5,000.00 /\n 20 Nos',
                          border: Border.all(color: AppColors.card4),
                          imageWidget: SvgPicture.asset(
                            AssetImages.complaints,
                            height: 32.h,
                          ),
                        ),

                        StatCard(
                          bgColor: AppColors.card1,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.transaction,
                              arguments: TransactionStatus.success,
                            );
                          },
                          title: 'Success',
                          value: '₹5,000.00 /\n20 Nos',
                          border: Border.all(
                            color: AppColors.card4,
                            width: 1,
                          ),
                          imageWidget: SvgPicture.asset(
                            AssetImages.success,
                            height: 24.h,
                            width: 24.w,
                          ),

                          textColor: Colors.green,
                        ),
                        StatCard(
                          bgColor: AppColors.card2,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.transaction,
                              arguments: TransactionStatus.pending,
                            );
                          },
                          title: 'Processing',
                          value: '₹5,000.00 /\n20 Nos',
                          border: Border.all(
                            color: AppColors.card4,
                            width: 1,
                          ),
                          imageWidget: SvgPicture.asset(
                            AssetImages.processing,
                             height: 24.h,
                            width: 24.w,
                          ),

                          textColor: Colors.orange,
                        ),
                        StatCard(
                          bgColor: AppColors.card3,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.transaction,
                              arguments: TransactionStatus.failed,
                            );
                          },
                          title: 'Failed',
                          value: '₹5,000.00 /\n20 Nos',
                          border: Border.all(
                            color: AppColors.card4,
                            width: 1,
                          ),
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 24.h,
                            width: 24.w,
                          ),

                          textColor: Colors.red,
                        ),

                        // StatCard(
                        //   bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                        //   title: 'Upgrade Package',
                        //   border: Border.all(color: AppColors.card4),
                        //   imageWidget: SvgPicture.asset(
                        //     AssetImages.failedAll,
                        //     height: 45.h,
                        //   ),
                        // ),
                        // StatCard(
                        //   title: 'Business Group',
                        //   bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                        //   border: Border.all(color: AppColors.card4),
                        //   imageWidget: SvgPicture.asset(
                        //     AssetImages.failedAll,
                        //     height: 45.h,
                        //   ),
                        // ),
                        // StatCard(
                        //   title: 'Referral Link',
                        //   bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                        //   border: Border.all(color: AppColors.card4),
                        //   imageWidget: SvgPicture.asset(
                        //     AssetImages.failedAll,
                        //     height: 45.h,
                        //   ),
                        // ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// 🔹 SERVICES SECTION
                    // const Services
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
