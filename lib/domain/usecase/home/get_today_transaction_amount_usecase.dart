import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/today_transaction_model.dart';
import 'package:maxpay/domain/repository/today_transaction_repo.dart';

class GetTodayTransactionAmountUseCase {
  final TodayTransactionRepository repository;

  GetTodayTransactionAmountUseCase(this.repository);

  Future<Either<Failure, TodayTransactionModel>> call() async {
    return await repository.getTodayTransactionAmount();
  }
}
