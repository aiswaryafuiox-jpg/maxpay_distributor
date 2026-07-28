import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/update_auto_transfer_model.dart';
import 'package:maxpay/domain/repository/update_auto_transfer_repo.dart';

class UpdateAutoTransferUseCase {
  final UpdateAutoTransferRepository repository;

  UpdateAutoTransferUseCase(this.repository);

  Future<Either<Failure, UpdateAutoTransferModel>> call(UpdateAutoTransferParams params) {
    return repository.updateAutoTransfer(params);
  }
}
