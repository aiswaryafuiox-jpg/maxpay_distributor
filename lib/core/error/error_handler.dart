import 'package:dio/dio.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class DioErrorHandler {
  static Failure handle(dynamic error) {
    String message = "Something went wrong";
    AppLogger.logError("error message: $error");
    AppLogger.logError("error message: ${error.runtimeType}");
    if (error is DioException) {
      AppLogger.logError("error response data: ${error.response?.data}");
      AppLogger.logError(
        "error response statusCode: ${error.response?.statusCode}",
      );
      AppLogger.logError(
        "error response statusMessage: ${error.response?.statusMessage}",
      );
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        message =
            "Connection timed out. Please check your internet connection.";
        return NetworkFailure(message);
      } else if (error.type == DioExceptionType.badResponse) {
        if (error.response?.statusCode == 404) {
          message = "The requested resource could not be found (404).";
        } else if (error.response?.data != null) {
          if (error.response?.data is Map) {
            final data = error.response?.data as Map;
            if (data["errors"] != null && data["errors"] is Map) {
              final errorsMap = data["errors"] as Map;
              final List<String> errorMessages = [];
              for (var value in errorsMap.values) {
                if (value is List) {
                  for (var e in value) {
                    errorMessages.add(e.toString());
                  }
                } else {
                  errorMessages.add(value.toString());
                }
              }
              if (errorMessages.isNotEmpty) {
                message = errorMessages.join('\n');
              } else {
                message =
                    data["message"]?.toString() ?? "Server error occurred.";
              }
            } else {
              message = data["message"]?.toString() ?? "Server error occurred.";
            }
          } else {
            message = error.response!.data.toString();
          }
        } else {
          message = "Received invalid response from server.";
        }
      } else if (error.type == DioExceptionType.connectionError) {
        message = "No internet connection.";
        return NetworkFailure(message);
      } else {
        message = error.message ?? "Unexpected network error occurred.";
      }
    } else {
      message = error.toString();
    }
    return ServerFailure(message);
  }
}
