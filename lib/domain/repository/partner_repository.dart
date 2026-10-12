import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/partner/partner_list_response_model.dart';

abstract class PartnerRepository {
  Future<Either<Failure, MappedDistResponseModel>> getMappedDist();
}
