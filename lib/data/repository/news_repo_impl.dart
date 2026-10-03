import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/news_model.dart';
import 'package:maxpay/domain/repository/news_repo.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiService _apiService;

  NewsRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, NewsModel>> getNews() async {
    try {
      final response = await _apiService.get(ApiRoutes.getNews);
      final model = NewsModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
