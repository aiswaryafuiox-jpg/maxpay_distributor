import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/partner/partner_list_response_model.dart';
import 'package:maxpay/domain/repository/partner_repository.dart';

class PartnerRepositoryImpl implements PartnerRepository {
  final ApiService _apiService;

  PartnerRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, MappedDistResponseModel>> getMappedDist() async {
    try {
      final response = await _apiService.get(ApiRoutes.getMappedDist);

      final model = MappedDistResponseModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch partner list."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
