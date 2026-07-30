import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/add_wallet_balance_model.dart';
import 'package:maxpay/domain/repository/add_wallet_balance_repo.dart';

class GetAddWalletBalanceUseCase {
  final AddWalletBalanceRepository repository;

  GetAddWalletBalanceUseCase(this.repository);

  Future<Either<Failure, AddWalletBalanceModel>> call() {
    return repository.getWalletBalance();
  }
}
