import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/grade_model.dart';
import 'package:maxpay/domain/repository/grade_repo.dart';

class GetGradeUseCase {
  final GradeRepository repository;

  GetGradeUseCase(this.repository);

  Future<Either<Failure, GradeModel>> call() {
    return repository.getGrade();
  }
}
