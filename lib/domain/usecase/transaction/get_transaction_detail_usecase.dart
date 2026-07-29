import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repository/transaction_repository.dart';
import '../../../data/model/transaction/transaction_detail_response_model.dart';

class GetTransactionDetailUseCase {
  final TransactionRepository repository;

  GetTransactionDetailUseCase(this.repository);

  Future<Either<Failure, TransactionDetailResponseModel>> call(int id) {
    return repository.getTransactionDetail(id);
  }
}
