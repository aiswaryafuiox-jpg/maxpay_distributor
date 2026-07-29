import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/auto_transfer_details_model.dart';

abstract class AutoTransferDetailsRepository {
  Future<Either<Failure, AutoTransferDetailsModel>> getAutoTransferDetails(String id);
}
