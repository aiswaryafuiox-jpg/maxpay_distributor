import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/add_wallet_balance_model.dart';
import 'package:maxpay/domain/repository/add_wallet_balance_repo.dart';
import 'package:dio/dio.dart';

class AddWalletBalanceRepoImpl implements AddWalletBalanceRepository {
  final ApiService _apiService;

  AddWalletBalanceRepoImpl(this._apiService);

  @override
  Future<Either<Failure, AddWalletBalanceModel>> getWalletBalance() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorWalletBalance,
      );

      final responseModel = AddWalletBalanceModel.fromJson(response);
      if (responseModel.code == 200) {
        return Right(responseModel);
      } else {
        return Left(
          ServerFailure(
            responseModel.message ?? 'Failed to get wallet balance',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
