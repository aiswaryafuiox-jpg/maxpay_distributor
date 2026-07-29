import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/transaction/transaction_detail_response_model.dart';
import 'package:maxpay/data/model/transaction/transaction_product_response_model.dart';
import 'package:maxpay/data/model/transaction/transaction_report_model.dart';
import 'package:maxpay/data/model/transaction/transaction_report_response_model.dart';
import '../../../core/error/failure.dart';

abstract class TransactionRepository {
  Future<Either<Failure, TransactionReportModel>> getTransactionSuccessReport(String productId, String fromDate, String toDate, String search);
}

abstract class TransactionsListRepository {
  Future<Either<Failure, TransactionProductResponseModel>>
  getTransactionProducts();
  Future<Either<Failure, TransactionReportResponseModel>> getTransactionReport(
    Map<String, dynamic> body,
  );
  Future<Either<Failure, TransactionDetailResponseModel>> getTransactionDetail(
    int id,
  );
}
