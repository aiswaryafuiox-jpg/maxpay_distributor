import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_routes.dart';
import '../constants/routes_path.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes.baseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          "Accept": "application/json",
          "X-API-KEY": "kijunhpouytreesedcfvgbhbhjnhjbgcdfxxdfvghbgh",
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("token");

          log("REQUEST => ${options.method}");
          log("URL => ${options.baseUrl}${options.path}");
          log(
            options.data is FormData
                ? "BODY => ${(options.data as FormData).fields.map((e) => "${e.key}: ${e.value}").toList()}"
                : "BODY => ${options.data}",
          );

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onResponse: (response, handler) {
          log("STATUS => ${response.statusCode}");
          log("RESPONSE => ${response.data}");
          return handler.next(response);
        },

        onError: (DioException e, handler) {
          log("ERROR => ${e.message}");
          log("ERROR RESPONSE => ${e.response?.data}");

          if (e.requestOptions.path.contains(ApiRoutes.loginSendOtp) ||
              e.requestOptions.path.contains(ApiRoutes.verifyOtp) ||
              e.requestOptions.path.contains(ApiRoutes.verifyPin) ||
              e.requestOptions.path.contains(ApiRoutes.updateStatusVerifyOtp) ||
              e.requestOptions.path.contains(
                ApiRoutes.updateProfileVerifyOtp,
              ) ||
              e.requestOptions.path.contains(ApiRoutes.distributorUpdateMpin) ||
              e.requestOptions.path.contains(ApiRoutes.distributorUpdatePin)) {
            return handler.next(e);
          }

          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          }

          return handler.next(e);
        },
      ),
    );
  }

  /// GET API
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _handleResponse(
      () => _dio.get(endpoint, queryParameters: queryParameters),
    );
  }

  /// POST API
  Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return _handleResponse(
      () => _dio.post(
        endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      ),
    );
  }

  /// PUT API
  Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return _handleResponse(
      () => _dio.put(
        endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      ),
    );
  }

  /// DELETE API
  Future<Map<String, dynamic>> delete(String endpoint, {dynamic data}) async {
    return _handleResponse(() => _dio.delete(endpoint, data: data));
  }

  /// Common Response Handler
  Future<Map<String, dynamic>> _handleResponse(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }

      return {"data": response.data};
    } on DioException catch (e) {
      // ==========================================================
      // CONNECTION ERROR
      // ==========================================================

      if (_isConnectionError(e)) {
        log(
          "🌐 Connection error: "
          "${e.requestOptions.path}",
        );

        // IMPORTANT:
        // Don't throw raw Dio message to UI.
        throw Exception("No internet connection");
      }

      // ==========================================================
      // API ERROR
      // ==========================================================

      final message = e.response?.data is Map
          ? e.response?.data['message']?.toString()
          : null;

      log(
        "DioException: "
        "${e.requestOptions.path} "
        "${message ?? e.type}",
      );

      throw Exception(message ?? "Something went wrong");
    } catch (e) {
      log("UNKNOWN ERROR => $e");
      throw Exception("Unexpected error occurred");
    }
  }

  bool _isConnectionError(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout;
  }

  /// Handle Unauthorized
  Future<void> _handleUnauthorized() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    await prefs.remove("token");

    if (token != null && token.isNotEmpty) {
      final currentRoute = g.Get.currentRoute;
      final authRoutes = [
        AppRoutes.splash,
        AppRoutes.intro,
        AppRoutes.welcome,
        AppRoutes.selectSim,
        AppRoutes.loginPhoneName,
        AppRoutes.otpVerification,
        AppRoutes.pinCodeCreation,
        AppRoutes.enterPin,
        AppRoutes.veirfypin,
        AppRoutes.biometricsIntro,
        AppRoutes.biometricsScanning,
      ];

      if (!authRoutes.contains(currentRoute)) {
        g.Get.offAllNamed(AppRoutes.loginPhoneName);
        g.Get.snackbar("Session Expired", "Please login again.");
      }
    }
  }
}
