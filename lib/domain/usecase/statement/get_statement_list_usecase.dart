import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/statement/statement_list_model.dart';
import 'package:maxpay/domain/repository/statement_repo.dart';

class GetStatementListUseCase {
  final StatementRepository repository;

  GetStatementListUseCase(this.repository);

  Future<Either<Failure, StatementListModel>> call(StatementListParams params) async {
    return await repository.getStatementList(params);
  }
}
