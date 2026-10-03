import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/today_transaction_model.dart';
import 'package:maxpay/domain/repository/today_transaction_repo.dart';

class TodayTransactionRepositoryImpl implements TodayTransactionRepository {
  final ApiService _apiService;

  TodayTransactionRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, TodayTransactionModel>>
  getTodayTransactionAmount() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorTodayTransactionAmount,
      );

      debugPrint("Today Transaction Amount API Response: $response");

      final model = TodayTransactionModel.fromJson(response);
      return Right(model);
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
