import 'package:dio/dio.dart';

import '../../core/constants/api_routes.dart';
import '../../core/services/api_service.dart';
import '../../domain/repository/login_sendOtp_repo.dart';
import '../model/login_sendOtp_response_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiService apiService;

  LoginRepositoryImpl(this.apiService);

  @override
  Future<LoginSendOtpResponseModel> sendOtp(
      String mobile,
      ) async {
    final formData = FormData.fromMap({
      "country_code": "+91",
      "phone_number": mobile,
    });

    final response = await apiService.post(
      ApiRoutes.loginSendOtp,
      data: formData,
    );

    return LoginSendOtpResponseModel.fromJson(response);
  }
}