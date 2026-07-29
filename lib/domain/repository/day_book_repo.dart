import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/daybook/day_book_products_model.dart';
import 'package:maxpay/data/model/daybook/day_book_list_model.dart';
import 'package:maxpay/data/model/daybook/day_book_delete_model.dart';

abstract class DayBookRepository {
  Future<Either<Failure, DayBookProductsModel>> getDayBookProducts();
  Future<Either<Failure, DayBookListModel>> getDayBookList(String fromDate, String toDate, String productId, String search);
  Future<Either<Failure, DayBookDeleteModel>> deleteDayBook(String id);
}
