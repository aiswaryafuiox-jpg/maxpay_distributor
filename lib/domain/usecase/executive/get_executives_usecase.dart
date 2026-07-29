import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/executive/executive_list_response_model.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';
import '../../../core/error/failure.dart';

class GetExecutivesUseCase {
  final ExecutiveRepository repository;

  GetExecutivesUseCase(this.repository);

  Future<Either<Failure, ExecutiveListResponseModel>> call() {
    return repository.getExecutives();
  }
}
