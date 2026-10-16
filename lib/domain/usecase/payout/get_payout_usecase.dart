import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/payout/payout_model.dart';
import 'package:maxpay/domain/repository/payout_repo.dart';

class GetPayoutUseCase {
  final PayoutRepository repository;

  GetPayoutUseCase(this.repository);

  Future<Either<Failure, PayoutModel>> call(String startDate, String endDate) {
    return repository.getPayout(startDate, endDate);
  }
}
