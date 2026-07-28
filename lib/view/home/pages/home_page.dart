import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/home/widgets/earnings_chart.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/view/home/widgets/news_ticker.dart';
import 'package:maxpay/view/home/widgets/stat_card.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 THE EARNINGS CHART
                    const EarningsChart(),

                    /// 🔹 NEWS TICKER
                    const NewsTicker(),

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
                            Get.toNamed(AppRoutes.addwallet);
                          },
                          title: 'Add Wallet',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: AppColors.card4,
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
                          textColor: isDark
                              ? const Color.fromARGB(255, 171, 171, 171)
                              : AppColors.darktextclr,
                          borderColor: AppColors.card4,
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

                            title: 'Transfer & Details',
                            textColor: Colors.white,

                            bgColor: AppColors.clrPrimary,
                            borderColor: isDark
                                ? AppColors.white
                                : AppColors.redClr,
                            imageWidget: SvgPicture.asset(
                              AssetImages.transactions,
                              height: 32.h,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        StatCard(
                          title: 'Todays Credit',
                          textColor: isDark
                              ? const Color.fromARGB(255, 171, 171, 171)
                              : AppColors.darktextclr,
                          value: '₹2500.00',

                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: AppColors.card4,
                          imageWidget: SvgPicture.asset(
                            AssetImages.todaysCredit,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: "Today's Transfer",
                          value: '₹2500.00',
                          textColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(255, 171, 171, 171)
                              : AppColors.darktextclr,
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: AppColors.card4,
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
                          textColor: isDark
                              ? const Color.fromARGB(255, 171, 171, 171)
                              : AppColors.darktextclr,
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          value: '300.00',
                          borderColor: AppColors.card4,
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
                          borderColor: AppColors.card4,
                          valueColor: AppColors.darkbgBlack,
                          imageWidget: SvgPicture.asset(
                            AssetImages.successIcon,
                            height: 25.h,
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
                          borderColor: AppColors.card4,
                          valueColor: AppColors.darkbgBlack,
                          imageWidget: SvgPicture.asset(
                            AssetImages.processIcon,
                            height: 25.h,
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
                          borderColor: AppColors.card4,
                          valueColor: AppColors.darkbgBlack,
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedIcon,
                            height: 25.h,
                          ),

                          textColor: Colors.red,
                        ),
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
