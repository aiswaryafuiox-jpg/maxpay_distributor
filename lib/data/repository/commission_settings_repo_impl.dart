import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/settings/commission_settings_model.dart';
import 'package:maxpay/data/model/settings/bulk_package_options_model.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

class CommissionSettingsRepoImpl implements CommissionSettingsRepository {
  final ApiService _apiService;

  CommissionSettingsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, CommissionSettingsModel>>
  getCommissionSettings() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorCommissionSettings,
      );
      final model = CommissionSettingsModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(
            model.message ?? "Failed to fetch commission settings.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> updatePackageStatus({
    required int id,
    required String type,
    required String status,
  }) async {
    try {
      final formData = FormData.fromMap({
        'id': id,
        'type': type,
        'status': status,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorUpdatePackageStatus,
        data: formData,
      );

      if (response['success'] == true) {
        return Right(
          response['message'] ?? 'Package status updated successfully',
        );
      } else {
        return Left(
          ServerFailure(
            response['message'] ?? "Failed to update package status.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> resetPackageCommission({
    required int id,
  }) async {
    try {
      final formData = FormData.fromMap({'id': id});

      final response = await _apiService.post(
        ApiRoutes.distributorResetPackageCommission,
        data: formData,
      );

      if (response['success'] == true) {
        return Right(
          response['message'] ?? 'Package commission reset successfully',
        );
      } else {
        return Left(
          ServerFailure(
            response['message'] ?? "Failed to reset package commission.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, BulkPackageOptionsModel>>
  getBulkPackageOptions() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorBulkPackageOptions,
      );
      final model = BulkPackageOptionsModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(
            model.message ?? "Failed to fetch bulk package options.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> bulkPackageCharge({
    required int packageId,
    required String userType,
  }) async {
    try {
      final formData = FormData.fromMap({
        'package_id': packageId,
        'user_type': userType,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorBulkPackageCharge,
        data: formData,
      );

      if (response['success'] == true) {
        return Right(
          response['message'] ?? 'Bulk package charge applied successfully',
        );
      } else {
        return Left(
          ServerFailure(
            response['message'] ?? "Failed to apply bulk package charge.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> bulkPackageChange({
    required int packageId,
    required String status,
  }) async {
    try {
      final formData = FormData.fromMap({
        'package_id': packageId,
        'status': status,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorBulkPackageChange,
        data: formData,
      );

      if (response['success'] == true) {
        return Right(
          response['message'] ?? 'Bulk package change applied successfully',
        );
      } else {
        return Left(
          ServerFailure(
            response['message'] ?? "Failed to apply bulk package change.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
