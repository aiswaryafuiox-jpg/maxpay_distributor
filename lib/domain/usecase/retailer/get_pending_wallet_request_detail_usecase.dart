import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/pending_wallet_request_detail_model.dart';
import 'package:maxpay/domain/repository/pending_wallet_request_repo.dart';


class GetPendingWalletRequestDetailUseCase {
  final PendingWalletRequestRepository repository;

  GetPendingWalletRequestDetailUseCase(this.repository);

  Future<Either<Failure, PendingWalletRequestDetailModel>> call(int id) async {
    return await repository.getPendingWalletRequestDetail(id);
  }
}
