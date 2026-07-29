import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/auto_transfer_details_model.dart';
import 'package:maxpay/domain/repository/auto_transfer_details_repo.dart';

class GetAutoTransferDetailsUseCase {
  final AutoTransferDetailsRepository repository;

  GetAutoTransferDetailsUseCase(this.repository);

  Future<Either<Failure, AutoTransferDetailsModel>> call(String id) {
    return repository.getAutoTransferDetails(id);
  }
}
