import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import '../../data/model/update_fingerprint_response_model.dart';
import '../repository/login_send_otp_repo.dart';

class UpdateFingerprintUseCase {
  final LoginRepository repository;

  UpdateFingerprintUseCase(this.repository);

  Future<Either<Failure, UpdateFingerprintResponseModel>> call(int isFingerPrint) async {
    return await repository.updateFingerprint(isFingerPrint);
  }
}
