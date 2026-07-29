import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/wallet_credit_list_model.dart';

abstract class WalletCreditListRepository {
  Future<Either<Failure, WalletCreditListModel>> getWalletCreditList(
    String type,
    String fromDate,
    String toDate,
    String search,
  );
}
