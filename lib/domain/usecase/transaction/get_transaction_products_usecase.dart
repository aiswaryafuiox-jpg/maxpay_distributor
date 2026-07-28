import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repository/transaction_repository.dart';
import '../../../data/model/transaction/transaction_product_response_model.dart';

class GetTransactionProductsUseCase {
  final TransactionRepository repository;

  GetTransactionProductsUseCase(this.repository);

  Future<Either<Failure, TransactionProductResponseModel>> call() {
    return repository.getTransactionProducts();
  }
}
