import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/low_wallet_retailers_model.dart';
import 'package:maxpay/domain/repository/low_wallet_repo.dart';


class GetLowWalletRetailersUseCase {
  final LowWalletRepository repository;

  GetLowWalletRetailersUseCase(this.repository);

  Future<Either<Failure, LowWalletRetailersModel>> call() async {
    return await repository.getLowWalletRetailers();
  }
}
