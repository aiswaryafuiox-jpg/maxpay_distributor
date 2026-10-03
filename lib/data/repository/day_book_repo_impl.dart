import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/daybook/day_book_products_model.dart';
import 'package:maxpay/data/model/daybook/day_book_list_model.dart';
import 'package:maxpay/data/model/daybook/day_book_delete_model.dart';
import 'package:maxpay/domain/repository/day_book_repo.dart';

class DayBookRepoImpl implements DayBookRepository {
  final ApiService _apiService;

  DayBookRepoImpl(this._apiService);

  @override
  Future<Either<Failure, DayBookProductsModel>> getDayBookProducts() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorDayBookProducts,
      );

      final model = DayBookProductsModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch day book products."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, DayBookListModel>> getDayBookList(
    String fromDate,
    String toDate,
    String productId,
    String search,
  ) async {
    try {
      final formData = FormData.fromMap({
        'from_date': fromDate,
        'to_date': toDate,
        'product_id': productId,
        'search': search,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorDayBookList,
        data: formData,
      );

      final model = DayBookListModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch day book list."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, DayBookDeleteModel>> deleteDayBook(String id) async {
    try {
      final formData = FormData.fromMap({'id': id});

      final response = await _apiService.post(
        ApiRoutes.distributorDayBookDelete,
        data: formData,
      );

      final model = DayBookDeleteModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to delete day book."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
