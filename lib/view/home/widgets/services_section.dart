import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/controller/banner_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/data/model/ad_model.dart';
import 'package:maxpay/data/model/banner_model.dart';
import 'package:maxpay/global_widget/wallet_balance_card.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';

import '../../nav_page/navbar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final HomePageController homeController = Get.find<HomePageController>();
    final BannerController bannerController = Get.put(
      BannerController(bannerUsecase: sl()),
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

  /// ✅ PLACEHOLDER — shown when there is no advertisement/display image
  Widget _adPlaceholder({
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your AD Here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Please Contact",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              // ✅ SVG "no ad" icon — replace AssetImages.adPlaceholderImage
              // with your actual svg asset key/path (also add it in
              // AssetImages and register it under `assets:` in pubspec.yaml).
              SvgPicture.asset(
                AssetImages.loadingImage,
                width: 34.w,
                height: 34.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Wraps Image.network with a loading placeholder + graceful fallback
  /// to the "Your Ad Here" placeholder if the url is empty or fails to load.
  Widget _networkImageWithStates({
    required String imageUrl,
    required double height,
    BorderRadius? borderRadius,
    bool isAdSlot = false,
  }) {
    if (imageUrl.isEmpty) {
      return isAdSlot
          ? _adPlaceholder(height: height, borderRadius: borderRadius)
          : _imageLoadingPlaceholder(
              height: height,
              borderRadius: borderRadius,
            );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _imageLoadingPlaceholder(
          height: height,
          borderRadius: borderRadius,
        );
      },
      errorBuilder: (_, _, _) => isAdSlot
          ? _adPlaceholder(height: height, borderRadius: borderRadius)
          : Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: borderRadius ?? BorderRadius.circular(16.r),
              ),
              child: const Icon(Icons.broken_image),
            ),
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

    return Obx(() {
      final bannerController = Get.find<BannerController>();
      final advList =
          bannerController.advdata.value?.data?.advertisements ?? [];

      return _buildLayoutWithAds(
        context,
        productList,
        advList,
        bannerController.currentAdvIndex.value,
      );
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
    List<Advertisements> advList,
    int currentIndex,
  ) {
    final ad1Index = advList.isEmpty ? 0 : currentIndex % advList.length;
    final ad2Index = advList.isEmpty ? 0 : (currentIndex + 1) % advList.length;

    final adImageUrl1 = advList.isEmpty
        ? ""
        : _toImageUrl(advList[ad1Index].displayImage);
    final adImageUrl2 = advList.isEmpty
        ? ""
        : _toImageUrl(advList[ad2Index].adImage);

    return Column(
      children: [
        /// ROW 1: icons 0,1,2,3
        Row(
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
              child: InkWell(
                onTap: adImageUrl1.isEmpty
                    ? null
                    : () {
                        final urls = advList
                            .map((e) => _toImageUrl(e.displayImage))
                            .toList();
                        _showFullImage(context, urls, ad1Index);
                      },
                child: SizedBox(
                  height: 160.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: KeyedSubtree(
                        key: ValueKey<String>(adImageUrl1),
                        child: _networkImageWithStates(
                          imageUrl: adImageUrl1,
                          height: 160.h,
                          borderRadius: BorderRadius.circular(16.r),
                          isAdSlot: true,
                        ),
                      ),
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
          crossAxisAlignment: .start,
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
                onTap: adImageUrl2.isEmpty
                    ? null
                    : () {
                        final urls = advList
                            .map((e) => _toImageUrl(e.adImage))
                            .toList();
                        _showFullImage(context, urls, ad2Index);
                      },
                child: SizedBox(
                  height: 160.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: KeyedSubtree(
                        key: ValueKey<String>(adImageUrl2),
                        child: _networkImageWithStates(
                          imageUrl: adImageUrl2,
                          height: 160.h,
                          borderRadius: BorderRadius.circular(16.r),
                          isAdSlot: true,
                        ),
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
