import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/graph_model.dart';
import 'package:maxpay/domain/repository/graph_repo.dart';

class GetGraphUseCase {
  final GraphRepository repository;

  GetGraphUseCase(this.repository);

  Future<Either<Failure, GraphModel>> call(String type) {
    return repository.getGraph(type);
  }
}
