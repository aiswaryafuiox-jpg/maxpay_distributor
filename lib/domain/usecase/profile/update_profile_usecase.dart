import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/profile/update_profile_response_model.dart';
import '../../repository/profile_repo.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, UpdateProfileResponseModel>> call(FormData formData) {
    return repository.updateProfile(formData);
  }
}
