import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/executive/executive_add_wallet_details_response_model.dart';
import 'package:maxpay/data/model/executive/executive_list_response_model.dart';
import 'package:maxpay/data/model/executive/executive_detail_response_model.dart';
import 'package:maxpay/data/model/executive/executive_commission_package_response_model.dart';
import '../../../core/constants/api_routes.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repository/executive_repo.dart';

class ExecutiveRepositoryImpl implements ExecutiveRepository {
  final ApiService _apiService;

  ExecutiveRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, ExecutiveListResponseModel>> getExecutives({
    int page = 1,
    String? isActive,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page};
      if (isActive != null) {
        queryParams['is_active'] = isActive;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _apiService.get(
        ApiRoutes.getExecutives,
        queryParameters: queryParams,
      );
      final model = ExecutiveListResponseModel.fromJson(response);

      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(
          ServerFailure(model.message ?? 'Server error: ${model.code}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ExecutiveDetailResponseModel>> getExecutiveDetail(
    String id,
  ) async {
    try {
      final formData = FormData.fromMap({'id': int.parse(id)});
      final response = await _apiService.post(
        ApiRoutes.getExecutiveDetail,
        data: formData,
      );
      final model = ExecutiveDetailResponseModel.fromJson(response);

      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(
          ServerFailure(model.message ?? 'Server error: ${model.code}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ExecutiveCommissionPackageResponseModel>>
  getExecutiveCommissionPackages() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.getExecutiveCommissionPackages,
      );
      final model = ExecutiveCommissionPackageResponseModel.fromJson(response);

      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(
          ServerFailure(model.message ?? 'Server error: ${model.code}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateExecutive(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.updateExecutive,
        data: data,
      );

      final code = response['code'];
      final success = response['success'];
      final message = response['message'] ?? 'Unknown response';

      if (code == 200 || code == 201) {
        if (success == true) {
          return Right(message);
        } else {
          return Left(ServerFailure(message));
        }
      } else {
        return Left(ServerFailure('Server error: $code - $message'));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ExecutiveAddWalletDetailsResponseModel>>
  getExecutiveAddWalletDetails(String id) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.addExecutiveWalletDetails,
        data: {'id': id},
      );

      final result = ExecutiveAddWalletDetailsResponseModel.fromJson(response);

      if (result.code == 200 || result.code == 201) {
        if (result.success == true) {
          return Right(result);
        } else {
          return Left(
            ServerFailure(
              result.message ?? 'Failed to fetch executive wallet details',
            ),
          );
        }
      } else {
        return Left(
          ServerFailure('Server error: ${result.code} - ${result.message}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> addExecutiveWallet(
    String id,
    String amount,
  ) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.addExecutiveWallet,
        data: {'id': id, 'amount': amount},
      );

      final success = response['success'] ?? false;
      final message =
          response['message'] ??
          (success ? 'Wallet added successfully' : 'Failed to add wallet');

      if (success) {
        return Right(message);
      } else {
        return Left(ServerFailure(message));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> createExecutive(
    Map<String, dynamic> data,
  ) async {
    try {
      final formData = FormData.fromMap(data);
      final response = await _apiService.post(
        ApiRoutes.distributorCreateExecutive,
        data: formData,
      );

      if (response['code'] == 200 ||
          response['status'] == true ||
          response['success'] == true) {
        return Right(
          response['message']?.toString() ?? 'Executive created successfully',
        );
      } else {
        return Left(
          ServerFailure(response['message'] ?? 'Failed to create executive'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
