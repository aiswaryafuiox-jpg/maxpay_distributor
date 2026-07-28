import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/constants/api_routes.dart';
import '../../core/error/failure.dart';
import '../../core/services/api_service.dart';
import '../../data/model/low_wallet_retailers_model.dart';
import '../../domain/repository/low_wallet_repo.dart';

class LowWalletRepoImpl implements LowWalletRepository {
  final ApiService _apiService;

  LowWalletRepoImpl(this._apiService);

  @override
  Future<Either<Failure, LowWalletRetailersModel>> getLowWalletRetailers() async {
    try {
      final response = await _apiService.get(ApiRoutes.distributorLowWalletRetailers);
      final model = LowWalletRetailersModel.fromJson(response);
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
