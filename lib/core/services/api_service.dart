import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:maxpay/core/services/error_parser.dart';
import 'package:maxpay/core/services/network_service.dart';

import '../constants/api_routes.dart';
import '../constants/routes_path.dart';

import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class ApiService {
  final Dio _dio;
  final _storage = LocalStorageService();

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiRoutes.baseURL,
          contentType: 'application/json',
          headers: {
            "Accept": "application/json",
            "x-api-key": "kijunhpouytreesedcfvgbhbhjnhjbgcdfxxdfvghbgh",
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.getString("auth_token");

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (DioException e, handler) async {
          print("FAILED URL => ${e.requestOptions.uri}");
          print("STATUS => ${e.response?.statusCode}");

          // ==========================================================
          // CONNECTION ERROR
          // ==========================================================

          if (_isConnectionError(e)) {
            log(
              "🌐 Network error: "
              "${e.requestOptions.path}",
            );

            // Ask NetworkService to check actual internet.
            if (g.Get.isRegistered<NetworkService>()) {
              await g.Get.find<NetworkService>().checkInternetNow();
            }

            // IMPORTANT:
            // Don't log/show the raw:
            // "Failed host lookup..."
            // "SocketException..."
            // message to the user.

            return handler.next(e);
          }

          // ==========================================================
          // SERVER / API ERROR
          // ==========================================================

          final String errorMessage = e.response?.data is Map
              ? e.response?.data['message']?.toString() ??
                    "Something went wrong"
              : "Something went wrong";

          log("API Error: $errorMessage");

          // 401 handling
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          } else {
            // Log only.
            // Don't show Toast here because controllers
            // may already handle the error.
            AppLogger.logError(errorMessage);
          }

          return handler.next(e);
        },
      ),
    );
  }

  // ================================================================
  // CONNECTION ERROR CHECK
  // ================================================================

  bool _isConnectionError(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout;
  }

  // ================================================================
  // POST
  // ================================================================

  Future<Map<String, dynamic>> post(String endpoint, {dynamic data}) async {
    return _handleResponse(
      () => _dio.post(
        endpoint,
        data: data,
        options: Options(
          contentType: data is FormData ? null : 'application/json',
        ),
      ),
    );
  }

  // ================================================================
  // GET
  // ================================================================

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    AppLogger.debugPrint(endpoint);

    return _handleResponse(() => _dio.get(endpoint, queryParameters: params));
  }

  // ================================================================
  // PUT
  // ================================================================

  Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
    bool useFormData = false,
  }) async {
    return _handleResponse(
      () => _dio.put(
        endpoint,
        data: useFormData && data is Map
            ? FormData.fromMap(Map<String, dynamic>.from(data))
            : data,
        options: Options(contentType: useFormData ? null : 'application/json'),
      ),
    );
  }

  // ================================================================
  // DELETE
  // ================================================================

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    return _handleResponse(() => _dio.delete(endpoint, data: data));
  }

  // ================================================================
  // HANDLE RESPONSE
  // ================================================================

  Future<Map<String, dynamic>> _handleResponse(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();

      if (response.data is Map) {
        return Map<String, dynamic>.from(
          response.data as Map<dynamic, dynamic>,
        );
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
        "${e.response?.data}"
        "${e.requestOptions.path} "
        "${message ?? e.type}",
      );

      if (message?.toLowerCase() == "unauthenticated") {
        _handleUnauthorized();

        throw AppException("Unauthenticated");
      } else {
        throw AppException(message ?? "Something went wrong");
      }
    } catch (e) {
      log("Unknown error: $e");

      throw AppException("Something went wrong");
    }
  }

  // ================================================================
  // UNAUTHORIZED
  // ================================================================

  void _handleUnauthorized() {
    final token = _storage.getString("auth_token");

    if (token == null || token.isEmpty) {
      return;
    }

    _storage.remove("auth_token");

    g.Get.offAllNamed(AppRoutes.welcome);

    g.Get.snackbar("Session Expired", "Please login again.");
  }
}
