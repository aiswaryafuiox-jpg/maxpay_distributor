import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';

import '../../../data/model/profile/get_profile_response_model.dart';
import '../../repository/profile_repo.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, GetProfileResponseModel>> call() {
    return repository.getProfile();
  }
}
