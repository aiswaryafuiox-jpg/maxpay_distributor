import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/report/reg_charge_detail_model.dart';

class RegChargeDetailParams {
  final String fromDate;
  final String toDate;
  final String search;

  RegChargeDetailParams({
    required this.fromDate,
    required this.toDate,
    required this.search,
  });
}

abstract class RegChargeRepository {
  Future<Either<Failure, RegChargeDetailModel>> getRegChargeDetail(RegChargeDetailParams params);
}
