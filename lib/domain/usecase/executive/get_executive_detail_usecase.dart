import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/executive/executive_detail_response_model.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';
import '../../../core/error/failure.dart';

class GetExecutiveDetailUseCase {
  final ExecutiveRepository repository;

  GetExecutiveDetailUseCase(this.repository);

  Future<Either<Failure, ExecutiveDetailResponseModel>> call(String id) {
    return repository.getExecutiveDetail(id);
  }
}
