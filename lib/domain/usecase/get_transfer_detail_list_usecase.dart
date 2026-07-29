import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/transfer_detail_list_model.dart';
import 'package:maxpay/domain/repository/transfer_detail_repository.dart';

class GetTransferDetailListUseCase {
  final TransferDetailRepository repository;

  GetTransferDetailListUseCase(this.repository);

  Future<Either<Failure, TransferDetailListModel>> call(String type, String fromDate, String toDate, String search) {
    return repository.getTransferDetailList(type, fromDate, toDate, search);
  }
}
