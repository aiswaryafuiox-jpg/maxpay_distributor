import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/privacy_policy_model.dart';

abstract class PrivacyPolicyRepository {
  Future<Either<Failure, PrivacyPolicyModel>> getPrivacyPolicy();
}
