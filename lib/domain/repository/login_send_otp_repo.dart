import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import '../../data/model/login_send_otp_response_model.dart';
import '../../data/model/login_verify_otp_response_model.dart';
import '../../data/model/create_pin_response_model.dart';
import '../../data/model/verify_pin_response_model.dart';
import '../../data/model/update_fingerprint_response_model.dart';
import '../../data/model/logout_response_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginSendOtpResponseModel>> sendOtp(String mobile);
  Future<Either<Failure, LoginVerifyOtpResponseModel>> verifyOtp(String mobile, String otp);
  Future<Either<Failure, CreatePinResponseModel>> createPin(String pin);
  Future<Either<Failure, VerifyPinResponseModel>> verifyPin(String pin);
  Future<Either<Failure, UpdateFingerprintResponseModel>> updateFingerprint(int isFingerPrint);
  Future<Either<Failure, LogoutResponseModel>> logout();
}
