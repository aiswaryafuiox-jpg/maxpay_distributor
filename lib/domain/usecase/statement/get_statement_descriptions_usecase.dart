import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/statement/statement_descriptions_model.dart';
import 'package:maxpay/domain/repository/statement_repo.dart';

class GetStatementDescriptionsUseCase {
  final StatementRepository repository;

  GetStatementDescriptionsUseCase(this.repository);

  Future<Either<Failure, StatementDescriptionsModel>> call() async {
    return await repository.getStatementDescriptions();
  }
}
