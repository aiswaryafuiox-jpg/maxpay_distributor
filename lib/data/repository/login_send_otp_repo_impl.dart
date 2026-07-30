import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/constants/api_routes.dart';
import '../../core/error/failure.dart';
import '../../core/services/api_service.dart';
import '../../domain/repository/login_send_otp_repo.dart';
import '../model/login_send_otp_response_model.dart';
import '../model/login_verify_otp_response_model.dart';
import '../model/create_pin_response_model.dart';
import '../model/verify_pin_response_model.dart';
import '../model/update_fingerprint_response_model.dart';
import '../model/logout_response_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiService apiService;

  LoginRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, LoginSendOtpResponseModel>> sendOtp(String mobile) async {
    try {
      final formData = FormData.fromMap({
        "country_code": "+91",
        "phone_number": mobile,
      });

      final response = await apiService.post(
        ApiRoutes.loginSendOtp,
        data: formData,
      );

      return Right(LoginSendOtpResponseModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['message'] ?? e.message ?? "An error occurred"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginVerifyOtpResponseModel>> verifyOtp(String mobile, String otp) async {
    try {
      final formData = FormData.fromMap({
        "phone_number": mobile,
        "otp": otp,
      });

      final response = await apiService.post(
        ApiRoutes.verifyOtp,
        data: formData,
      );

      return Right(LoginVerifyOtpResponseModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['message'] ?? e.message ?? "An error occurred"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreatePinResponseModel>> createPin(String pin) async {
    try {
      final formData = FormData.fromMap({
        "pin": pin,
      });

      final response = await apiService.post(
        ApiRoutes.createPin,
        data: formData,
      );

      return Right(CreatePinResponseModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['message'] ?? e.message ?? "An error occurred"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyPinResponseModel>> verifyPin(String pin) async {
    try {
      final formData = FormData.fromMap({
        "pin": pin,
      });

      final response = await apiService.post(
        ApiRoutes.verifyPin,
        data: formData,
      );

      return Right(VerifyPinResponseModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['message'] ?? e.message ?? "An error occurred"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateFingerprintResponseModel>> updateFingerprint(int isFingerPrint) async {
    try {
      final formData = FormData.fromMap({
        "is_finger_print": isFingerPrint.toString(),
      });

      final response = await apiService.post(
        ApiRoutes.updateFingerprint,
        data: formData,
      );

      return Right(UpdateFingerprintResponseModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['message'] ?? e.message ?? "An error occurred"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogoutResponseModel>> logout() async {
    try {
      final response = await apiService.post(ApiRoutes.logout);
      return Right(LogoutResponseModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['message'] ?? e.message ?? "An error occurred"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendUpdateMpinOtp() async {
    try {
      final response = await apiService.post(ApiRoutes.distributorUpdateMpinSendOtp);
      if (response['code'] == 200 || response['status'] == true) {
        return Right(response['message']?.toString() ?? 'OTP sent successfully');
      } else {
        return Left(ServerFailure(response['message'] ?? 'Failed to send OTP'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return Left(ServerFailure(e.response!.data['message'] ?? 'Server error'));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updatePin(String otp, String newPin, String confirmPin) async {
    try {
      final formData = FormData.fromMap({
        'otp': otp,
        'new_pin': newPin,
        'confirm_pin': confirmPin,
      });

      final response = await apiService.post(
        ApiRoutes.distributorUpdateMpin,
        data: formData,
      );
      if (response['code'] == 200 || response['status'] == true) {
        return Right(response['message']?.toString() ?? 'PIN updated successfully');
      } else {
        return Left(ServerFailure(response['message'] ?? 'Failed to update PIN'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return Left(ServerFailure(e.response!.data['message'] ?? 'Server error'));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}