import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';

import '../../data/model/profile/get_profile_response_model.dart';
import '../../data/model/profile/update_profile_response_model.dart';
import '../../data/model/profile/update_status_send_otp_response_model.dart';
import 'package:dio/dio.dart' as dio;

abstract class ProfileRepository {
  Future<Either<Failure, GetProfileResponseModel>> getProfile();
  Future<Either<Failure, UpdateProfileResponseModel>> updateProfile(dio.FormData formData);
  Future<Either<Failure, GetProfileResponseModel>> verifyUpdateProfileOtp(String otp);
  Future<Either<Failure, UpdateProfileResponseModel>> resendUpdateProfileOtp();
  Future<Either<Failure, UpdateStatusSendOtpResponseModel>> updateStatusSendOtp(int isActive);
  Future<Either<Failure, GetProfileResponseModel>> verifyUpdateStatusOtp(String otp);
}
