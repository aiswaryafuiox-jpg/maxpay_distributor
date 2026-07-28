import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/constants/api_routes.dart';
import '../../core/error/failure.dart';
import '../../core/services/api_service.dart';
import '../../data/model/retailer/commission_package_response_model.dart';
import '../../data/model/retailer/create_retailer_response_model.dart';
import '../../data/model/retailer/update_retailer_response_model.dart';
import '../../data/model/retailer/retailer_detail_response_model.dart';
import '../../data/model/retailer/add_wallet_details_response_model.dart';
import '../../data/model/retailer/add_wallet_response_model.dart';
import '../../domain/repository/retailer_repo.dart';
import '../../domain/usecase/retailer/create_retailer_usecase.dart';
import '../../domain/usecase/retailer/update_retailer_usecase.dart';
import '../../domain/usecase/retailer/add_wallet_usecase.dart';
import '../model/retailer/retailer_list_response_model.dart';

class RetailerRepositoryImpl implements RetailerRepository {
  final ApiService _apiService;

  RetailerRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, RetailerListResponseModel>> getRetailers() async {
    try {
      final response = await _apiService.get(ApiRoutes.getRetailers);
      final model = RetailerListResponseModel.fromJson(response);
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
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RetailerDetailResponseModel>> getRetailerDetail(
    String id,
  ) async {
    try {
      final formData = FormData.fromMap({"id": id});
      final response = await _apiService.post(
        ApiRoutes.getRetailerDetail,
        data: formData,
      );
      final model = RetailerDetailResponseModel.fromJson(response);
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
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommissionPackageResponseModel>>
  getCommissionPackages() async {
    try {
      final response = await _apiService.get(ApiRoutes.getCommissionPackages);
      final model = CommissionPackageResponseModel.fromJson(response);
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
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateRetailerResponseModel>> createRetailer(CreateRetailerParams params) async {
    try {
      final formData = FormData.fromMap(params.toJson());
      final response = await _apiService.post(
        ApiRoutes.createRetailer,
        data: formData,
      );
      final model = CreateRetailerResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateRetailerResponseModel>> updateRetailer(UpdateRetailerParams params) async {
    try {
      final formData = FormData.fromMap(params.toJson());
      final response = await _apiService.post(
        ApiRoutes.updateRetailer,
        data: formData,
      );
      final model = UpdateRetailerResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddWalletDetailsResponseModel>> getAddWalletDetails(String id) async {
    try {
      final formData = FormData.fromMap({'id': id});
      final response = await _apiService.post(
        ApiRoutes.getAddWalletDetails,
        data: formData,
      );
      final model = AddWalletDetailsResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddWalletResponseModel>> addWallet(AddWalletParams params) async {
    try {
      final formData = FormData.fromMap(params.toJson());
      final response = await _apiService.post(
        ApiRoutes.addWallet,
        data: formData,
      );
      final model = AddWalletResponseModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
