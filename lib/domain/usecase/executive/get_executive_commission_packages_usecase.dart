import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/executive/executive_commission_package_response_model.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';
import '../../../core/error/failure.dart';

class GetExecutiveCommissionPackagesUseCase {
  final ExecutiveRepository repository;

  GetExecutiveCommissionPackagesUseCase(this.repository);

  Future<Either<Failure, ExecutiveCommissionPackageResponseModel>> call() {
    return repository.getExecutiveCommissionPackages();
  }
}
