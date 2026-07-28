import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import '../../data/model/login_sendOtp_response_model.dart';
import '../repository/login_sendOtp_repo.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginSendOtpResponseModel>> call(String mobile) async {
    return await repository.sendOtp(mobile);
  }
}