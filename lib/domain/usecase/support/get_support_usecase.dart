import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/support_model.dart';
import 'package:maxpay/domain/repository/support_repo.dart';

class GetSupportUseCase {
  final SupportRepository repository;

  GetSupportUseCase(this.repository);

  Future<Either<Failure, SupportModel>> call() {
    return repository.getSupport();
  }
}
