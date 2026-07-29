import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/logout_response_model.dart';
import '../repository/login_send_otp_repo.dart';

class LogoutUseCase {
  final LoginRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, LogoutResponseModel>> call() async {
    return await repository.logout();
  }
}
