import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/update_auto_transfer_model.dart';

abstract class UpdateAutoTransferRepository {
  Future<Either<Failure, UpdateAutoTransferModel>> updateAutoTransfer(UpdateAutoTransferParams params);
}

class UpdateAutoTransferParams {
  final String id;
  final String lowWallet;
  final String transferAmount;
  final String autoTransfer;

  UpdateAutoTransferParams({
    required this.id,
    required this.lowWallet,
    required this.transferAmount,
    required this.autoTransfer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'low_wallet': lowWallet,
      'transfer_amount': transferAmount,
      'auto_transfer': autoTransfer,
    };
  }
}
