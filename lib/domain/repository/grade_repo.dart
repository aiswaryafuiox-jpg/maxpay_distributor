import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/grade_model.dart';

abstract class GradeRepository {
  Future<Either<Failure, GradeModel>> getGrade();
}
