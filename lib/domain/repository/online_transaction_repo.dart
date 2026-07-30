import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/report/online_transaction_model.dart';

class OnlineTransactionParams {
  final String fromDate;
  final String toDate;
  final String search;
  final String status;

  OnlineTransactionParams({
    required this.fromDate,
    required this.toDate,
    required this.search,
    required this.status,
  });
}

abstract class OnlineTransactionRepository {
  Future<Either<Failure, OnlineTransactionModel>> getOnlineTransactions(OnlineTransactionParams params);
}
