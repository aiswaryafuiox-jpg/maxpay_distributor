import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

class ResetPackageCommissionUseCase {
  final CommissionSettingsRepository repository;

  ResetPackageCommissionUseCase(this.repository);

  Future<Either<Failure, String>> call({required int id}) async {
    return await repository.resetPackageCommission(id: id);
  }
}
