import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/data/model/wallet_credit_type_model.dart';
import 'package:maxpay/domain/repository/wallet_credit_type_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final ApiService apiService;

  WalletRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, WalletCreditType>> getWalletCreditType() async {
    try {
      final response = await apiService.get(ApiRoutes.getWalletCreditType);

      debugPrint("API Response => $response");

      final model = WalletCreditType.fromJson(response);

      debugPrint("Success => ${model.success}");
      debugPrint("Data Length => ${model.data?.length}");
      debugPrint("Data => ${model.data}");

      return Right(model);
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
