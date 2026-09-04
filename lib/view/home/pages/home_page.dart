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
        child: LayoutBuilder(
          builder: (context, constraint) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchHomeCardData();
                controller.fetchNews();
                controller.fetchTodayTransactionAmount();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 PREMIUM HEADER
                      const HomeHeaderSection(),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// 🔹 THE EARNINGS CHART
                              const EarningsChart(),

                              /// 🔹 NEWS TICKER
                              const NewsTicker(),

                              /// 🔹 DASHBOARD GRID
                              Expanded(
                                child: Obx(() {
                                  final data = controller.homeCardData.value;

                                  final successAmt = data?.success?.amount ?? 0;
                                  // final successCount = data?.success?.count ?? 0;
                                  final successStr =
                                      (successAmt as num).currencyIndian;

                                  final processingAmt =
                                      data?.processing?.amount ?? 0;
                                  // final processingCount = data?.processing?.count ?? 0;
                                  final processingStr =
                                      (processingAmt as num).currencyIndian;

                                  final failedAmt = data?.failed?.amount ?? 0;
                                  // final failedCount = data?.failed?.count ?? 0;
                                  final failedStr =
                                      (failedAmt as num).currencyIndian;

                                  final todayData =
                                      controller.todayTransactionData.value;
                                  final todayCredit =
                                      todayData?.todaysCredit?.amount ?? 0;
                                  final todayTransfer =
                                      todayData?.todaysTransfer?.amount ?? 0;
                                  final todayEarnings =
                                      todayData?.todaysReverse?.amount ?? 0;

                                  return LayoutBuilder(
                                    builder: (context, gridConstraints) {
                                      const int crossAxisCount = 3;
                                      // 9 stat cards / 3 columns = 3 rows
                                      const int rowCount = 3;

                                      final double mainSpacing = 8.h;
                                      final double crossSpacing = 8.w;

                                      // Total space consumed by gaps between rows/columns
                                      final double totalVerticalSpacing =
                                          mainSpacing * (rowCount - 1);
                                      final double totalHorizontalSpacing =
                                          crossSpacing * (crossAxisCount - 1);

                                      // Exact width/height each card gets, given the
                                      // real constraints this frame — recalculated on
                                      // every layout pass, so it adapts to any screen
                                      // size, orientation, or font-scale automatically.
                                      final double itemWidth =
                                          (gridConstraints.maxWidth -
                                              totalHorizontalSpacing) /
                                          crossAxisCount;
                                      final double itemHeight =
                                          (gridConstraints.maxHeight -
                                              totalVerticalSpacing) /
                                          rowCount;

                                      // Guard against transient zero/negative constraints
                                      final double safeAspectRatio =
                                          (itemWidth > 0 && itemHeight > 0)
                                          ? itemWidth / itemHeight
                                          : 1.0;
                                      return GridView.count(
                                        crossAxisCount: crossAxisCount,
                                        clipBehavior: Clip.none,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        mainAxisSpacing: mainSpacing,
                                        crossAxisSpacing: crossSpacing,
                                        childAspectRatio: safeAspectRatio,
                                        padding: EdgeInsets.zero,
                                        children: [
                                          StatCard(
                                            onTap: () {
                                              Get.toNamed(AppRoutes.addwallet);
                                            },
                                            titletextStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                            title: 'Add Wallet',
                                            bgColor: AppColors.clrPrimary,
                                            needSpacingbwImage: true,
                                            borderColor: AppColors.card4,
                                            imageWidget: SvgPicture.asset(
                                              AssetImages.addWallet,
                                              height: 40.h,
                                            ),
                                          ),
                                          Obx(() {
                                            final walletCtrl =
                                                Get.isRegistered<
                                                  AddWalletController
                                                >()
                                                ? Get.find<
                                                    AddWalletController
                                                  >()
                                                : Get.put(
                                                    AddWalletController(
                                                      sl(),
                                                      sl(),
                                                    ),
                                                  );
                                            return StatCard(
                                              onTap: () {
                                                Get.toNamed(
                                                  AppRoutes.walletBalance,
                                                );
                                              },

                                              title: 'Balance',
                                              titletextStyle: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: Colors.white,
                                              ),
                                              bgColor: AppColors.clrPrimary,
                                              value: walletCtrl
                                                  .walletBalance
                                                  .value
                                                  .currencyIndian,
                                              textColor: isDark
                                                  ? const Color.fromARGB(
                                                      255,
                                                      171,
                                                      171,
                                                      171,
                                                    )
                                                  : AppColors.darktextclr,
                                              borderColor: AppColors.card4,
                                              // imageWidget: SvgPicture.asset(
                                              //   AssetImages.walletBalance,
                                              //   height: 32.h,
                                              // ),
                                              valuetextStyle: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                              imageWidget: Text(
                                                "\u{20b9}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 26.sp,
                                                ),
                                              ),
                                            );
                                          }),
                                          BlinkingZoomCard(
                                            child: StatCard(
                                              onTap: () {
                                                Get.toNamed(AppRoutes.menu);
                                              },
                                              title: 'Transfer & Details',
                                              titletextStyle: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                              textColor: Colors.white,
                                              bgColor: AppColors.clrPrimary,
                                              borderWidth: 3,
                                              borderColor: isDark
                                                  ? AppColors.white
                                                  : AppColors.redClr,
                                              imageWidget: SvgPicture.asset(
                                                AssetImages.transactions,
                                                height: 32.h,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                      Colors.white,
                                                      BlendMode.srcIn,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          StatCard(
                                            title: 'Todays Credit',
                                            textColor: isDark
                                                ? const Color.fromARGB(
                                                    255,
                                                    171,
                                                    171,
                                                    171,
                                                  )
                                                : AppColors.darktextclr,
                                            value: todayCredit.currencyIndian,
                                            bgColor: AppColors.darkBlue
                                                .withValues(alpha: 0.04),
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
                                                Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? const Color.fromARGB(
                                                    255,
                                                    171,
                                                    171,
                                                    171,
                                                  )
                                                : AppColors.darktextclr,
                                            bgColor: AppColors.darkBlue
                                                .withValues(alpha: 0.04),
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
                                                ? const Color.fromARGB(
                                                    255,
                                                    171,
                                                    171,
                                                    171,
                                                  )
                                                : AppColors.darktextclr,
                                            bgColor: AppColors.darkBlue
                                                .withValues(alpha: 0.04),
                                            value: todayEarnings
                                                .toString()
                                                .currencyIndian,
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
                                                arguments:
                                                    TransactionStatus.success,
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
                                                arguments:
                                                    TransactionStatus.pending,
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
                                                arguments:
                                                    TransactionStatus.failed,
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
                                    },
                                  );
                                }),
                              ),

                              /// 🔹 SERVICES SECTION
                              // const Services
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
