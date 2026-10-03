import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
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
        return Left(
          ServerFailure(model.message ?? "Failed to fetch support contacts."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
