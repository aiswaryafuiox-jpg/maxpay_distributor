import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/create_qr_response_model.dart';
import 'package:maxpay/data/model/wallet_qr_history_model.dart';
import 'package:maxpay/domain/repository/create_qr_repo.dart';

class CreateQrUsecase {
  final CreateQrRepository repository;

  CreateQrUsecase(this.repository);

  Future<Either<Failure, CreateQrResponseModel>> createQrAmount({required String amount}) {
    return repository.createQrAmount(amount: amount);
  }

  Future<Either<Failure, String>> checkQrStatus({required String txnId}) {
    return repository.checkQrStatus(txnId: txnId);
  }

  Future<Either<Failure, WalletQrHistory>> getWalletHistory() {
    return repository.getWalletHistory();
  }
}
