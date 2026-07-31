import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/cashback/cash_back_product_types_model.dart';
import 'package:maxpay/data/model/cashback/cash_back_model.dart';
import 'package:maxpay/domain/repository/cash_back_repo.dart';

class CashBackRepoImpl implements CashBackRepository {
  final ApiService _apiService;

  CashBackRepoImpl(this._apiService);

  @override
  Future<Either<Failure, CashBackProductTypesModel>>
  getCashBackProductTypes() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorCashBackProductTypes,
      );
      final model = CashBackProductTypesModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(
            model.message ?? "Failed to fetch cashback product types.",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, CashBackModel>> getCashBackList(
    String productTypeId,
  ) async {
    try {
      final formData = FormData.fromMap({'product_type_id': productTypeId});

      final response = await _apiService.post(
        ApiRoutes.distributorCashBack,
        data: formData,
      );
      final model = CashBackModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch cashback list."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
