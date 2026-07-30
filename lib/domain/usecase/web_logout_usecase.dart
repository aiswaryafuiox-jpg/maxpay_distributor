import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/web_login_repo.dart';

class WebLogoutUseCase {
  final WebLoginRepository repository;

  WebLogoutUseCase(this.repository);

  Future<Either<Failure, String>> call(String isWebLogin) {
    return repository.webLogout(isWebLogin);
  }
}
