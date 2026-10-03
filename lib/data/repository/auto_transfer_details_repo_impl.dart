import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/auto_transfer_details_model.dart';
import 'package:maxpay/domain/repository/auto_transfer_details_repo.dart';

class AutoTransferDetailsRepoImpl implements AutoTransferDetailsRepository {
  final ApiService _apiService;

  AutoTransferDetailsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, AutoTransferDetailsModel>> getAutoTransferDetails(
    String id,
  ) async {
    try {
      final formData = FormData.fromMap({'id': id});

      final response = await _apiService.post(
        ApiRoutes.distributorAutoTransferDetails,
        data: formData,
      );

      final model = AutoTransferDetailsModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(
            model.message ?? "Failed to fetch auto transfer details.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
