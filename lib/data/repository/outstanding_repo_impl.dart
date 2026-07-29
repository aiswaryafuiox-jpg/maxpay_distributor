import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/constants/api_routes.dart';
import '../../core/error/failure.dart';
import '../../core/services/api_service.dart';
import '../../data/model/outstanding_list_model.dart';
import '../../data/model/update_outstanding_model.dart';
import '../../domain/repository/outstanding_repo.dart';

class OutstandingRepoImpl implements OutstandingRepository {
  final ApiService _apiService;

  OutstandingRepoImpl(this._apiService);

  @override
  Future<Either<Failure, OutstandingListModel>> getOutstandingList() async {
    try {
      final response = await _apiService.get(ApiRoutes.distributorOutstandingList);
      final model = OutstandingListModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
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
  Future<Either<Failure, UpdateOutstandingModel>> updateOutstanding(int retailerId, String receivedAmount) async {
    try {
      final formData = FormData.fromMap({
        "retailer_id": retailerId,
        "received_amount": receivedAmount,
      });
      final response = await _apiService.post(
        ApiRoutes.distributorUpdateOutstanding,
        data: formData,
      );
      final model = UpdateOutstandingModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(ServerFailure(model.message ?? 'Server error: ${model.code}'));
      }
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
