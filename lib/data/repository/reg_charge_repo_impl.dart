import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/report/reg_charge_detail_model.dart';
import 'package:maxpay/domain/repository/reg_charge_repo.dart';

class RegChargeRepositoryImpl implements RegChargeRepository {
  final ApiService _apiService;

  RegChargeRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, RegChargeDetailModel>> getRegChargeDetail(
    RegChargeDetailParams params,
  ) async {
    try {
      final formData = FormData.fromMap({
        'from_date': params.fromDate,
        'to_date': params.toDate,
        'search': params.search,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorRegChargeDetail,
        data: formData,
      );
      final model = RegChargeDetailModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? 'Failed to load details'));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
