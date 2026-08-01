import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/news_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, NewsModel>> getNews();
}
