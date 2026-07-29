import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/grade_model.dart';
import 'package:maxpay/domain/repository/grade_repo.dart';

class GradeRepoImpl implements GradeRepository {
  final ApiService _apiService;

  GradeRepoImpl(this._apiService);

  @override
  Future<Either<Failure, GradeModel>> getGrade() async {
    try {
      final response = await _apiService.get(ApiRoutes.distributorGrade);
      final model = GradeModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? "Failed to fetch grade."));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
