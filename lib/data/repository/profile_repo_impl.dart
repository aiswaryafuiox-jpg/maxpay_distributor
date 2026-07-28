import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';

import '../../core/services/api_service.dart';
import '../../domain/repository/profile_repo.dart';
import '../model/profile/get_profile_response_model.dart';
import '../model/profile/update_profile_response_model.dart';
import '../model/profile/update_status_send_otp_response_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, GetProfileResponseModel>> getProfile() async {
    try {
      final response = await _apiService.get(ApiRoutes.getProfile);

      final model = GetProfileResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(
            ServerFailure(model.message ?? 'Failed to fetch profile'),
          );
        }
      } else {
        return Left(ServerFailure('Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(e.response?.data['message'] ?? 'API error occurred'),
        );
      } else {
        return Left(ServerFailure('Network error. Please try again.'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponseModel>> updateProfile(FormData formData) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.updateProfile,
        data: formData,
      );
      
      final model = UpdateProfileResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Failed to update profile'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(e.response?.data['message'] ?? 'API error occurred'));
      } else {
        return Left(ServerFailure('Network error. Please try again.'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetProfileResponseModel>> verifyUpdateProfileOtp(String otp) async {
    try {
      final formData = FormData.fromMap({"otp": otp});
      final response = await _apiService.post(
        ApiRoutes.updateProfileVerifyOtp,
        data: formData,
      );
      
      final model = GetProfileResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Failed to verify OTP'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(e.response?.data['message'] ?? 'API error occurred'));
      } else {
        return Left(ServerFailure('Network error. Please try again.'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponseModel>> resendUpdateProfileOtp() async {
    try {
      final response = await _apiService.post(
        ApiRoutes.updateProfileResendOtp,
      );
      
      final model = UpdateProfileResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Failed to resend OTP'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(e.response?.data['message'] ?? 'API error occurred'));
      } else {
        return Left(ServerFailure('Network error. Please try again.'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateStatusSendOtpResponseModel>> updateStatusSendOtp(int isActive) async {
    try {
      final formData = FormData.fromMap({"is_active": isActive});
      final response = await _apiService.post(
        ApiRoutes.updateStatusSendOtp,
        data: formData,
      );
      
      final model = UpdateStatusSendOtpResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Failed to send OTP for status update'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(e.response?.data['message'] ?? 'API error occurred'));
      } else {
        return Left(ServerFailure('Network error. Please try again.'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetProfileResponseModel>> verifyUpdateStatusOtp(String otp) async {
    try {
      final formData = FormData.fromMap({"otp": otp});
      final response = await _apiService.post(
        ApiRoutes.updateStatusVerifyOtp,
        data: formData,
      );
      
      final model = GetProfileResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Failed to verify OTP'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(e.response?.data['message'] ?? 'API error occurred'));
      } else {
        return Left(ServerFailure('Network error. Please try again.'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
