import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import '../../data/model/login_verifyOtp_response_model.dart';
import '../repository/login_sendOtp_repo.dart';

class VerifyOtpUseCase {
  final LoginRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, LoginVerifyOtpResponseModel>> call(String mobile, String otp) async {
    return await repository.verifyOtp(mobile, otp);
  }
}
