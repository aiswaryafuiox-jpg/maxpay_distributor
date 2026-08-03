import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/domain/usecase/get_add_wallet_balance_usecase.dart';
import 'package:maxpay/domain/usecase/create_qr_usecase.dart';
import 'package:maxpay/data/model/wallet_qr_history_model.dart';
import 'package:maxpay/view/add_wallet_home/widge/add_wallet_dialogue.dart';

class AddWalletController extends GetxController with WidgetsBindingObserver {
  final GetAddWalletBalanceUseCase getAddWalletBalanceUseCase;
  final CreateQrUsecase createQrUsecase;

  AddWalletController(this.getAddWalletBalanceUseCase, this.createQrUsecase);

  RxBool isLoading = false.obs;
  RxString walletBalance = "0.00".obs;

  final amountController = TextEditingController();
  final paymentReferenceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchWalletBalance();
  }

  Future<void> fetchWalletBalance() async {
    isLoading.value = true;
    final result = await getAddWalletBalanceUseCase();
    isLoading.value = false;

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (data) {
        if (data.data?.walletBalance != null) {
          walletBalance.value = data.data!.walletBalance!;
        }
      },
    );
  }

  static const MethodChannel _channel = MethodChannel(
    "com.paylink.distributor/upi_choose",
  );
  Timer? _timer;
  final RxInt remainingSeconds = 300.obs;
  String? _activeTxnId;
  String _lastAmount = '0.00';

  RxBool isCheckingStatus = false.obs;
  Rx<WalletQrHistory> walletQrHistory = WalletQrHistory().obs;
  RxList<Map<String, dynamic>> upiApps = <Map<String, dynamic>>[].obs;
  RxBool isLoadingUpiApps = false.obs;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppLogger.debugPrint("App resumed. Active Txn ID: $_activeTxnId");
      getWalletHistory();

      if (_activeTxnId != null && remainingSeconds.value > 0) {
        checkPaymentStatus(_activeTxnId!);
        if (_timer == null || !_timer!.isActive) {
          startTimer(_activeTxnId!);
        }
      }
    }
  }

  void startTimer(String txnId) {
    _timer?.cancel();
    _activeTxnId = txnId;
    remainingSeconds.value = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        if (remainingSeconds.value % 5 == 0) {
          checkPaymentStatus(txnId);
        }
      } else {
        stopTimer();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        amountController.clear();
        CustomToast.error("Payment session expired");
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _activeTxnId = null;
  }
  // Future<void> loadInstalledUpiApps() async {
  //   if (upiApps.isNotEmpty) return;

  //   isLoadingUpiApps.value = true;
  //   upiApps.value = await getInstalledUpiApps();
  //   isLoadingUpiApps.value = false;
  // }
  Future<void> checkPaymentStatus(String txnId) async {
    if (isCheckingStatus.value) return;
    isCheckingStatus.value = true;

    final result = await createQrUsecase.checkQrStatus(txnId: txnId);

    result.fold(
      (failure) {
        AppLogger.debugPrint(
          "Status check: pending/failed: ${failure.message}",
        );
      },
      (status) {
        if (status == "success") {
          stopTimer();
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          final successAmount = _lastAmount;
          amountController.clear();
          showSuccessDialog(successAmount);

          if (Get.isRegistered<HomePageController>()) {
            fetchWalletBalance();
          }
          getWalletHistory();
        }
        AppLogger.debugPrint("Status check: pending/failed: $status");
      },
    );

    isCheckingStatus.value = false;
  }

  void showSuccessDialog(String amount) {
    final isDark = Get.theme.brightness == Brightness.dark;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: isDark ? const Color(0xff1E1E2E) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Payment Successful",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "${amount.currencyIndian} has been successfully added to your wallet.",
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff004B8F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> createQr(String amount) async {
    isLoading.value = true;
    update();
    _lastAmount = amount;
    final result = await createQrUsecase.createQrAmount(amount: amount);

    result.fold(
      (failure) {
        AppLogger.debugPrint("------------CREATE QR CALLED----------");
        AppLogger.logError(failure.message);
        CustomToast.error(failure.message);
        amountController.clear();
        AppLogger.debugPrint("------------CREATE QR END----------");
      },
      (response) {
        AppLogger.debugPrint("------------CREATE QR CALLED----------");
        AppLogger.logError(response.toJson());

        startTimer(response.txnId ?? '');
        loadInstalledUpiApps(); // <-- ADDED: fetch UPI apps before showing dialog

        Get.dialog(
          AddWalletPopup(
            amount: amount,
            txtionId: response.txnId ?? '',
            url: response.upiLink ?? '',
          ),
        ).then((_) async {
          stopTimer();
          amountController.clear();

          // Give backend time to update
          await Future.delayed(const Duration(seconds: 1));

          await getWalletHistory();
        });
        AppLogger.debugPrint("------------CREATE QR END----------");
      },
    );
    isLoading.value = false;
    update();
  }

  Future<void> loadInstalledUpiApps() async {
    isLoadingUpiApps.value = true;
    upiApps.value = await getInstalledUpiApps();
    isLoadingUpiApps.value = false;
    AppLogger.debugPrint("UPI apps found: ${upiApps.length}");
  }

  Future<List<Map<String, dynamic>>> getInstalledUpiApps() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        "getInstalledUpiApps",
      );
      return result.map((e) => Map<String, dynamic>.from(e)).toList();
    } on PlatformException catch (e) {
      AppLogger.debugPrint(
        "getInstalledUpiApps PlatformException: ${e.message}",
      );
      return [];
    } catch (e) {
      AppLogger.debugPrint("getInstalledUpiApps error: $e");
      return [];
    }
  }
  // Future<void> createQr(String amount) async {
  //   isLoading.value = true;
  //   update();
  //   _lastAmount = amount;
  //   final result = await createQrUsecase.createQrAmount(amount: amount);

  //   result.fold(
  //     (failure) {
  //       AppLogger.debugPrint("------------CREATE QR CALLED----------");
  //       AppLogger.logError(failure.message);
  //       CustomToast.error(failure.message);
  //       amountController.clear();
  //       AppLogger.debugPrint("------------CREATE QR END----------");
  //     },
  //     (response) {
  //       // CustomToast.success(response.);
  //       AppLogger.debugPrint("------------CREATE QR CALLED----------");
  //       AppLogger.logError(response.toJson());

  //       startTimer(response.txnId ?? '');

  //       Get.dialog(
  //         AddWalletPopup(
  //           amount: amount,
  //           txtionId: response.txnId ?? '',
  //           url: response.upiLink ?? '',
  //         ),
  //       ).then((_) {
  //         stopTimer();
  //         amountController.clear();
  //       });

  //       AppLogger.debugPrint("------------CREATE QR END----------");
  //     },
  //   );
  //   isLoading.value = false;
  //   update();
  // }

  Future<void> getWalletHistory() async {
    isLoading.value = true;
    update();
    final result = await createQrUsecase.getWalletHistory();

    result.fold(
      (failure) {
        AppLogger.debugPrint("------------GET WALLET HISTORY CALLED----------");
        AppLogger.logError(failure.message);
        CustomToast.error(failure.message);
        AppLogger.debugPrint("------------GET WALLET HISTORY END----------");
      },
      (response) {
        // CustomToast.success(response.);
        AppLogger.debugPrint("------------GET WALLET HISTORY CALLED----------");
        AppLogger.logError(response.toJson());
        walletQrHistory.value = response;
        AppLogger.debugPrint("------------GET WALLET HISTORY END----------");
      },
    );
    isLoading.value = false;
    update();
  }

  Future<void> openSpecificUpiApp({
    required String packageName,
    required String url,
  }) async {
    try {
      await _channel.invokeMethod("openSpecificUpiApp", {
        "packageName": packageName,
        "url": url,
      });
    } catch (e) {
      CustomToast.error(e.toString());
    }
  }

  @override
  void onClose() {
    amountController.dispose();
    paymentReferenceController.dispose();
    super.onClose();
  }
}
