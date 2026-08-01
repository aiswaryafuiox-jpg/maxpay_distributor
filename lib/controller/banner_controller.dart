import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/banner_model.dart';
import 'package:maxpay/domain/usecase/home/get_banner_usecase.dart';

class BannerController extends GetxController {
  final GetBannerUseCase getBannerUseCase;

  BannerController(this.getBannerUseCase);

  RxBool isLoading = false.obs;
  RxList<BannerData> banners = <BannerData>[].obs;
  RxInt currentIndex = 0.obs;

  late PageController pageController;
  Timer? autoSlideTimer;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    isLoading.value = true;
    final result = await getBannerUseCase.call();
    result.fold(
      (failure) {
        isLoading.value = false;
        AppLogger.logError("Failed to fetch banners: ${failure.message}");
      },
      (data) {
        if (data.data != null) {
          banners.value = data.data!;
        }
        isLoading.value = false;
        startAutoSlide();
      },
    );
  }

  void startAutoSlide() {
    autoSlideTimer?.cancel();
    if (banners.isNotEmpty) {
      autoSlideTimer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => nextBanner(),
      );
    }
  }

  void nextBanner() {
    if (banners.isEmpty) return;
    if (!pageController.hasClients) return;

    int next = currentIndex.value + 1;
    if (next >= banners.length) {
      next = 0;
    }

    pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    currentIndex.value = next;
  }

  void previousBanner() {
    if (banners.isEmpty) return;
    if (!pageController.hasClients) return;

    int previous = currentIndex.value - 1;
    if (previous < 0) {
      previous = banners.length - 1;
    }

    pageController.animateToPage(
      previous,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    currentIndex.value = previous;
  }

  @override
  void onClose() {
    autoSlideTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
