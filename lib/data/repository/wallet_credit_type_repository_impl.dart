import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/service/api_service.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/data/model/wallet_credit_type_model.dart';
import 'package:maxpay/domain/repository/wallet_credit_type_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final ApiService apiService;

  WalletRepositoryImpl(this.apiService);

  @override
Future<Either<Failure, WalletCreditType>> getWalletCreditType() async {
  try {
    final response = await apiService.get(
      ApiRoutes.getWalletCreditType,
    );

    print("API Response => $response");

    final model = WalletCreditType.fromJson(response);

    print("Success => ${model.success}");
    print("Data Length => ${model.data?.length}");
    print("Data => ${model.data}");

    return Right(model);
  } catch (e) {
    print(e);
    return Left(ServerFailure(message: e.toString()));
  }
}
}