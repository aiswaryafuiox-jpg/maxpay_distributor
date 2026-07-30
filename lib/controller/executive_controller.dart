import 'package:get/get.dart';
import '../core/utils/logg_helper.dart';
import '../data/model/executive/executive_list_response_model.dart';
import '../data/model/executive/executive_detail_response_model.dart';
import '../data/model/executive/executive_commission_package_response_model.dart';
import '../domain/usecase/executive/get_executives_usecase.dart';
import '../domain/usecase/executive/get_executive_detail_usecase.dart';
import '../domain/usecase/executive/get_executive_commission_packages_usecase.dart';
import '../domain/usecase/executive/update_executive_usecase.dart';
import '../domain/usecase/executive/get_executive_add_wallet_details_usecase.dart';
import '../domain/usecase/executive/add_executive_wallet_usecase.dart';
import '../domain/usecase/executive/create_executive_usecase.dart';
import '../data/model/executive/executive_add_wallet_details_response_model.dart';
import '../core/constants/routes_path.dart';

class ExecutiveController extends GetxController {
  final GetExecutivesUseCase getExecutivesUseCase;
  final GetExecutiveDetailUseCase getExecutiveDetailUseCase;
  final GetExecutiveCommissionPackagesUseCase getExecutiveCommissionPackagesUseCase;
  final UpdateExecutiveUseCase updateExecutiveUseCase;
  final GetExecutiveAddWalletDetailsUseCase getExecutiveAddWalletDetailsUseCase;
  final AddExecutiveWalletUseCase addExecutiveWalletUseCase;
  final CreateExecutiveUseCase createExecutiveUseCase;

  ExecutiveController(
    this.getExecutivesUseCase,
    this.getExecutiveDetailUseCase,
    this.getExecutiveCommissionPackagesUseCase,
    this.updateExecutiveUseCase,
    this.getExecutiveAddWalletDetailsUseCase,
    this.addExecutiveWalletUseCase,
    this.createExecutiveUseCase,
  );

  RxBool isLoading = false.obs;
  RxList<Executive> executives = <Executive>[].obs;

  RxBool isDetailLoading = false.obs;
  Rx<ExecutiveDetailData?> executiveDetail = Rx<ExecutiveDetailData?>(null);
  RxBool isDirty = false.obs;
  RxBool isUpdatingExecutive = false.obs;

  RxBool isCommissionPackagesLoading = false.obs;
  RxList<ExecutiveCommissionPackage> commissionPackages = <ExecutiveCommissionPackage>[].obs;

  RxBool isAddWalletDetailsLoading = false.obs;
  RxBool isAddWalletLoading = false.obs;
  Rx<ExecutiveAddWalletDetailsData?> exeAddWalletDetails = Rx<ExecutiveAddWalletDetailsData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchExecutives();
    fetchCommissionPackages();
  }

  Future<void> fetchExecutives() async {
    isLoading.value = true;
    final result = await getExecutivesUseCase.call();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        AppLogger.logError("Failed to fetch executives: ${failure.message}");
      },
      (data) {
        isLoading.value = false;
        executives.value = data.data?.list ?? [];
        AppLogger.debugPrint("Executives fetched successfully: ${executives.length}");
      },
    );
  }

  Future<void> fetchExecutiveDetail(String id, {bool routeToScreen = true}) async {
    isDetailLoading.value = true;
    final result = await getExecutiveDetailUseCase.call(id);

    result.fold(
      (failure) {
        isDetailLoading.value = false;
        AppLogger.logError("Failed to fetch executive detail: ${failure.message}");
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
      },
      (data) {
        isDetailLoading.value = false;
        executiveDetail.value = data.data;
        isDirty.value = false; // Reset dirty flag when new data is fetched
        
        if (routeToScreen) {
          Get.toNamed(AppRoutes.exviewDetails);
        }
      },
    );
  }

  Future<void> fetchCommissionPackages() async {
    isCommissionPackagesLoading.value = true;
    final result = await getExecutiveCommissionPackagesUseCase.call();

    result.fold(
      (failure) {
        isCommissionPackagesLoading.value = false;
        AppLogger.logError("Failed to fetch commission packages: ${failure.message}");
      },
      (data) {
        isCommissionPackagesLoading.value = false;
        commissionPackages.value = data.data ?? [];
        AppLogger.debugPrint("Commission packages fetched successfully: ${commissionPackages.length}");
      },
    );
  }

  Future<void> updateExecutive(Map<String, dynamic> data) async {
    isUpdatingExecutive.value = true;
    final result = await updateExecutiveUseCase.call(data);

    result.fold(
      (failure) {
        isUpdatingExecutive.value = false;
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
      },
      (successMessage) {
        isUpdatingExecutive.value = false;
        isDirty.value = false;
        Get.snackbar("Success", successMessage, snackPosition: SnackPosition.BOTTOM);
        
        // Refresh the detail to sync any unreturned calculated values
        if (executiveDetail.value?.id != null) {
          fetchExecutiveDetail(executiveDetail.value!.id.toString(), routeToScreen: false);
        }
      },
    );
  }

  Future<void> fetchExecutiveAddWalletDetails(String id) async {
    isAddWalletDetailsLoading.value = true;
    final result = await getExecutiveAddWalletDetailsUseCase.call(id);

    result.fold(
      (failure) {
        isAddWalletDetailsLoading.value = false;
        AppLogger.logError("Failed to fetch executive wallet details: ${failure.message}");
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
      },
      (data) {
        isAddWalletDetailsLoading.value = false;
        exeAddWalletDetails.value = data.data;
        // Navigation should be done after fetching successfully
       
      },
    );
  }

  Future<void> submitAddWallet(String id, String amount) async {
    isAddWalletLoading.value = true;
    final result = await addExecutiveWalletUseCase.call(id, amount);
    
    result.fold(
      (failure) {
        isAddWalletLoading.value = false;
        AppLogger.logError("Failed to add executive wallet: ${failure.message}");
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
      },
      (message) {
        isAddWalletLoading.value = false;
        Get.back();
        Get.snackbar("Success", message, snackPosition: SnackPosition.BOTTOM);
        // Refresh executives list to get updated balance
        fetchExecutives();
      },
    );
  }

  Future<void> createExecutive(Map<String, dynamic> data) async {
    isUpdatingExecutive.value = true;
    final result = await createExecutiveUseCase.call(data);

    result.fold(
      (failure) {
        isUpdatingExecutive.value = false;
        Get.snackbar("Error", failure.message, snackPosition: SnackPosition.BOTTOM);
      },
      (successMessage) {
        isUpdatingExecutive.value = false;
        Get.back();
        Get.snackbar("Success", successMessage, snackPosition: SnackPosition.BOTTOM);
        fetchExecutives();
      },
    );
  }
}
