import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/login_send_otp_repo.dart';

class SendUpdateMpinOtpUseCase {
  final LoginRepository repository;

  SendUpdateMpinOtpUseCase(this.repository);

  Future<Either<Failure, String>> call() {
    return repository.sendUpdateMpinOtp();
  }
}
