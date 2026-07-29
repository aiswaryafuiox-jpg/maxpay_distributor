import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/support_model.dart';

abstract class SupportRepository {
  Future<Either<Failure, SupportModel>> getSupport();
}
