import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/payout/payout_model.dart';
import 'package:maxpay/domain/repository/payout_repo.dart';

class PayoutRepoImpl implements PayoutRepository {
  final ApiService _apiService;

  PayoutRepoImpl(this._apiService);

  @override
  Future<Either<Failure, PayoutModel>> getPayout(
    String startDate,
    String endDate,
  ) async {
    try {
      final formData = FormData.fromMap({
        'start_date': startDate,
        'end_date': endDate,
      });

      final response = await _apiService.post(ApiRoutes.payOut, data: formData);

      final model = PayoutModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch payout details."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
