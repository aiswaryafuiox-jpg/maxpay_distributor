import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/services/api_service.dart';
import '../../../core/constants/api_routes.dart';
import '../../../core/error/failure.dart';
import '../../domain/repository/transaction_repository.dart';
import '../model/transaction/transaction_product_response_model.dart';
import '../model/transaction/transaction_report_response_model.dart';
import '../model/transaction/transaction_detail_response_model.dart';

class TransactionRepositoryImpl implements TransactionsListRepository {
  final ApiService _apiService;

  TransactionRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, TransactionProductResponseModel>>
  getTransactionProducts() async {
    try {
      final response = await _apiService.get(ApiRoutes.transactionProducts);
      return Right(TransactionProductResponseModel.fromJson(response));
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, TransactionReportResponseModel>> getTransactionReport(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.transactionReport,
        data: body,
      );
      return Right(TransactionReportResponseModel.fromJson(response));
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, TransactionDetailResponseModel>> getTransactionDetail(
    int id,
  ) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.transactionDetail,
        data: {'id': id.toString()},
      );
      return Right(TransactionDetailResponseModel.fromJson(response));
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> submitTransactionDispute(
    String id,
    String subject,
    String description,
  ) async {
    try {
      final formData = FormData.fromMap({
        'id': id,
        'subject': subject,
        'description': description,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorSubmitTransactionDispute,
        data: formData,
      );

      if (response['code'] == 200) {
        return Right(
          response['message']?.toString() ?? 'Dispute submitted successfully',
        );
      } else {
        return Left(
          ServerFailure(response['message'] ?? 'Failed to submit dispute'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
