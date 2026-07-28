import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/profile/get_profile_response_model.dart';
import '../../repository/profile_repo.dart';

class VerifyUpdateStatusOtpUseCase {
  final ProfileRepository repository;

  VerifyUpdateStatusOtpUseCase(this.repository);

  Future<Either<Failure, GetProfileResponseModel>> call(String otp) {
    return repository.verifyUpdateStatusOtp(otp);
  }
}
