import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/support_model.dart';
import 'package:maxpay/domain/repository/support_repo.dart';

class SupportRepoImpl implements SupportRepository {
  final ApiService _apiService;

  SupportRepoImpl(this._apiService);

  @override
  Future<Either<Failure, SupportModel>> getSupport() async {
    try {
      final response = await _apiService.get(ApiRoutes.distributorGetSupport);
      final model = SupportModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? "Failed to fetch support contacts."));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
