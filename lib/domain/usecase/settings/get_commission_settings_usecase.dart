import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/settings/commission_settings_model.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

class GetCommissionSettingsUseCase {
  final CommissionSettingsRepository repository;

  GetCommissionSettingsUseCase(this.repository);

  Future<Either<Failure, CommissionSettingsModel>> call() async {
    return await repository.getCommissionSettings();
  }
}
