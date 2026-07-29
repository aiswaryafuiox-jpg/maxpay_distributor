import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/update_outstanding_model.dart';
import 'package:maxpay/domain/repository/outstanding_repo.dart';

class UpdateOutstandingUseCase {
  final OutstandingRepository repository;

  UpdateOutstandingUseCase(this.repository);

  Future<Either<Failure, UpdateOutstandingModel>> call(int retailerId, String receivedAmount) async {
    return await repository.updateOutstanding(retailerId, receivedAmount);
  }
}
