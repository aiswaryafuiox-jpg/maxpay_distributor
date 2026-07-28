import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repository/transaction_repository.dart';
import '../../../data/model/transaction/transaction_report_response_model.dart';

class GetTransactionReportUseCase {
  final TransactionRepository repository;

  GetTransactionReportUseCase(this.repository);

  Future<Either<Failure, TransactionReportResponseModel>> call(Map<String, dynamic> body) {
    return repository.getTransactionReport(body);
  }
}
