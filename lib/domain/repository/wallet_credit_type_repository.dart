import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/wallet_credit_type_model.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletCreditType>> getWalletCreditType();
}