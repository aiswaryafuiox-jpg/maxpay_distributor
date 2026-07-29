import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../data/model/pending_wallet_request_model.dart';
import '../../data/model/pending_wallet_request_detail_model.dart';
import '../../data/model/approve_wallet_request_model.dart';

abstract class PendingWalletRequestRepository {
  Future<Either<Failure, PendingWalletRequestModel>> getPendingWalletRequests();
  Future<Either<Failure, PendingWalletRequestDetailModel>> getPendingWalletRequestDetail(int id);
  Future<Either<Failure, ApproveWalletRequestModel>> approvePendingWalletRequest(int id, String confirmAmount);
}
