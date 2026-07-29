import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/data/model/settings/commission_settings_model.dart';
import 'package:maxpay/domain/usecase/settings/get_commission_settings_usecase.dart';
import 'package:maxpay/domain/usecase/settings/update_package_status_usecase.dart';
import 'package:maxpay/domain/usecase/settings/reset_package_commission_usecase.dart';
import 'package:maxpay/domain/usecase/settings/get_bulk_package_options_usecase.dart';
import 'package:maxpay/domain/usecase/settings/bulk_package_charge_usecase.dart';
import 'package:maxpay/domain/usecase/settings/bulk_package_change_usecase.dart';
import 'package:maxpay/data/model/settings/bulk_package_options_model.dart';

class CommissionSettingsController extends GetxController {
  final GetCommissionSettingsUseCase getCommissionSettingsUseCase;
  final UpdatePackageStatusUseCase updatePackageStatusUseCase;
  final ResetPackageCommissionUseCase resetPackageCommissionUseCase;
  final GetBulkPackageOptionsUseCase getBulkPackageOptionsUseCase;
  final BulkPackageChargeUseCase bulkPackageChargeUseCase;
  final BulkPackageChangeUseCase bulkPackageChangeUseCase;

  CommissionSettingsController(
    this.getCommissionSettingsUseCase,
    this.updatePackageStatusUseCase,
    this.resetPackageCommissionUseCase,
    this.getBulkPackageOptionsUseCase,
    this.bulkPackageChargeUseCase,
    this.bulkPackageChangeUseCase,
  );

  var isLoading = false.obs;
  var isUpdating = false.obs;
  var errorMessage = ''.obs;
  var commissionSettingsList = <CommissionSettingItem>[].obs;
  var bulkPackageOptions = Rxn<BulkPackageOptionsData>();

  @override
  void onInit() {
    super.onInit();
    fetchCommissionSettings();
  }

  Future<void> fetchCommissionSettings() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getCommissionSettingsUseCase.call();
    
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
      (data) {
        if (data.data?.list != null) {
          commissionSettingsList.value = data.data!.list!;
        }
        isLoading.value = false;
      },
    );
  }

  Future<void> updatePackageStatus({required int id, required String type, required String status}) async {
    isUpdating.value = true;
    final result = await updatePackageStatusUseCase.call(id: id, type: type, status: status);
    
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isUpdating.value = false;
      },
      (message) {
        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isUpdating.value = false;
        fetchCommissionSettings();
      },
    );
  }

  Future<void> resetPackageCommission({required int id}) async {
    isUpdating.value = true;
    final result = await resetPackageCommissionUseCase.call(id: id);
    
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isUpdating.value = false;
      },
      (message) {
        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isUpdating.value = false;
        fetchCommissionSettings();
      },
    );
  }

  Future<void> fetchBulkPackageOptions() async {
    isUpdating.value = true;
    
    final result = await getBulkPackageOptionsUseCase.call();
    
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isUpdating.value = false;
      },
      (data) {
        if (data.data != null) {
          bulkPackageOptions.value = data.data;
        }
        isUpdating.value = false;
      },
    );
  }

  Future<void> applyBulkPackageCharge({required int packageId, required String userType, required VoidCallback onSuccess}) async {
    isUpdating.value = true;
    
    final result = await bulkPackageChargeUseCase.call(packageId: packageId, userType: userType);
    
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isUpdating.value = false;
      },
      (message) {
        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isUpdating.value = false;
        onSuccess();
      },
    );
  }

  Future<void> applyBulkPackageChange({required int packageId, required String status, required VoidCallback onSuccess}) async {
    isUpdating.value = true;
    
    final result = await bulkPackageChangeUseCase.call(packageId: packageId, status: status);
    
    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isUpdating.value = false;
      },
      (message) {
        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isUpdating.value = false;
        onSuccess();
      },
    );
  }
}
