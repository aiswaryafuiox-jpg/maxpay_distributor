import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/profile/update_status_send_otp_response_model.dart';
import '../../repository/profile_repo.dart';

class UpdateStatusSendOtpUseCase {
  final ProfileRepository repository;

  UpdateStatusSendOtpUseCase(this.repository);

  Future<Either<Failure, UpdateStatusSendOtpResponseModel>> call(int isActive) {
    return repository.updateStatusSendOtp(isActive);
  }
}
