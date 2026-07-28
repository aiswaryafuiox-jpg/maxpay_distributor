import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/constants/api_routes.dart';
import '../../core/error/failure.dart';
import '../../core/services/api_service.dart';
import '../../data/model/wallet_credit_list_model.dart';
import '../../domain/repository/wallet_credit_list_repo.dart';

class WalletCreditListRepoImpl implements WalletCreditListRepository {
  final ApiService _apiService;

  WalletCreditListRepoImpl(this._apiService);

  @override
  Future<Either<Failure, WalletCreditListModel>> getWalletCreditList(
    String type,
    String fromDate,
    String toDate,
    String search,
  ) async {
    try {
      final formData = FormData.fromMap({
        'type': type,
        'from_date': fromDate,
        'to_date': toDate,
        'search': search,
      });

      final response = await _apiService.post(
        ApiRoutes.distributorWalletCreditList,
        data: formData,
      );

      final model = WalletCreditListModel.fromJson(response);
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
