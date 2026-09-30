import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/create_qr_response_model.dart';
import 'package:maxpay/data/model/wallet_qr_history_model.dart';
import 'package:maxpay/domain/repository/create_qr_repo.dart';

class CreateQrRepoImpl implements CreateQrRepository {
  final ApiService _apiService;

  CreateQrRepoImpl(this._apiService);

  @override
  Future<Either<Failure, CreateQrResponseModel>> createQrAmount({
    required String amount,
  }) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.distributorCreateAddWalletQr,
        data: {'amount': amount},
      );
      final modelResponse = CreateQrResponseModel.fromJson(response);
      if (modelResponse.success ?? false) {
        return Right(modelResponse);
      } else {
        String errorMsg = parseValidationError(response);
        return Left(ServerFailure(errorMsg));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> checkQrStatus({required String txnId}) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.distributorCheckAddWalletQrStatus,
        data: {'txn_id': txnId},
      );
      if (response['success'] == true && response['code'] == 200) {
        final status =
            response['data']?['status']?.toString().toLowerCase() ?? 'pending';
        return Right(status);
      } else {
        return Left(
          ServerFailure(response['message'] ?? 'Failed to check status'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, WalletQrHistoryModel>> getWalletHistory() async {
    // try {
    final response = await _apiService.get(ApiRoutes.distributorWalletHistory);
    if (response['code'] == 200) {
      return Right(WalletQrHistoryModel.fromJson(response));
    } else {
      return Left(
        ServerFailure(response['message'] ?? 'Failed to fetch history'),
      );
    }
    // } catch (e) {
    //   return Left(DioErrorHandler.handle(e));
    // }
  }
}

String parseValidationError(Map<String, dynamic> responseData) {
  String finalMessage = responseData["message"]?.toString() ?? "Server error occurred.";

  if (responseData["errors"] != null && responseData["errors"] is Map) {
    final errorsMap = responseData["errors"] as Map;
    final List<String> errorMessages = [];
    
    // Iterate through each field's error list in the "errors" map
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
      // Joins all error lines, resulting in:
      // "The address field is required.\nThe selected commission package is invalid."
      finalMessage = errorMessages.join('\n');
    }
  }

  return finalMessage;
}
