import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/bank_details_model.dart';
import 'package:maxpay/domain/repository/bank_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class BankDetailUsecase {
  final BankDetailRepository repository;
  BankDetailUsecase(this.repository);
  Future<Either<Failure, BankDetails>> call() {
    return repository.bankdetail();
  }
}
