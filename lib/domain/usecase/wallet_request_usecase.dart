import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/wallet_request_model.dart';
import 'package:maxpay/domain/repository/wallet_request_repository.dart';

class WalletRequestUsecase {
  final WalletRequestRepository repository;

  WalletRequestUsecase(this.repository);

  Future<Either<Failure, WalletRequest>> call({
    required String amount,
    required String paymenttype,
    required String utrno,
    required String bankid,
    required String description,
    required String receipt,
  }) {
    return repository.walletRequest(
      amount: amount,
      paymenttype: paymenttype,
      utrno: utrno,
      bankid: bankid,
      description: description,
      receipt: receipt,
    );
  }
}
