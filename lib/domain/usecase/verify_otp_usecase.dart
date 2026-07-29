import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import '../../data/model/login_verify_otp_response_model.dart';
import '../repository/login_send_otp_repo.dart';

class VerifyOtpUseCase {
  final LoginRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, LoginVerifyOtpResponseModel>> call(String mobile, String otp) async {
    return await repository.verifyOtp(mobile, otp);
  }
}
