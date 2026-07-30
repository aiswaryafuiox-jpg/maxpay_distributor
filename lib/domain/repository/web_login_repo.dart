import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WebLoginRepository {
  Future<Either<Failure, String>> webLogin(String qrUserId);
  Future<Either<Failure, String>> webLogout(String isWebLogin);
}
