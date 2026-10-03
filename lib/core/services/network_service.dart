import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<List<ConnectivityResult>>? subscription;

  bool _isOffline = false;

  int _failedChecks = 0;

  bool _isChecking = false;

  /// How many times internet check should fail
  /// before showing No Internet screen.
  static const int _maxFailedChecks = 2;

  Future<NetworkService> init() async {
    debugPrint("🌐 NetworkService initializing...");

    subscription = _connectivity.onConnectivityChanged.listen((results) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;

      debugPrint("📡 Connectivity changed -> $result");

      _checkInternet(result);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final results = await _connectivity.checkConnectivity();

      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;

      debugPrint("🌐 Initial connectivity -> $result");

      await _checkInternet(result);
    });

    return this;
  }

  /// Checks actual internet connection.
  ///
  /// ConnectivityResult only tells us whether WiFi/mobile
  /// is connected. It does NOT guarantee internet access.
  Future<bool> _hasInternet(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      debugPrint("📴 No WiFi/Mobile connection");
      return false;
    }

    HttpClient? client;

    try {
      client = HttpClient();

      client.connectionTimeout = const Duration(seconds: 3);

      final request = await client
          .getUrl(
            Uri.parse(
              'https://clients3.google.com/generate_204',
            ),
          )
          .timeout(
            const Duration(seconds: 4),
          );

      request.followRedirects = false;

      final response = await request.close().timeout(
            const Duration(seconds: 4),
          );

      debugPrint(
        "🌍 Internet check status -> ${response.statusCode}",
      );

      return response.statusCode == 204 ||
          response.statusCode == 200;
    } catch (e) {
      debugPrint("❌ Actual internet check failed -> $e");
      return false;
    } finally {
      client?.close(force: true);
    }
  }

  /// Manually check internet.
  Future<bool> checkInternetNow() async {
    final results = await _connectivity.checkConnectivity();

    final result = results.isNotEmpty
        ? results.first
        : ConnectivityResult.none;

    return await _checkInternet(result);
  }

  /// Main internet checking function.
  Future<bool> _checkInternet(
    ConnectivityResult result,
  ) async {
    // If another check is already running,
    // don't start another one.
    if (_isChecking) {
      debugPrint("⏳ Internet check already running");
      return !_isOffline;
    }

    _isChecking = true;

    try {
      final hasInternet = await _hasInternet(result);

      // ==========================================================
      // INTERNET AVAILABLE
      // ==========================================================

      if (hasInternet) {
        debugPrint("✅ Internet Available");

        _failedChecks = 0;

        if (_isOffline) {
          debugPrint("✅ Internet Restored");

          _isOffline = false;

          _closeNoInternetScreen();
        }

        return true;
      }

      // ==========================================================
      // INTERNET NOT AVAILABLE
      // ==========================================================

      _failedChecks++;

      debugPrint(
        "🚫 Internet check failed: $_failedChecks/$_maxFailedChecks",
      );

      // Don't show screen after only one temporary failure.
      if (_failedChecks < _maxFailedChecks) {
        debugPrint(
          "⚠️ Temporary network failure. Checking again...",
        );

        // Wait and check again.
        await Future.delayed(
          const Duration(milliseconds: 800),
        );

        final retryResults =
            await _connectivity.checkConnectivity();

        final retryResult = retryResults.isNotEmpty
            ? retryResults.first
            : ConnectivityResult.none;

        final retryHasInternet =
            await _hasInternet(retryResult);

        if (retryHasInternet) {
          debugPrint("✅ Internet available on retry");

          _failedChecks = 0;
          return true;
        }
      }
      _isOffline = true;

      debugPrint("🚫 No Internet confirmed");

      _showNoInternetScreen();

      return false;
    } finally {
      _isChecking = false;
    }
  }

  void _showNoInternetScreen() {
    if (Get.currentRoute == AppRoutes.noInternet) {
      return;
    }

    debugPrint("➡️ Opening No Internet screen");

    Get.toNamed(AppRoutes.noInternet);
  }

  void _closeNoInternetScreen() {
    if (Get.currentRoute == AppRoutes.noInternet) {
      debugPrint("⬅️ Closing No Internet screen");

      Get.back();
    }
  }

  @override
  void onClose() {
    debugPrint("🧹 NetworkService disposed");

    subscription?.cancel();

    super.onClose();
  }
}