import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/login_history_model.dart';
import 'package:maxpay/domain/repository/login_history_repo.dart';

class LoginHistoryRepoImpl implements LoginHistoryRepository {
  final ApiService _apiService;

  LoginHistoryRepoImpl(this._apiService);

  @override
  Future<Either<Failure, LoginHistoryModel>> getLoginHistory({
    required String fromDate,
    required String toDate,
    String search = "",
  }) async {
    try {
      final formData = FormData.fromMap({
        'from_date': fromDate,
        'to_date': toDate,
        'search': search,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorLoginHistory,
        data: formData,
      );

      final model = LoginHistoryModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? "Failed to fetch login history."));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
