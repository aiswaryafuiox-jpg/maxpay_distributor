import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/graph_model.dart';

abstract class GraphRepository {
  Future<Either<Failure, GraphModel>> getGraph(String type);
}
