import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/wallet_credit_type_model.dart';
import 'package:maxpay/domain/repository/wallet_credit_type_repository.dart';

class GetWalletCreditTypeUseCase {
  final WalletRepository repository;

  GetWalletCreditTypeUseCase(this.repository);

  Future<Either<Failure, WalletCreditType>> call() {
    return repository.getWalletCreditType();
  }
}