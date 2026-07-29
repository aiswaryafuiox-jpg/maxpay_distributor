import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/daybook/day_book_list_model.dart';
import 'package:maxpay/domain/repository/day_book_repo.dart';

class GetDayBookListUseCase {
  final DayBookRepository repository;

  GetDayBookListUseCase(this.repository);

  Future<Either<Failure, DayBookListModel>> call(String fromDate, String toDate, String productId, String search) {
    return repository.getDayBookList(fromDate, toDate, productId, search);
  }
}
