import 'package:dartz/dartz.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';
import '../../../core/error/failure.dart';

class UpdateExecutiveUseCase {
  final ExecutiveRepository repository;

  UpdateExecutiveUseCase(this.repository);

  Future<Either<Failure, String>> call(Map<String, dynamic> data) {
    return repository.updateExecutive(data);
  }
}
