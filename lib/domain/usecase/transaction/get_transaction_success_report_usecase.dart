import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/transaction/transaction_report_model.dart';
import 'package:maxpay/domain/repository/transaction_repo.dart';

class GetTransactionSuccessReportUseCase {
  final TransactionRepository repository;

  GetTransactionSuccessReportUseCase(this.repository);

  Future<Either<Failure, TransactionReportModel>> call(String productId, String fromDate, String toDate, String search) {
    return repository.getTransactionSuccessReport(productId, fromDate, toDate, search);
  }
}
