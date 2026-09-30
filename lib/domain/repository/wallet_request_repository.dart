import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/wallet_request_model.dart';

abstract class WalletRequestRepository {
  Future<Either<Failure, WalletRequest>> walletRequest({
    required String amount,
    required String paymenttype,
    required String utrno,
    required String bankid,
    required String description,
    required String receipt,
  });
}
