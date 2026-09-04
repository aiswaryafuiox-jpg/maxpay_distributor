import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/controller/low_wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/controller/banner_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/ad_model.dart';
import 'package:maxpay/global_widget/wallet_balance_card.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/core/extensions/string_ext.dart';

import '../../nav_page/navbar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final HomePageController homeController = Get.find<HomePageController>();
    final LowWalletController lowWalletController = Get.put(
      LowWalletController(sl()),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchPopupMessage("Dashboard");
      lowWalletController.fetchLowWalletRetailers();
    });
    Get.put(
      BannerController(bannerUsecase: sl(), advusecase: sl()),
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// HEADER
                const HomeHeaderSection(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// WALLET CARD
                      const WalletBalanceCard(),

                      SizedBox(height: 16.h),

                      /// TOP BANNER
                      Obx(() {
                        final controller = Get.find<BannerController>();
                        final banners = controller.bannerData.value?.data ?? [];
                        if (banners.isEmpty) {
                          return _imageLoadingPlaceholder(height: 150.h);
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
                                  child: CachedNetworkImage(
                                    imageUrl: banner.image ?? '',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        _imageLoadingPlaceholder(),
                                    errorWidget: (context, error, stackTrace) =>
                                        _imageLoadingPlaceholder(),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),

                      SizedBox(height: 18.h),

                      /// SERVICES TITLE
                      Row(
                        spacing: 4,
                        children: [
                          Text(
                            "Services",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Expanded(
                            child: Divider(color: theme.colorScheme.primary),
                          ),
                        ],
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
      ),
      bottomNavigationBar: const CustomBottomNavBar(isMenuScreen: true),
    );
  }

  Future<void> _refreshPage() async {
    await Future.wait([
      Get.find<HomePageController>().fetchHomeCardData(),
      Get.find<BannerController>().fetchbanner(),
      Get.find<BannerController>().fetchadv(),
    ]);
  }

  Widget _imageLoadingPlaceholder({
    double? height,
    double? width,
    BorderRadius? borderRadius,
  }) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Image Loading ...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16.w),

              // SvgPicture.asset(
              //   AssetImages.loadingImage,
              //   width: 34.w,
              //   height: 34.w,
              //   colorFilter: const ColorFilter.mode(
              //     Colors.white,
              //     BlendMode.srcIn,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CHECK VALID AD
  // ============================================================

  bool _hasValidAd(Advertisements ad) {
    final displayImage = ad.displayImage?.trim() ?? "";
    final adImage = ad.adImage?.trim() ?? "";

    return displayImage.isNotEmpty || adImage.isNotEmpty;
  }

  /// ✅ Adapted from retailer app layout logic
  Widget _buildAdaptedLayout(BuildContext context) {
    return Obx(() {
      final LowWalletController controller = Get.find<LowWalletController>();

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
          'badge': controller.retailers.length,
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
          'title': 'Request Pending',
          'image': AssetImages.water,
          'color': AppColors.box4,
          'route': AppRoutes.requestWalletpending,
        },
        {
          'title': 'Due Amount',
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
          'title': 'Pay-out Details',
          'image': AssetImages.statement,
          'color': AppColors.box1,
          'route': AppRoutes.payOutDetails,
        },
        {
          'title': 'Pay-out',
          'image': AssetImages.paymentStatus,
          'color': AppColors.box2,
          'route': AppRoutes.payOutStatus,
        },
        {
          'title': 'Statement',
          'image': AssetImages.dthRefresh,
          'color': AppColors.box1,
          'route': AppRoutes.statement,
        },
      ];

      final bannerController = Get.find<BannerController>();
      final allAds = bannerController.advdata.value?.data?.advertisements ?? [];

      final validAds = allAds.where(_hasValidAd).toList();

      final List<Advertisements> upAds = [];
      final List<Advertisements> downAds = [];

      for (final ad in validAds) {
        final screen = (ad.imageScreen ?? "").trim().toLowerCase();
        if (screen == "up") {
          upAds.add(ad);
        }
        if (screen == "down") {
          downAds.add(ad);
        }
      }
      AppLogger.logError("ads $validAds");
      AppLogger.logError("upAds $upAds");

      return _buildServicesWithAdSlots(context, productList, upAds, downAds);
    });
  }

  /// ✅ SAFE URL HELPER — handles both full URLs and relative paths
  String _toImageUrl(String? path) {
    if (path == null || path.trim().isEmpty) return "";
    String formattedPath = path.trim().replaceAll(' ', '%20');
    if (formattedPath.startsWith("http://") ||
        formattedPath.startsWith("https://")) {
      return formattedPath;
    }
    return formattedPath.addToBase();
  }

  Widget _buildServicesWithAdSlots(
    BuildContext context,
    List<Map<String, dynamic>> productList,
    List<Advertisements> upAds,
    List<Advertisements> downAds,
  ) {
    return Column(
      children: [
        _buildFirstFourServices(context, productList),
        SizedBox(height: 18.h),
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
              child: upAds.isNotEmpty
                  ? _buildAdCarousel(context, upAds, "UP")
                  : _buildPlaceholderCard(),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        _buildFourServicesAt(context, productList, 6),
        SizedBox(height: 18.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: downAds.isNotEmpty
                  ? _buildAdCarousel(context, downAds, "DOWN")
                  : _buildPlaceholderCard(),
            ),
            SizedBox(width: 12.w),
            Column(
              children: [
                if (productList.length > 10)
                  _dynamicServiceItem(context, productList[10], 10),
                if (productList.length > 11)
                  _dynamicServiceItem(context, productList[11], 11),
              ],
            ),
          ],
        ),
        SizedBox(height: 18.h),
        _buildRemainingServices(context, productList, 12),
      ],
    );
  }

  Widget _buildAdCarousel(
    BuildContext context,
    List<Advertisements> ads,
    String position,
  ) {
    if (ads.isEmpty) {
      return _buildPlaceholderCard();
    }

    return SizedBox(
      height: 160.h,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: ads.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final ad = ads[index];
              final displayImage = (ad.displayImage ?? "").trim();
              final adImage = (ad.adImage ?? "").trim();
              final image = displayImage.isNotEmpty ? displayImage : adImage;

              if (image.isEmpty) {
                return _buildPlaceholderCard();
              }

              final imageUrl = _toImageUrl(image);
              if (imageUrl.isEmpty) {
                return _buildPlaceholderCard();
              }

              return InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  if (adImage.isEmpty) return;
                  final fullImageUrl = _toImageUrl(adImage);
                  if (fullImageUrl.isEmpty) return;
                  _showFullImage(context, [fullImageUrl], 0);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 160.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholderCard();
                    },
                  ),
                ),
              );
            },
          ),
          if (ads.length > 1)
            Positioned(
              bottom: 8.h,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(ads.length, (index) {
                    return Container(
                      width: 6.w,
                      height: 6.w,
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderCard() {
    return Container(
      height: 160.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your AD Here",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Please Contact",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ],
          ),
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstFourServices(
    BuildContext context,
    List<Map<String, dynamic>> productList,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: .start,
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
    );
  }

  Widget _buildFourServicesAt(
    BuildContext context,
    List<Map<String, dynamic>> productList,
    int startIndex,
  ) {
    if (productList.length <= startIndex) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: .start,
      children: [
        for (
          int i = startIndex;
          i < startIndex + 4 && i < productList.length;
          i++
        )
          _dynamicServiceItem(context, productList[i], i),
      ],
    );
  }

  Widget _buildRemainingServices(
    BuildContext context,
    List<Map<String, dynamic>> productList,
    int startIndex,
  ) {
    if (productList.length <= startIndex) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length - startIndex,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final actualIndex = startIndex + index;
        return _dynamicServiceItem(
          context,
          productList[actualIndex],
          actualIndex,
        );
      },
    );
  }

  void _showFullImage(
    BuildContext context,
    List<String> imageUrls,
    int initialIndex,
  ) {
    final PageController controller = PageController(initialPage: initialIndex);

    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    final imageUrl = imageUrls[index];

                    return InteractiveViewer(
                      child: Center(
                        child: Image.network(imageUrl, fit: BoxFit.contain),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
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
      badgeCount: item['badge']?.toString(),
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
    String? badgeCount,
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
              Stack(
                clipBehavior: Clip.none,
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
                  if (badgeCount != null && badgeCount.isNotEmpty)
                    Positioned(
                      top: -4.w,
                      right: -4.w,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Text(
                          badgeCount,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
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
