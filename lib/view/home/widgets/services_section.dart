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
                                        child: const Center(
                                          child: Icon(Icons.error),
                                        ),
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

                    /// SMART LAYOUT ADAPTED FROM RETAILER APP
                    _buildAdaptedLayout(context),
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

  /// ✅ Adapted from retailer app layout logic
  Widget _buildAdaptedLayout(BuildContext context) {
    // Define the 12 static services just like productList
    final List<Map<String, dynamic>> productList = [
      {
        'title': 'Wallet Credit',
        'image': AssetImages.prepaid,
        'color': AppColors.box1,
        'route': AppRoutes.withdrawrequest1,
      },
      {
        'title': 'Retailers',
        'image': AssetImages.dth,
        'color': AppColors.box2,
        'route': AppRoutes.retailer,
      },
      {
        'title': 'Low Wallet',
        'image': AssetImages.fastag,
        'color': AppColors.box3,
        'route': AppRoutes.lowWallet,
      },
      {
        'title': 'Auto Transfer',
        'image': AssetImages.gas,
        'color': AppColors.box4,
        'route': AppRoutes.autoTransferScreen,
      },

      {
        'title': 'Executive',
        'image': AssetImages.transactions1,
        'color': AppColors.box1,
        'route': AppRoutes.executive,
      },
      {
        'title': 'Transfer Detail',
        'image': AssetImages.promoFrame,
        'color': AppColors.box3,
        'route': AppRoutes.transferDetail,
      },

      {
        'title': 'Wallet Request',
        'image': AssetImages.water,
        'color': AppColors.box4,
        'route': AppRoutes.dueAmountAddwallet,
      },
      {
        'title': 'Out Standing',
        'image': AssetImages.landline,
        'color': AppColors.box3,
        'route': AppRoutes.outstanding,
      },
      {
        'title': 'Day Book',
        'image': AssetImages.broadband,
        'color': AppColors.box2,
        'route': AppRoutes.dayBook,
      },
      {
        'title': 'Payout Details',
        'image': AssetImages.statement,
        'color': AppColors.box1,
        'route': AppRoutes.payOutDetails,
      },

      {
        'title': 'Statement',
        'image': AssetImages.dthRefresh,
        'color': AppColors.box1,
        'route': AppRoutes.statement,
      },
      {
        'title': 'Pay-out Status',
        'image': AssetImages.paymentStatus,
        'color': AppColors.box2,
        'route': AppRoutes.payOutStatus,
      },
    ];

    return Obx(() {
      final bannerController = Get.find<BannerController>();
      final advList = bannerController.banners;
      final hasAdImage =
          advList.isNotEmpty && (advList.first.image ?? "").isNotEmpty;

      if (hasAdImage) {
        return _buildLayoutWithAds(context, productList, advList);
      } else {
        return _buildCleanGrid(context, productList);
      }
    });
  }

  /// ✅ SAFE URL HELPER — handles both full URLs and relative paths
  String _toImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    String formattedPath = path.replaceAll(' ', '%20');
    if (formattedPath.startsWith("http://") ||
        formattedPath.startsWith("https://")) {
      return formattedPath;
    }
    // Dummy return for relative paths since we don't have addToBase() here
    return formattedPath;
  }

  /// ✅ IMAGE 1 LAYOUT — with ad banners between icons
  Widget _buildLayoutWithAds(
    BuildContext context,
    List<Map<String, dynamic>> productList,
    List advList,
  ) {
    final adImageUrl1 = _toImageUrl(advList.first.image);
    final adImageUrl2 = _toImageUrl(
      advList.length > 1 ? advList[1].image : advList.first.image,
    );

    return Column(
      children: [
        /// ROW 1: icons 0,1,2,3
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (productList.isNotEmpty)
              _dynamicServiceItem(context, productList[0], 0),
            if (productList.length > 1)
              _dynamicServiceItem(context, productList[1], 1),
            if (productList.length > 2)
              _dynamicServiceItem(context, productList[2], 2),
            if (productList.length > 3)
              _dynamicServiceItem(context, productList[3], 3),
          ],
        ),

        SizedBox(height: 20.h),

        /// ROW 2: icons 4,5 + CENTER AD
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                if (productList.length > 4)
                  _dynamicServiceItem(context, productList[4], 4),
                if (productList.length > 5)
                  _dynamicServiceItem(context, productList[5], 5),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                height: 160.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    adImageUrl1,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        /// ROW 3: icons 6,7,8,9
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (productList.length > 6)
              _dynamicServiceItem(context, productList[6], 6),
            if (productList.length > 7)
              _dynamicServiceItem(context, productList[7], 7),
            if (productList.length > 8)
              _dynamicServiceItem(context, productList[8], 8),
            if (productList.length > 9)
              _dynamicServiceItem(context, productList[9], 9),
          ],
        ),

        SizedBox(height: 18.h),

        /// ROW 4: LEFT AD + icons 11,10
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _showFullImage(context, adImageUrl2),
                child: SizedBox(
                  height: 160.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      adImageUrl2,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (productList.length > 11)
                  _dynamicServiceItem(context, productList[11], 11),
                if (productList.length > 10)
                  _dynamicServiceItem(context, productList[10], 10),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// ✅ IMAGE 2 LAYOUT — clean 4-column grid
  Widget _buildCleanGrid(
    BuildContext context,
    List<Map<String, dynamic>> productList,
  ) {
    if (productList.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Text(
            "No services found",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return _dynamicServiceItem(context, productList[index], index);
      },
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (_) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: Center(
            child: Hero(
              tag: imageUrl,
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dynamicServiceItem(
    BuildContext context,
    Map<String, dynamic> item, [
    int index = 0,
  ]) {
    return _serviceItem(
      context,
      item['title'],
      item['image'],
      item['color'],
      onTap: () {
        if (item['route'] != null && item['route'].toString().isNotEmpty) {
          Get.toNamed(item['route']);
        }
      },
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
                width: 56.w,
                height: 56.w,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: SvgPicture.asset(image, fit: BoxFit.contain),
                ),
              ),

              SizedBox(height: 4.h),

              SizedBox(
                width: 70.w,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
