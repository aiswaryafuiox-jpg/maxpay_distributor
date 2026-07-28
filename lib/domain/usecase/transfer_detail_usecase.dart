import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/transfer_detail_model.dart';
import 'package:maxpay/domain/repository/transfer_detail_repository.dart';

class GetTransferDetailsUseCase {
  final TransferDetailRepository repository;

  GetTransferDetailsUseCase(this.repository);

  Future<Either<Failure, TransferDetailModel>> call() {
    return repository.getTransferDetails();
  }
}