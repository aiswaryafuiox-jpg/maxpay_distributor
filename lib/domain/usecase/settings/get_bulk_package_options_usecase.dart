import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/settings/bulk_package_options_model.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

class GetBulkPackageOptionsUseCase {
  final CommissionSettingsRepository repository;

  GetBulkPackageOptionsUseCase(this.repository);

  Future<Either<Failure, BulkPackageOptionsModel>> call() async {
    return await repository.getBulkPackageOptions();
  }
}
