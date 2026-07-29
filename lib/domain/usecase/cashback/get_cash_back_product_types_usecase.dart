import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/cashback/cash_back_product_types_model.dart';
import 'package:maxpay/domain/repository/cash_back_repo.dart';

class GetCashBackProductTypesUseCase {
  final CashBackRepository repository;

  GetCashBackProductTypesUseCase(this.repository);

  Future<Either<Failure, CashBackProductTypesModel>> call() {
    return repository.getCashBackProductTypes();
  }
}
