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
      if (modelResponse.code == 200) {
        return Right(modelResponse);
      } else {
        return Left(
          ServerFailure(modelResponse.message ?? 'Failed to create QR'),
        );
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
      if (response['code'] == 200) {
        final status =
            response['data']?['status']?.toString() ??
            response['status']?.toString() ??
            'pending';
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
  Future<Either<Failure, WalletQrHistory>> getWalletHistory() async {
    // try {
    final response = await _apiService.get(ApiRoutes.distributorWalletHistory);
    if (response['code'] == 200) {
      return Right(WalletQrHistory.fromJson(response));
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
