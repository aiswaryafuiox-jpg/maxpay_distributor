import 'package:maxpay/core/utils/custom_snackbar.dart';
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
  final GetExecutiveCommissionPackagesUseCase
  getExecutiveCommissionPackagesUseCase;
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
  RxBool isLoadMore = false.obs;
  int currentPage = 1;
  bool hasMorePages = true;
  String? currentStatusFilter;
  RxString searchQuery = ''.obs;
  RxList<Executive> executives = <Executive>[].obs;
  Rx<ExecutiveListData> executivesData = ExecutiveListData().obs;
  RxInt executiveCount = 0.obs;

  RxBool isDetailLoading = false.obs;
  Rx<ExecutiveDetailData?> executiveDetail = Rx<ExecutiveDetailData?>(null);
  RxBool isDirty = false.obs;
  RxBool isUpdatingExecutive = false.obs;

  RxBool isCommissionPackagesLoading = false.obs;
  RxList<ExecutiveCommissionPackage> commissionPackages =
      <ExecutiveCommissionPackage>[].obs;

  RxBool isAddWalletDetailsLoading = false.obs;
  RxBool isAddWalletLoading = false.obs;
  Rx<ExecutiveAddWalletDetailsData?> exeAddWalletDetails =
      Rx<ExecutiveAddWalletDetailsData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchExecutives();
    fetchCommissionPackages();
    debounce(
      searchQuery,
      (_) => fetchExecutives(isRefresh: true),
      time: const Duration(milliseconds: 500),
    );
  }

  Future<void> fetchExecutives({
    bool isRefresh = false,
    String? statusFilter,
  }) async {
    if (isRefresh || statusFilter != null) {
      currentPage = 1;
      hasMorePages = true;
      if (statusFilter != null) currentStatusFilter = statusFilter;
      isLoading.value = true;
    } else {
      if (!hasMorePages || isLoadMore.value || isLoading.value) return;
      isLoadMore.value = true;
    }

    final String? filterVal = currentStatusFilter == 'active'
        ? '1'
        : (currentStatusFilter == 'inactive' ? '0' : null);

    final params = GetExecutivesParams(
      page: currentPage,
      isActive: filterVal,
      search: searchQuery.value,
    );
    final result = await getExecutivesUseCase.call(params);

    result.fold(
      (failure) {
        isLoading.value = false;
        isLoadMore.value = false;
        CustomSnackbar.error(failure.message);
        AppLogger.logError("Failed to fetch executives: ${failure.message}");
      },
      (data) {
        isLoading.value = false;
        isLoadMore.value = false;
        executivesData.value = data.data ?? ExecutiveListData();
        final newList = data.data?.executives ?? [];
        if (currentPage == 1) {
          executives.value = newList;
          executiveCount.value = data.data?.totalCount ?? 0;
          hasMorePages = newList.isNotEmpty;
        } else {
          final existingIds = executives.map((e) => e.id).toSet();
          final uniqueNewList = newList
              .where((e) => !existingIds.contains(e.id))
              .toList();

          executives.addAll(uniqueNewList);
          hasMorePages = uniqueNewList.isNotEmpty;
        }

        if (hasMorePages) {
          currentPage++;
        }

        AppLogger.debugPrint(
          "Executives fetched successfully: ${executives.length}",
        );
      },
    );
  }

  Future<void> fetchExecutiveDetail(
    String id, {
    bool routeToScreen = true,
  }) async {
    isDetailLoading.value = true;
    final result = await getExecutiveDetailUseCase.call(id);

    result.fold(
      (failure) {
        isDetailLoading.value = false;
        AppLogger.logError(
          "Failed to fetch executive detail: ${failure.message}",
        );
        CustomSnackbar.error(failure.message);
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
        AppLogger.logError(
          "Failed to fetch commission packages: ${failure.message}",
        );
      },
      (data) {
        isCommissionPackagesLoading.value = false;
        commissionPackages.value = data.data ?? [];
        AppLogger.debugPrint(
          "Commission packages fetched successfully: ${commissionPackages.length}",
        );
      },
    );
  }

  Future<void> updateExecutive(Map<String, dynamic> data) async {
    isUpdatingExecutive.value = true;
    final result = await updateExecutiveUseCase.call(data);

    result.fold(
      (failure) {
        isUpdatingExecutive.value = false;
        CustomSnackbar.error(failure.message);
      },
      (successMessage) {
        isUpdatingExecutive.value = false;
        isDirty.value = false;
        CustomSnackbar.success(successMessage);

        // Refresh the detail to sync any unreturned calculated values
        if (executiveDetail.value?.id != null) {
          fetchExecutiveDetail(
            executiveDetail.value!.id.toString(),
            routeToScreen: false,
          );
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
        AppLogger.logError(
          "Failed to fetch executive wallet details: ${failure.message}",
        );
        CustomSnackbar.error(failure.message);
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
        AppLogger.logError(
          "Failed to add executive wallet: ${failure.message}",
        );
        CustomSnackbar.error(failure.message);
      },
      (message) {
        isAddWalletLoading.value = false;
        Get.back();
        CustomSnackbar.success(message);
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
        CustomSnackbar.error(failure.message);
      },
      (successMessage) {
        isUpdatingExecutive.value = false;
        Get.back();
        CustomSnackbar.success(successMessage);
        fetchExecutives();
      },
    );
  }
}
