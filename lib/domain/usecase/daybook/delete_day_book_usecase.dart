import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/daybook/day_book_delete_model.dart';
import 'package:maxpay/domain/repository/day_book_repo.dart';

class DeleteDayBookUseCase {
  final DayBookRepository repository;

  DeleteDayBookUseCase(this.repository);

  Future<Either<Failure, DayBookDeleteModel>> call(String id) {
    return repository.deleteDayBook(id);
  }
}
