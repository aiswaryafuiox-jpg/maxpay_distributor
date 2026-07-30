import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/add_wallet_balance_model.dart';

abstract class AddWalletBalanceRepository {
  Future<Either<Failure, AddWalletBalanceModel>> getWalletBalance();
}
