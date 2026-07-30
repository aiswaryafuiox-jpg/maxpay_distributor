import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/today_transaction_model.dart';

abstract class TodayTransactionRepository {
  Future<Either<Failure, TodayTransactionModel>> getTodayTransactionAmount();
}
