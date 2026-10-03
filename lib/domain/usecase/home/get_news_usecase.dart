import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/news_model.dart';
import 'package:maxpay/domain/repository/news_repo.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<Either<Failure, NewsModel>> call() {
    return repository.getNews();
  }
}
