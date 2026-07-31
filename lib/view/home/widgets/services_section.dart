import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/controller/banner_controller.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';

import '../../../core/utils/texthelper.dart';
import '../../nav_page/navbar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              const HomeHeaderSection(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// WALLET CARD
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF11B4B6),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        children: [
                          Text("Wallet Balance", style: TextHelper.max16),

                          SizedBox(height: 6.h),

                          Text(
                            Get.find<AddWalletController>()
                                .walletBalance
                                .value
                                .currencyIndian,
                            style: TextHelper.lato12,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// TOP BANNER
                    Obx(() {
                      final controller = Get.find<BannerController>();
                      final banners = controller.banners;
                      if (banners.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return SizedBox(
                        height: 150.h,
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: banners.length,
                          onPageChanged: (index) {
                            controller.currentIndex.value = index;
                          },
                          itemBuilder: (context, index) {
                            final banner = banners[index];
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Image.network(
                                  banner.image ?? '',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: Colors.grey[300],
                                        child: const Center(child: Icon(Icons.error)),
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    SizedBox(height: 18.h),

                    /// SERVICES TITLE
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF11B4B6),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "Services",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    /// FIRST ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _serviceItem(
                          context,
                          "Wallet Credit",
                          AssetImages.prepaid,
                          AppColors.box1,
                          onTap: () {
                            Get.toNamed(AppRoutes.withdrawrequest1);
                          },
                        ),

                        _serviceItem(
                          context,
                          "Retailers",
                          AssetImages.dth,
                          AppColors.box2,
                          onTap: () {
                            Get.toNamed(AppRoutes.retailer);
                          },
                        ),

                        _serviceItem(
                          context,
                          "Low Wallet",
                          AssetImages.fastag,
                          AppColors.box3,
                          onTap: () {
                            Get.toNamed(AppRoutes.lowWallet);
                          },
                        ),

                        _serviceItem(
                          context,
                          "Auto Transfer",
                          AssetImages.gas,
                          AppColors.box4,
                          onTap: () {
                            Get.toNamed(AppRoutes.autoTransferScreen);
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    /// SECOND ROW
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// LEFT SIDE
                        Column(
                          children: [
                            _serviceItem(
                              context,
                              "Executive",
                              AssetImages.transactions1,
                              AppColors.box1,
                              onTap: () {
                                //Get.toNamed(AppRoutes.prepaid);
                                Get.toNamed(AppRoutes.executive);
                              },
                            ),

                            SizedBox(height: 10.h),

                            _serviceItem(
                              context,
                              "Transfer Detail",
                              AssetImages.promoFrame,
                              AppColors.box3,
                              onTap: () {
                                //Get.toNamed(AppRoutes.prepaid);
                                Get.toNamed(AppRoutes.transferDetail);
                              },
                            ),
                          ],
                        ),

                        SizedBox(width: 12.w),

                        /// CENTER BANNER
                        Expanded(
                          child: SizedBox(
                            height: 170.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                AssetImages.banner1,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    /// THIRD ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _serviceItem(
                          context,
                          "Wallet Request",
                          onTap: () {
                            Get.toNamed(AppRoutes.requestWallet);
                          },
                          AssetImages.water,
                          AppColors.box4,
                        ),

                        _serviceItem(
                          context,
                          "Out Standing",
                          AssetImages.landline,
                          AppColors.box3,
                          onTap: () {
                            Get.toNamed(AppRoutes.outstanding);
                          },
                        ),

                        _serviceItem(
                          context,
                          "Day Book",
                          AssetImages.broadband,
                          AppColors.box2,
                          onTap: () {
                            Get.toNamed(AppRoutes.dayBook);
                          },
                        ),

                        _serviceItem(
                          context,
                          "Payout Details",
                          AssetImages.statement,
                          AppColors.box1,
                          onTap: () {
                            Get.toNamed(AppRoutes.payOutDetails);
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    /// BOTTOM SECTION
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// LEFT BANNER
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              AssetImages.banner2,
                              height: 160.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        /// RIGHT SIDE
                        Column(
                          children: [
                            _serviceItem(
                              context,
                              "Pay-out Status",
                              AssetImages.paymentStatus,
                              AppColors.box2,
                              onTap: () {
                                //Get.toNamed(AppRoutes.favorite);
                                Get.toNamed(AppRoutes.payOutStatus);
                              },
                            ),

                            SizedBox(height: 8.h),

                            _serviceItem(
                              context,
                              //"DTH\nRefresh",
                              "Statement",
                              AssetImages.dthRefresh,
                              AppColors.box1,
                              onTap: () {
                                Get.toNamed(AppRoutes.statement);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _serviceItem(
    BuildContext context,
    String title,
    String image,
    Color bgColor, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 62.w,
                height: 62.w,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: SvgPicture.asset(image, fit: BoxFit.contain),
              ),

              SizedBox(height: 8.h),

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
