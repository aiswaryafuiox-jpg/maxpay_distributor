import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/report/online_transaction_model.dart';
import 'package:maxpay/domain/repository/online_transaction_repo.dart';

class OnlineTransactionRepositoryImpl implements OnlineTransactionRepository {
  final ApiService _apiService;

  OnlineTransactionRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, OnlineTransactionModel>> getOnlineTransactions(OnlineTransactionParams params) async {
    try {
      final formData = FormData.fromMap({
        'from_date': params.fromDate,
        'to_date': params.toDate,
        'search': params.search,
        'status': params.status,
      });

      final response = await _apiService.post(ApiRoutes.distributorOnlineTransactions, data: formData);
      final model = OnlineTransactionModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? 'Failed to load transactions'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
