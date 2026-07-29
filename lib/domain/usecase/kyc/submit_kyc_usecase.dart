import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/kyc_model.dart';
import 'package:maxpay/domain/repository/kyc_repo.dart';

class SubmitKycUseCase {
  final KycRepository repository;

  SubmitKycUseCase(this.repository);

  Future<Either<Failure, KycModel>> call({
    required String email,
    required String whatsappNumber,
    String? cancelledCheckPath,
    String? gstNoPath,
    String? panPath,
  }) {
    return repository.submitKyc(
      email: email,
      whatsappNumber: whatsappNumber,
      cancelledCheckPath: cancelledCheckPath,
      gstNoPath: gstNoPath,
      panPath: panPath,
    );
  }
}
