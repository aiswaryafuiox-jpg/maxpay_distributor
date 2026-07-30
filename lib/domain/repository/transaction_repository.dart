import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/transaction/transaction_detail_response_model.dart';
import 'package:maxpay/data/model/transaction/transaction_product_response_model.dart';

import 'package:maxpay/data/model/transaction/transaction_report_response_model.dart';
import '../../../core/error/failure.dart';



abstract class TransactionsListRepository {
  Future<Either<Failure, TransactionProductResponseModel>>
  getTransactionProducts();
  Future<Either<Failure, TransactionReportResponseModel>> getTransactionReport(
    Map<String, dynamic> body,
  );
  Future<Either<Failure, TransactionDetailResponseModel>> getTransactionDetail(
    int id,
  );
  Future<Either<Failure, String>> submitTransactionDispute(
    String id,
    String subject,
    String description,
  );
}
