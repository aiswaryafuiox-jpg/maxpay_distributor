import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import '../../core/constants/api_routes.dart';
import '../../core/error/failure.dart';
import '../../core/services/api_service.dart';
import '../../data/model/wallet_credit_list_model.dart';
import '../../domain/repository/wallet_credit_list_repo.dart';

class WalletCreditListRepoImpl implements WalletCreditListRepository {
  final ApiService _apiService;

  WalletCreditListRepoImpl(this._apiService);

  @override
  Future<Either<Failure, WalletCreditListModel>> getWalletCreditList(
    String type,
    String fromDate,
    String toDate,
    String search,
  ) async {
    try {
      final formData = FormData.fromMap({
        'type': type,
        'from_date': fromDate,
        'to_date': toDate,
        'search': search,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorWalletCreditList,
        data: formData,
      );

      final model = WalletCreditListModel.fromJson(response);
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
}
