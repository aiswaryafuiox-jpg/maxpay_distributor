import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/login_send_otp_repo.dart';

class VerifyUpdateMpinOtpUseCase {
  final LoginRepository repository;

  VerifyUpdateMpinOtpUseCase(this.repository);

  Future<Either<Failure, String>> call(String otp) {
    return repository.verifyUpdateMpinOtp(otp);
  }
}
