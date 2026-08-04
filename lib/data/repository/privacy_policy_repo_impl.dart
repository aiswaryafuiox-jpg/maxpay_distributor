import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/privacy_policy_model.dart';
import 'package:maxpay/domain/repository/privacy_policy_repo.dart';

class PrivacyPolicyRepoImpl implements PrivacyPolicyRepository {
  final ApiService _apiService;

  PrivacyPolicyRepoImpl(this._apiService);

  @override
  Future<Either<Failure, PrivacyPolicyModel>> getPrivacyPolicy() async {
    try {
      final response = await _apiService.get(ApiRoutes.distributorPrivacyPolicy);
      final model = PrivacyPolicyModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch Privacy Policy."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
