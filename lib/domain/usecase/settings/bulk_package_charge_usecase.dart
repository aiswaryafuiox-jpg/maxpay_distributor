import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

class BulkPackageChargeUseCase {
  final CommissionSettingsRepository repository;

  BulkPackageChargeUseCase(this.repository);

  Future<Either<Failure, String>> call({required int packageId, required String userType}) async {
    return await repository.bulkPackageCharge(packageId: packageId, userType: userType);
  }
}
