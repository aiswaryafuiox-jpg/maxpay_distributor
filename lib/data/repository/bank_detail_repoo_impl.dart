import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/data/model/bank_details_model.dart';
import 'package:maxpay/domain/repository/bank_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';

class BankDetailRepooImpl implements BankDetailRepository {
  final ApiService apiService;
  BankDetailRepooImpl(this.apiService);

  @override
  Future<Either<Failure, BankDetails>> bankdetail() async {
    try {
      final response = await apiService.get(ApiRoutes.bankdetail);
      final model = BankDetails.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { AppLogger.logError("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(e.toString()));
    }
  }
}
