import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/profile/update_profile_response_model.dart';
import '../../repository/profile_repo.dart';

class ResendUpdateProfileOtpUseCase {
  final ProfileRepository repository;

  ResendUpdateProfileOtpUseCase(this.repository);

  Future<Either<Failure, UpdateProfileResponseModel>> call() {
    return repository.resendUpdateProfileOtp();
  }
}
