import '../../data/model/login_sendOtp_response_model.dart';

abstract class LoginRepository {
  Future<LoginSendOtpResponseModel> sendOtp(
      String mobile,
      );
}