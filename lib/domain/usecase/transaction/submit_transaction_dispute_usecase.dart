import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/domain/repository/transaction_repository.dart';

class SubmitTransactionDisputeUseCase {
  final TransactionsListRepository repository;

  SubmitTransactionDisputeUseCase(this.repository);

  Future<Either<Failure, String>> call(String id, String subject, String description) {
    return repository.submitTransactionDispute(id, subject, description);
  }
}
