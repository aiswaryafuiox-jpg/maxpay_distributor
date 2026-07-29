import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/statement/statement_detail_model.dart';
import 'package:maxpay/domain/repository/statement_repo.dart';

class GetStatementDetailUseCase {
  final StatementRepository repository;

  GetStatementDetailUseCase(this.repository);

  Future<Either<Failure, StatementDetailModel>> call(String id) async {
    return await repository.getStatementDetail(id);
  }
}
