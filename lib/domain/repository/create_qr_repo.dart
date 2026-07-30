import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/create_qr_response_model.dart';
import 'package:maxpay/data/model/wallet_qr_history_model.dart';

abstract class CreateQrRepository {
  Future<Either<Failure, CreateQrResponseModel>> createQrAmount({required String amount});
  Future<Either<Failure, String>> checkQrStatus({required String txnId});
  Future<Either<Failure, WalletQrHistory>> getWalletHistory();
}
