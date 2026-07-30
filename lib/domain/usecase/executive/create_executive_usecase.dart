import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';

class CreateExecutiveUseCase {
  final ExecutiveRepository repository;

  CreateExecutiveUseCase(this.repository);

  Future<Either<Failure, String>> call(Map<String, dynamic> data) {
    return repository.createExecutive(data);
  }
}
