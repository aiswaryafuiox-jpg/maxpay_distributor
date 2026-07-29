import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/transaction/transaction_report_model.dart';
import 'package:maxpay/domain/repository/transaction_repository.dart';


class TransactionRepoImpl implements TransactionRepository {
  final ApiService _apiService;

  TransactionRepoImpl(this._apiService);

  @override
  Future<Either<Failure, TransactionReportModel>> getTransactionSuccessReport(
      String productId, String fromDate, String toDate, String search) async {
    try {
      final formData = FormData.fromMap({
        'product_id': productId,
        'from_date': fromDate,
        'to_date': toDate,
        'search': search,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorTransactionSuccessReport,
        data: formData,
      );

      final model = TransactionReportModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? "Failed to fetch transaction success report."));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
