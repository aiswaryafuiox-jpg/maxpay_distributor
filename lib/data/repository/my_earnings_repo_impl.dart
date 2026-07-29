import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/my_earnings/my_earnings_model.dart';
import 'package:maxpay/domain/repository/my_earnings_repo.dart';

class MyEarningsRepoImpl implements MyEarningsRepository {
  final ApiService _apiService;

  MyEarningsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, MyEarningsModel>> getMyEarnings(String fromDate, String toDate, String search) async {
    try {
      final formData = FormData.fromMap({
        'from_date': fromDate,
        'to_date': toDate,
        'search': search,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorMyEarnings,
        data: formData,
      );

      final model = MyEarningsModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? "Failed to fetch my earnings."));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
