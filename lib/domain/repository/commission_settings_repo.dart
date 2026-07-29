import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/settings/commission_settings_model.dart';
import 'package:maxpay/data/model/settings/bulk_package_options_model.dart';

abstract class CommissionSettingsRepository {
  Future<Either<Failure, CommissionSettingsModel>> getCommissionSettings();
  Future<Either<Failure, String>> updatePackageStatus({required int id, required String type, required String status});
  Future<Either<Failure, String>> resetPackageCommission({required int id});
  Future<Either<Failure, BulkPackageOptionsModel>> getBulkPackageOptions();
  Future<Either<Failure, String>> bulkPackageCharge({required int packageId, required String userType});
  Future<Either<Failure, String>> bulkPackageChange({required int packageId, required String status});
}
