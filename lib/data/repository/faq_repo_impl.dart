import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/faq_model.dart';
import 'package:maxpay/domain/repository/faq_repo.dart';

class FaqRepoImpl implements FaqRepository {
  final ApiService _apiService;

  FaqRepoImpl(this._apiService);

  @override
  Future<Either<Failure, Faq>> getFaq() async {
    try {
      final response = await _apiService.get(ApiRoutes.getFaq);
      final model = Faq.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
