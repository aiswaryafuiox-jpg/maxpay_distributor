import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/data/model/create_qr_response_model.dart';
import 'package:maxpay/domain/usecase/get_add_wallet_balance_usecase.dart';
import 'package:maxpay/domain/usecase/create_qr_usecase.dart';
import 'package:maxpay/domain/usecase/wallet_request_usecase.dart';
import 'package:maxpay/data/model/wallet_qr_history_model.dart';
import 'package:maxpay/view/add_wallet_home/widge/add_wallet_dialogue.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

class AddWalletController extends GetxController with WidgetsBindingObserver {
  final GetAddWalletBalanceUseCase getAddWalletBalanceUseCase;
  final CreateQrUsecase createQrUsecase;
  final WalletRequestUsecase walletRequestUsecase;

  AddWalletController(
    this.getAddWalletBalanceUseCase,
    this.createQrUsecase,
    this.walletRequestUsecase,
  );

  RxBool isLoading = false.obs;
  RxString walletBalance = "0.00".obs;

  final amountController = TextEditingController();
  final paymentReferenceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchWalletBalance();
    getWalletHistory();
  }

  final WeiplCheckoutFlutter wlCheckout = WeiplCheckoutFlutter();
  Future<void> fetchWalletBalance() async {
    isLoading.value = true;
    final result = await getAddWalletBalanceUseCase();
    isLoading.value = false;

    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (data) {
        if (data.data?.totalBalance != null) {
          walletBalance.value = data.data!.totalBalance?.toString() ?? "0.00";
        }
      },
    );
  }

  Future<void> createWalletRequest({
    required String amount,
    required String paymenttype,
    required String utrno,
    required String bankid,
    required String description,
    required String receipt,
    VoidCallback? onSuccess,
  }) async {
    try {
      isLoading.value = true;

      final result = await walletRequestUsecase(
        amount: amount,
        paymenttype: paymenttype,
        utrno: utrno,
        bankid: bankid,
        description: description,
        receipt: receipt,
      );

      AppLogger.debugPrint("API CALLED SUCCESSFULLY");

      result.fold(
        (failure) {
          CustomToast.error(failure.message.toString());
          debugPrint("ERROR: ${failure.message}");
        },
        (response) {
          if (onSuccess != null) {
            onSuccess();
          }
          CustomToast.success(response.message ?? "Wallet Request Success");
          debugPrint("SUCCESS RESPONSE: ${response.toJson()}");
          // Optionally, refresh history
          getWalletHistory();
        },
      );
    } catch (e) {
      CustomToast.error(e.toString());
      debugPrint("EXCEPTION: $e");
    } finally {
      isLoading.value = false;
    }
  }

  static const MethodChannel _channel = MethodChannel(
    "com.paylink.distributor/upi_choose",
  );
  Timer? _timer;
  final RxInt remainingSeconds = 300.obs;
  String? _activeTxnId;
  String _lastAmount = '0.00';

  RxBool isCheckingStatus = false.obs;
  Rx<WalletQrHistoryModel> walletQrHistory = WalletQrHistoryModel().obs;
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

  Future<void> checkIndividualPaymentStatus(String txnId, String amount) async {
    if (txnId.isEmpty) {
      return;
    }

    final isDark = Get.theme.brightness == Brightness.dark;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: .center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                "Checking payment status...",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    int secondsElapsed = 0;
    bool isSuccess = false;

    while (secondsElapsed < 60) {
      // If the user closed the loading dialog via the back button, stop polling.
      if (!(Get.isDialogOpen ?? false)) {
        return;
      }

      await Future.delayed(const Duration(seconds: 3));
      secondsElapsed += 3;

      try {
        final result = await createQrUsecase.checkQrStatus(txnId: txnId);
        result.fold((failure) {}, (status) {
          if (status.toString().toLowerCase() == "success") {
            isSuccess = true;
          }
        });

        if (isSuccess) break;
      } catch (e) {
        // ignore error during polling
      }
    }

    // Check again before showing result dialogs in case it was closed during the last delay
    if (!(Get.isDialogOpen ?? false)) {
      return;
    }

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (isSuccess) {
      showSuccessDialog(amount);
      if (Get.isRegistered<HomePageController>()) {
        fetchWalletBalance();
      }
      getWalletHistory();
    } else {
      // Pending dialog is not defined here yet, but let's add a simple error toast for now
      CustomToast.error("Payment status is still pending.");
    }
  }

  CreateQrResponseModel? qrResponse;
  Future<void> createQr(String amount) async {
    if (isLoading.value) return; // Prevent multiple calls if already loading

    if (amount.trim().isEmpty) {
      CustomToast.error("Please Enter Amount");
      return;
    }

    isLoading.value = true;

    update();

    _lastAmount = amount.trim();

    try {
      final result = await createQrUsecase.createQrAmount(
        amount: amount.trim(),
      );

      result.fold(
        (failure) {
          AppLogger.debugPrint("------------ CREATE QR FAILED ------------");

          AppLogger.logError(failure.message);

          CustomToast.error(failure.message);

          amountController.clear();
        },
        (response) {
          AppLogger.debugPrint("------------ CREATE QR SUCCESS ------------");

          AppLogger.logError(response.toJson());
          qrResponse = response;
          final ekqrData = qrResponse?.data?.ekqr;
          final wordlinkData = qrResponse?.data?.worldline;

          // if (txnId.isEmpty) {
          //   CustomToast.error("Transaction ID not received");
          //   return;
          // }

          // --------------------------------------------------------------
          // IMPORTANT:
          // Convert backend link to standard UPI URI
          // --------------------------------------------------------------

          final qrUpiUrl = convertToStandardUpiUrl(
            response.data?.ekqr?.upiLink ?? '',
          );

          AppLogger.debugPrint("==========================================");

          AppLogger.debugPrint("BACKEND PAYMENT URL:");

          AppLogger.debugPrint(qrUpiUrl);

          AppLogger.debugPrint("QR UPI URL:");

          AppLogger.debugPrint(qrUpiUrl);

          AppLogger.debugPrint("==========================================");

          // If we couldn't create a proper UPI URL,
          // don't show an invalid QR.
          if (!isValidUpiUrl(qrUpiUrl)) {
            CustomToast.error("Invalid UPI payment link received from server");

            AppLogger.debugPrint("Invalid QR UPI URL: $qrUpiUrl");

            return;
          }

          // Start payment timer
          startTimer(ekqrData?.txnId ?? wordlinkData?.txnId ?? '');

          // Load installed UPI apps
          loadInstalledUpiApps();

          // --------------------------------------------------------------
          // SHOW QR POPUP
          // --------------------------------------------------------------

          Get.dialog(
            AddWalletPopup(
              ekqrData: response.data?.ekqr,
              bankData: response.data?.worldline,

              // Keep backend links for buttons
            ),
          ).then((_) async {
            stopTimer();

            amountController.clear();

            await Future.delayed(const Duration(seconds: 1));

            await getWalletHistory();
          });
        },
      );
    } catch (e) {
      AppLogger.debugPrint("Create QR error: $e");

      CustomToast.error("Unable to create payment QR");
    } finally {
      isLoading.value = false;

      update();
    }
  }

  void startWorldlinePayment(Worldline worldlineData) {
    String deviceID = "";
    if (Platform.isAndroid) {
      deviceID = "AndroidSH2";
    } else if (Platform.isIOS) {
      deviceID = "iOSSH2";
    }

    final items = (worldlineData.data?.items ?? [])
        .map((e) => e.toJson())
        .toList();
    var reqJson = {
      "features": {
        "enableAbortResponse": true,
        "enableExpressPay": false,
        "enableInstrumentDeRegistration": true,
        "enableMerTxnDetails": true,
      },
      "consumerData": {
        "deviceId": deviceID,
        "token": worldlineData.data?.token ?? "",
        "paymentMode": "UPI",
        "merchantLogoUrl":
            "https://paylinkonline.in/assets/img/logopaylink.jpeg",
        "merchantId": worldlineData.data?.merchantId ?? "",
        "currency": "INR",
        "consumerId": worldlineData.data?.consumerId ?? "",
        "consumerMobileNo": worldlineData.data?.consumerMobileNo ?? "",
        "consumerEmailId": worldlineData.data?.consumerEmailId ?? "",
        "txnId": worldlineData.txnId ?? "",
        "items": items,
        "customStyle": {
          "PRIMARY_COLOR_CODE":
              "#${AppColors.clrPrimary.toARGB32().toRadixString(16).substring(2, 8).toUpperCase()}",
          "SECONDARY_COLOR_CODE":
              "#${AppColors.clrBg.toARGB32().toRadixString(16).substring(2, 8).toUpperCase()}",
          "BUTTON_COLOR_CODE_1":
              "#${AppColors.clrSecondary.toARGB32().toRadixString(16).substring(2, 8).toUpperCase()}",
          "BUTTON_COLOR_CODE_2": "#FFFFFF",
        },
      },
    };
    wlCheckout.on(
      WeiplCheckoutFlutter.wlResponse,
      _worldlineResponseCallback,
      _worldlineErrorCallback,
    );
    wlCheckout.open(reqJson);
  }

  bool isValidUpiUrl(String value) {
    try {
      final uri = Uri.tryParse(value);

      if (uri == null) {
        return false;
      }

      if (uri.scheme.toLowerCase() != 'upi') {
        return false;
      }

      if (uri.host.toLowerCase() != 'pay') {
        return false;
      }

      final pa = uri.queryParameters['pa'];

      if (pa == null || pa.trim().isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _worldlineResponseCallback(
    Map<dynamic, dynamic> response,
  ) async {
    AppLogger.logError(response);

    final msg = response['msg'];
    final errorMsg = response['errorMsg'];

    if (msg == null || !msg.toString().contains('SUCCESS')) {
      CustomToast.error("Payment failed, please try again later.");
      return;
    }

    try {
      isLoading.value = true;

      final txnId = qrResponse?.data?.worldline?.txnId ?? '';
      final merchantCode = qrResponse?.data?.worldline?.data?.merchantId ?? '';

      final formData = {
        'transaction_id': txnId,
        'msg': msg.toString(),
        'merchant_code': merchantCode,
      };

      final apiService = sl<ApiService>();
      final verifyResponse = await apiService.post(
        ApiRoutes.verifyWorldlinePayment,
        data: formData,
      );

      if (verifyResponse['status'] == true ||
          verifyResponse['status'] == 1 ||
          verifyResponse['status'] == "true") {
        while (Get.isDialogOpen == true) {
          Get.back();
        }

        final amount = qrResponse?.data?.worldline?.amount ?? "0";
        showSuccessDialog(amount);

        fetchWalletBalance();
      } else {
        CustomToast.error("Payment failed, please try again later.");
      }
    } catch (e) {
      AppLogger.logError(e);
      CustomToast.error("Payment failed, please try again later.");
    } finally {
      isLoading.value = false;
      getWalletHistory();
    }
  }

  void _worldlineErrorCallback(Map<dynamic, dynamic> response) {
    AppLogger.logError(response);
    CustomToast.error("Payment failed, please try again later.");
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

  String buildWorkingUpiUrl({
    required String paymentLink,
    required String amount,
  }) {
    final uri = Uri.tryParse(paymentLink);

    if (uri == null) {
      return '';
    }

    final params = uri.queryParameters;

    final pa = params['pa'];
    final pn = params['pn'];

    if (pa == null || pa.isEmpty) {
      return '';
    }

    final upiUri = Uri(
      scheme: 'upi',
      host: 'pay',
      queryParameters: {
        'pa': pa,
        'pn': pn ?? 'AJ SYSTEMS & SERVICES',
        'am': amount,
        'cu': 'INR',
      },
    );

    return upiUri.toString();
  }

  String convertToStandardUpiUrl(String backendUrl) {
    try {
      final uri = Uri.tryParse(backendUrl);

      if (uri == null) {
        return '';
      }

      final params = uri.queryParameters;

      final pa = params['pa'];

      if (pa == null || pa.isEmpty) {
        debugPrint("UPI ID not found");
        return '';
      }

      final pn = params['pn'] ?? 'AJ SYSTEMS AND SERVICES';

      final amount = params['am'] ?? _lastAmount;

      final upiUri = Uri(
        scheme: 'upi',
        host: 'pay',
        queryParameters: {'pa': pa, 'pn': pn, 'am': amount, 'cu': 'INR'},
      );

      debugPrint("QR URL = ${upiUri.toString()}");

      return upiUri.toString();
    } catch (e) {
      debugPrint("UPI conversion error: $e");
      return '';
    }
  }

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
