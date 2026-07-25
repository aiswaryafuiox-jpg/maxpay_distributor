import '../../data/model/login_sendOtp_response_model.dart';
import '../repository/login_sendOtp_repo.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<LoginSendOtpResponseModel> call(
      String mobile,
      ) {
    return repository.sendOtp(mobile);
  }
}