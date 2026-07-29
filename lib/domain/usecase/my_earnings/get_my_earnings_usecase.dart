import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/my_earnings/my_earnings_model.dart';
import 'package:maxpay/domain/repository/my_earnings_repo.dart';

class GetMyEarningsUseCase {
  final MyEarningsRepository repository;

  GetMyEarningsUseCase(this.repository);

  Future<Either<Failure, MyEarningsModel>> call(String fromDate, String toDate, String search) {
    return repository.getMyEarnings(fromDate, toDate, search);
  }
}
