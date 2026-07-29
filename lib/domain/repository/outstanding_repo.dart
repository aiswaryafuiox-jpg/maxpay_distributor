import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../data/model/outstanding_list_model.dart';
import '../../data/model/update_outstanding_model.dart';

abstract class OutstandingRepository {
  Future<Either<Failure, OutstandingListModel>> getOutstandingList();
  Future<Either<Failure, UpdateOutstandingModel>> updateOutstanding(int retailerId, String receivedAmount);
}
