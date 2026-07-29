import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/pending_wallet_request_model.dart';
import 'package:maxpay/domain/repository/pending_wallet_request_repo.dart';


class GetPendingWalletRequestsUseCase {
  final PendingWalletRequestRepository repository;

  GetPendingWalletRequestsUseCase(this.repository);

  Future<Either<Failure, PendingWalletRequestModel>> call() async {
    return await repository.getPendingWalletRequests();
  }
}
