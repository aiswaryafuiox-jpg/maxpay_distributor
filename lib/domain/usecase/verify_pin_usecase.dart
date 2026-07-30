import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import '../../data/model/verify_pin_response_model.dart';
import '../repository/login_send_otp_repo.dart';

class VerifyPinUseCase {
  final LoginRepository repository;

  VerifyPinUseCase(this.repository);

  Future<Either<Failure, VerifyPinResponseModel>> call(String pin) async {
    return await repository.verifyPin(pin);
  }
}
