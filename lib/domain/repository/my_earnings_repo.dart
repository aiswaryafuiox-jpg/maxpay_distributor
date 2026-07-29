import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/my_earnings/my_earnings_model.dart';

abstract class MyEarningsRepository {
  Future<Either<Failure, MyEarningsModel>> getMyEarnings(String fromDate, String toDate, String search);
}
