import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/transfer_detail_model.dart';
import 'package:maxpay/data/model/transfer_detail_list_model.dart';

import 'package:maxpay/data/model/reverse_wallet_transfer_model.dart';

abstract class TransferDetailRepository {
  Future<Either<Failure, TransferDetailModel>> getTransferDetails();
  Future<Either<Failure, TransferDetailListModel>> getTransferDetailList(String type, String fromDate, String toDate, String search);
  Future<Either<Failure, ReverseWalletTransferModel>> reverseWalletTransfer(String id);
}