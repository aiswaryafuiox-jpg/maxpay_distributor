import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/daybook/day_book_products_model.dart';
import 'package:maxpay/domain/repository/day_book_repo.dart';

class GetDayBookProductsUseCase {
  final DayBookRepository repository;

  GetDayBookProductsUseCase(this.repository);

  Future<Either<Failure, DayBookProductsModel>> call() {
    return repository.getDayBookProducts();
  }
}
