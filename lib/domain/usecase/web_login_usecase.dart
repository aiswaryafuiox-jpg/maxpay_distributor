import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/web_login_repo.dart';

class WebLoginUseCase {
  final WebLoginRepository repository;

  WebLoginUseCase(this.repository);

  Future<Either<Failure, String>> call(String qrUserId) {
    return repository.webLogin(qrUserId);
  }
}
