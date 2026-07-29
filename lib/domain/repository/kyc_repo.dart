import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/kyc_model.dart';

abstract class KycRepository {
  Future<Either<Failure, KycModel>> getKyc();
  Future<Either<Failure, KycModel>> submitKyc({
    required String email,
    required String whatsappNumber,
    String? cancelledCheckPath,
    String? gstNoPath,
    String? panPath,
  });
}
