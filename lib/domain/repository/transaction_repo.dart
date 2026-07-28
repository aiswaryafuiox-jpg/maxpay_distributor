import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/transaction/transaction_report_model.dart';

abstract class TransactionRepository {
  Future<Either<Failure, TransactionReportModel>> getTransactionSuccessReport(String productId, String fromDate, String toDate, String search);
}
