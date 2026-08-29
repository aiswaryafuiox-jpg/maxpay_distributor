import 'dart:async';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/data/model/ad_model.dart';
import 'package:maxpay/data/model/banner_model.dart';
import 'package:maxpay/domain/usecase/home/get_advertisement_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_banner_usecase.dart';

class BannerController extends GetxController {
  final GetBannerUseCase bannerUsecase;
  final AdvertisementUsecase advusecase;

  BannerController({required this.bannerUsecase, required this.advusecase});

  RxBool isLoading = false.obs;

  Rx<BannerModel?> bannerData = Rx<BannerModel?>(null);
  Rx<Advertisement?> advdata = Rx<Advertisement?>(null);

  RxInt currentIndex = 0.obs;
  RxInt currentAdvIndex = 0.obs;
  late PageController pageController;

  Timer? autoSlideTimer;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    fetchbanner();
    fetchadv();
  }

  Future<void> fetchbanner() async {
    isLoading.value = true;

    final result = await bannerUsecase();

    result.fold(
      (failure) {
        isLoading.value = false;
        CustomToast.error(failure.message);
      },
      (data) {
        bannerData.value = data;
        isLoading.value = false;

        startAutoSlide();
      },
    );
  }

  Future<void> fetchadv() async {
    final result = await advusecase();

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (data) {
        advdata.value = data;
      },
    );
  }

  void startAutoSlide() {
    autoSlideTimer?.cancel();

    autoSlideTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => nextBanner(),
    );
  }

  void nextBanner() {
    // 1. Update AD Index
    final adList = advdata.value?.data?.advertisements ?? [];
    if (adList.isNotEmpty) {
      int nextAd = currentAdvIndex.value + 1;
      if (nextAd >= adList.length) {
        nextAd = 0;
      }
      currentAdvIndex.value = nextAd;
    }

    // 2. Update BANNER Index
    final list = bannerData.value?.data ?? [];
    if (list.isEmpty) return;

    if (!pageController.hasClients) return;

    int next = currentIndex.value + 1;
    if (next >= list.length) {
      next = 0;
    }

    // Animate the invisible PageView. The fade effect in the UI will happen automatically
    // because currentIndex will update via onPageChanged!
    pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void previousBanner() {
    // 1. Update AD Index
    final adList = advdata.value?.data?.advertisements ?? [];
    if (adList.isNotEmpty) {
      int prevAd = currentAdvIndex.value - 1;
      if (prevAd < 0) {
        prevAd = adList.length - 1;
      }
      currentAdvIndex.value = prevAd;
    }

    // 2. Update BANNER Index
    final list = bannerData.value?.data ?? [];
    if (list.isEmpty) return;

    if (!pageController.hasClients) return;

    int previous = currentIndex.value - 1;
    if (previous < 0) {
      previous = list.length - 1;
    }

    pageController.animateToPage(
      previous,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    autoSlideTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}