import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/reverse_wallet_transfer_model.dart';
import 'package:maxpay/domain/repository/transfer_detail_repository.dart';

class ReverseWalletTransferUseCase {
  final TransferDetailRepository repository;

  ReverseWalletTransferUseCase(this.repository);

  Future<Either<Failure, ReverseWalletTransferModel>> call(String id) async {
    return await repository.reverseWalletTransfer(id);
  }
}
