import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
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
    final controller = Get.find<HomePageController>();

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
                    Obx(() {
                      final data = controller.homeCardData.value;

                      final successAmt = data?.success?.amount ?? 0;
                      // final successCount = data?.success?.count ?? 0;
                      final successStr = (successAmt as num).currencyIndian;

                      final processingAmt = data?.processing?.amount ?? 0;
                      // final processingCount = data?.processing?.count ?? 0;
                      final processingStr =
                          (processingAmt as num).currencyIndian;

                      final failedAmt = data?.failed?.amount ?? 0;
                      // final failedCount = data?.failed?.count ?? 0;
                      final failedStr = (failedAmt as num).currencyIndian;

                      final todayData = controller.todayTransactionData.value;
                      final todayCredit = todayData?.todaysCredit?.amount ?? 0;
                      final todayTransfer =
                          todayData?.todaysTransfer?.amount ?? 0;
                      final todayEarnings =
                          todayData?.todaysReverse?.amount ?? 0;

                      return GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        padding: EdgeInsets.all(4.w),
                        mainAxisExtent: 120.h,
                        childAspectRatio: 0.9,
                        children: [
                          StatCard(
                            onTap: () {
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
                          Obx(() {
                            final walletCtrl =
                                Get.isRegistered<AddWalletController>()
                                ? Get.find<AddWalletController>()
                                : Get.put(AddWalletController(sl(), sl()));
                            return StatCard(
                              onTap: () {
                                Get.toNamed(AppRoutes.walletBalance);
                              },
                              title: 'Wallet Balance',
                              bgColor: AppColors.darkBlue.withValues(
                                alpha: 0.04,
                              ),
                              value:
                                  walletCtrl.walletBalance.value.currencyIndian,
                              textColor: isDark
                                  ? const Color.fromARGB(255, 171, 171, 171)
                                  : AppColors.darktextclr,
                              borderColor: AppColors.card4,
                              imageWidget: SvgPicture.asset(
                                AssetImages.walletBalance,
                                height: 32.h,
                              ),
                            );
                          }),
                          BlinkingZoomCard(
                            child: StatCard(
                              onTap: () {
                                Get.toNamed(AppRoutes.menu);
                              },
                              title: 'Transfer & Details',
                              textColor: Colors.white,
                              bgColor: AppColors.clrPrimary,
                              borderWidth: 2,
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
                            value: todayCredit.currencyIndian,
                            bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                            borderColor: AppColors.card4,
                            imageWidget: SvgPicture.asset(
                              AssetImages.todaysCredit,
                              height: 32.h,
                            ),
                          ),
                          StatCard(
                            title: "Today's Transfer",
                            value: todayTransfer.currencyIndian,
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
                            value: todayEarnings.toString().currencyIndian,
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
                            value: successStr,
                            borderColor: AppColors.clrPrimary,
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
                            value: processingStr,
                            borderColor: AppColors.clrPrimary,
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
                            value: failedStr,
                            borderColor: AppColors.clrPrimary,
                            valueColor: AppColors.darkbgBlack,
                            imageWidget: SvgPicture.asset(
                              AssetImages.failedIcon,
                              height: 25.h,
                            ),
                            textColor: Colors.red,
                          ),
                        ],
                      );
                    }),

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
