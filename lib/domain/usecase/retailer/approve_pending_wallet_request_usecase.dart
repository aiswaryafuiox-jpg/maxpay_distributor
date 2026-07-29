import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/approve_wallet_request_model.dart';
import 'package:maxpay/domain/repository/pending_wallet_request_repo.dart';

class ApprovePendingWalletRequestUseCase {
  final PendingWalletRequestRepository repository;

  ApprovePendingWalletRequestUseCase(this.repository);

  Future<Either<Failure, ApproveWalletRequestModel>> call(int id, String confirmAmount) async {
    return await repository.approvePendingWalletRequest(id, confirmAmount);
  }
}
