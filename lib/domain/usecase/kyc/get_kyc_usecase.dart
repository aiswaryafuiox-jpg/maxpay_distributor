import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/kyc_model.dart';
import 'package:maxpay/domain/repository/kyc_repo.dart';

class GetKycUseCase {
  final KycRepository repository;

  GetKycUseCase(this.repository);

  Future<Either<Failure, KycModel>> call() {
    return repository.getKyc();
  }
}
