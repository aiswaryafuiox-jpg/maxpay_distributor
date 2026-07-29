import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/services/api_service.dart';
import '../../../core/constants/api_routes.dart';
import '../../../core/error/failure.dart';
import '../../domain/repository/transaction_repository.dart';
import '../model/transaction/transaction_product_response_model.dart';
import '../model/transaction/transaction_report_response_model.dart';
import '../model/transaction/transaction_detail_response_model.dart';

class TransactionRepositoryImpl implements TransactionsListRepository  {
  final ApiService _apiService;

  TransactionRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, TransactionProductResponseModel>> getTransactionProducts() async {
    try {
      final response = await _apiService.get(ApiRoutes.transactionProducts);
      return Right(TransactionProductResponseModel.fromJson(response));
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactionReportResponseModel>> getTransactionReport(Map<String, dynamic> body) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.transactionReport,
        data: body,
      );
      return Right(TransactionReportResponseModel.fromJson(response));
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactionDetailResponseModel>> getTransactionDetail(int id) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.transactionDetail,
        data: {'id': id.toString()},
      );
      return Right(TransactionDetailResponseModel.fromJson(response));
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final message = e.response!.data['message'] ?? 'Server error';
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


}
