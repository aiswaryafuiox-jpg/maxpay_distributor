import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/cashback/cash_back_model.dart';
import 'package:maxpay/domain/repository/cash_back_repo.dart';

class GetCashBackListUseCase {
  final CashBackRepository repository;

  GetCashBackListUseCase(this.repository);

  Future<Either<Failure, CashBackModel>> call(String productTypeId) {
    return repository.getCashBackList(productTypeId);
  }
}
