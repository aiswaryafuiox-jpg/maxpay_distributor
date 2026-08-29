import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/faq_model.dart';

abstract class FaqRepository {
  Future<Either<Failure, Faq>> getFaq();
}
