import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

class BulkPackageChangeUseCase {
  final CommissionSettingsRepository repository;

  BulkPackageChangeUseCase(this.repository);

  Future<Either<Failure, String>> call({required int packageId, required String status}) async {
    return await repository.bulkPackageChange(packageId: packageId, status: status);
  }
}
