import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/statement/statement_descriptions_model.dart';
import 'package:maxpay/data/model/statement/statement_detail_model.dart';
import 'package:maxpay/data/model/statement/statement_list_model.dart';
import 'package:maxpay/domain/repository/statement_repo.dart';

class StatementRepositoryImpl implements StatementRepository {
  final ApiService _apiService;

  StatementRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, StatementDescriptionsModel>>
  getStatementDescriptions() async {
    try {
      final response = await _apiService.get(
        ApiRoutes.distributorStatementDescriptions,
      );
      final model = StatementDescriptionsModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(
            model.message ?? "Failed to fetch statement descriptions",
          ),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, StatementListModel>> getStatementList(
    StatementListParams params,
  ) async {
    try {
      final formData = FormData.fromMap(params.toJson());
      final response = await _apiService.post(
        ApiRoutes.distributorStatement,
        data: formData,
      );
      final model = StatementListModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch statement list"),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, StatementDetailModel>> getStatementDetail(
    String id,
  ) async {
    try {
      final formData = FormData.fromMap({"id": id});
      final response = await _apiService.post(
        ApiRoutes.distributorStatementDetail,
        data: formData,
      );
      final model = StatementDetailModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch statement detail"),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
