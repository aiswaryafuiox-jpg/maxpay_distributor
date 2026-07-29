import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/report/online_transaction_model.dart';
import 'package:maxpay/domain/repository/online_transaction_repo.dart';

class GetOnlineTransactionUseCase {
  final OnlineTransactionRepository repository;

  GetOnlineTransactionUseCase(this.repository);

  Future<Either<Failure, OnlineTransactionModel>> call(OnlineTransactionParams params) async {
    return await repository.getOnlineTransactions(params);
  }
}
