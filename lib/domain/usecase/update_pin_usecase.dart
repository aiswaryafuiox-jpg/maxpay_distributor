import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/login_send_otp_repo.dart';

class UpdatePinUseCase {
  final LoginRepository repository;

  UpdatePinUseCase(this.repository);

  Future<Either<Failure, String>> call(String otp, String newPin, String confirmPin) {
    return repository.updatePin(otp, newPin, confirmPin);
  }
}
