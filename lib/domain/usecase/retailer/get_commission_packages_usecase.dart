import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/commission_package_response_model.dart';
import '../../repository/retailer_repo.dart';

class GetCommissionPackagesUseCase {
  final RetailerRepository repository;

  GetCommissionPackagesUseCase(this.repository);

  Future<Either<Failure, CommissionPackageResponseModel>> call() {
    return repository.getCommissionPackages();
  }
}
