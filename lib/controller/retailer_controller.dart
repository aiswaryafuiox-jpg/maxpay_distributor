import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import '../core/utils/logg_helper.dart';
import '../data/model/retailer/retailer_list_response_model.dart';
import '../data/model/retailer/retailer_detail_response_model.dart';
import '../data/model/retailer/commission_package_response_model.dart';
import '../data/model/retailer/add_wallet_details_response_model.dart';
import '../domain/usecase/retailer/create_retailer_usecase.dart';
import '../domain/usecase/retailer/update_retailer_usecase.dart';
import '../domain/usecase/retailer/get_add_wallet_details_usecase.dart';
import '../domain/usecase/retailer/add_wallet_usecase.dart';
import '../domain/usecase/retailer/get_retailers_usecase.dart';
import '../domain/usecase/retailer/get_retailer_detail_usecase.dart';
import '../domain/usecase/retailer/get_commission_packages_usecase.dart';
import '../view/transfer&details/retailers/addwalletscreen.dart';

class RetailerController extends GetxController {
  final GetRetailersUseCase getRetailersUseCase;
  final GetRetailerDetailUseCase getRetailerDetailUseCase;
  final GetCommissionPackagesUseCase getCommissionPackagesUseCase;
  final CreateRetailerUseCase createRetailerUseCase;
  final UpdateRetailerUseCase updateRetailerUseCase;
  final GetAddWalletDetailsUseCase getAddWalletDetailsUseCase;
  final AddWalletUseCase addWalletUseCase;

  RetailerController(
    this.getRetailersUseCase,
    this.getRetailerDetailUseCase,
    this.getCommissionPackagesUseCase,
    this.createRetailerUseCase,
    this.updateRetailerUseCase,
    this.getAddWalletDetailsUseCase,
    this.addWalletUseCase,
  );

  RxBool isLoading = false.obs;
  RxList<Retailer> retailers = <Retailer>[].obs;

  RxBool isDetailLoading = false.obs;
  Rx<RetailerDetailData?> retailerDetail = Rx<RetailerDetailData?>(null);

  RxBool isPackagesLoading = false.obs;
  RxList<CommissionPackageData> commissionPackages =
      <CommissionPackageData>[].obs;

  RxBool isCreatingRetailer = false.obs;
  RxBool isUpdatingRetailer = false.obs;

  RxBool isAddWalletLoading = false.obs;
  Rx<AddWalletDetailsData?> addWalletDetails = Rx<AddWalletDetailsData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchRetailers();
  }

  Future<void> fetchRetailers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null || token.isEmpty) {
      return;
    }

    isLoading.value = true;
    final result = await getRetailersUseCase.call();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError("Failed to fetch retailers: ${failure.message}");
      },
      (data) {
        isLoading.value = false;
        retailers.value = data.data?.list ?? [];
        AppLogger.debugPrint(
          "Retailers fetched successfully: ${retailers.length} items",
        );
      },
    );
  }

  Future<void> fetchRetailerDetail(String id) async {
    isDetailLoading.value = true;
    retailerDetail.value = null; // reset old data
    final result = await getRetailerDetailUseCase.call(id);

    result.fold(
      (failure) {
        isDetailLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError(
          "Failed to fetch retailer detail: ${failure.message}",
        );
      },
      (data) {
        isDetailLoading.value = false;
        retailerDetail.value = data.data;
        AppLogger.debugPrint("Retailer detail fetched successfully");
      },
    );
  }

  Future<void> fetchCommissionPackages() async {
    isPackagesLoading.value = true;
    final result = await getCommissionPackagesUseCase.call();

    result.fold(
      (failure) {
        isPackagesLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError(
          "Failed to fetch commission packages: ${failure.message}",
        );
      },
      (data) {
        isPackagesLoading.value = false;
        commissionPackages.value = data.data ?? [];
        AppLogger.debugPrint(
          "Commission packages fetched successfully: ${commissionPackages.length} items",
        );
      },
    );
  }

  Future<void> createRetailer(CreateRetailerParams params) async {
    isCreatingRetailer.value = true;
    final result = await createRetailerUseCase.call(params);

    result.fold(
      (failure) {
        isCreatingRetailer.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError("Failed to create retailer: ${failure.message}");
      },
      (data) async {
        isCreatingRetailer.value = false;
        Get.back(); // Navigate back
        Get.snackbar(
          "Success",
          data.message ?? "Retailer created successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.debugPrint("Retailer created successfully");
        await fetchRetailers(); // Refresh the list
      },
    );
  }

  Future<void> updateRetailer(UpdateRetailerParams params) async {
    isUpdatingRetailer.value = true;
    final result = await updateRetailerUseCase.call(params);

    result.fold(
      (failure) {
        isUpdatingRetailer.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError("Failed to update retailer: ${failure.message}");
      },
      (data) async {
        isUpdatingRetailer.value = false;
        Get.back(); // Navigate back
        Get.snackbar(
          "Success",
          data.message ?? "Retailer updated successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.debugPrint("Retailer updated successfully");
        await fetchRetailers(); // Refresh the list
      },
    );
  }

  Future<void> fetchAddWalletDetails(String id) async {
    isAddWalletLoading.value = true;
    final result = await getAddWalletDetailsUseCase.call(id);

    result.fold(
      (failure) {
        isAddWalletLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError(
          "Failed to fetch add wallet details: ${failure.message}",
        );
      },
      (data) {
        isAddWalletLoading.value = false;
        addWalletDetails.value = data.data;
        AppLogger.debugPrint("Add wallet details fetched successfully");
        Get.to(() => const RetAddWalletScreen());
        Get.find<AddWalletController>().fetchWalletBalance();
      },
    );
  }

  Future<void> submitAddWallet(String id, String amount) async {
    isAddWalletLoading.value = true;
    final params = AddWalletParams(id: id, amount: amount);
    final result = await addWalletUseCase.call(params);

    result.fold(
      (failure) {
        isAddWalletLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError("Failed to add wallet: ${failure.message}");
      },
      (data) {
        isAddWalletLoading.value = false;

        AppLogger.debugPrint("Add wallet submitted successfully");
        fetchRetailers(); // Refresh the list to reflect new balances
        Get.back(); // Go back from Add Wallet screen
        Get.snackbar(
          "Success",
          data.message ?? "Wallet transferred successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50), // Green for success
          colorText: const Color(0xFFFFFFFF),
        );
      },
    );
  }
}
