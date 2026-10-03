import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/privacy_policy_model.dart';
import 'package:maxpay/domain/repository/privacy_policy_repo.dart';

class GetPrivacyPolicyUseCase {
  final PrivacyPolicyRepository repository;

  GetPrivacyPolicyUseCase(this.repository);

  Future<Either<Failure, PrivacyPolicyModel>> call() {
    return repository.getPrivacyPolicy();
  }
}
