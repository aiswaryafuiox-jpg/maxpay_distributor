import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

class UpdatePackageStatusUseCase {
  final CommissionSettingsRepository repository;

  UpdatePackageStatusUseCase(this.repository);

  Future<Either<Failure, String>> call({required int id, required String type, required String status}) async {
    return await repository.updatePackageStatus(id: id, type: type, status: status);
  }
}
