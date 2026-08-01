import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import '../../core/constants/api_routes.dart';
import '../../core/error/failure.dart';
import '../../core/services/api_service.dart';
import '../../data/model/pending_wallet_request_model.dart';
import '../../data/model/pending_wallet_request_detail_model.dart';
import '../../data/model/approve_wallet_request_model.dart';
import '../../domain/repository/pending_wallet_request_repo.dart';

class PendingWalletRequestRepoImpl implements PendingWalletRequestRepository {
  final ApiService _apiService;

  PendingWalletRequestRepoImpl(this._apiService);

  @override
  Future<Either<Failure, PendingWalletRequestModel>>
  getPendingWalletRequests() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorPendingWalletRequests,
      );
      final model = PendingWalletRequestModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(
          ServerFailure(model.message ?? 'Server error: ${model.code}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, PendingWalletRequestDetailModel>>
  getPendingWalletRequestDetail(int id) async {
    try {
      final formData = FormData.fromMap({"id": id});
      final response = await _apiService.post(
        ApiRoutes.distributorPendingWalletRequestDetail,
        data: formData,
      );
      final model = PendingWalletRequestDetailModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(
          ServerFailure(model.message ?? 'Server error: ${model.code}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ApproveWalletRequestModel>>
  approvePendingWalletRequest(int id, String confirmAmount) async {
    try {
      final formData = FormData.fromMap({
        "id": id,
        "confirm_amount": confirmAmount,
      });
      final response = await _apiService.post(
        ApiRoutes.distributorApprovePendingWalletRequest,
        data: formData,
      );
      final model = ApproveWalletRequestModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(
          ServerFailure(model.message ?? 'Server error: ${model.code}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
