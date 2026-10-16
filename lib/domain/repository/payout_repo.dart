import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/payout/payout_model.dart';

abstract class PayoutRepository {
  Future<Either<Failure, PayoutModel>> getPayout(
    String startDate,
    String endDate,
  );
}
