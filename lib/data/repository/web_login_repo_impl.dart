import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/domain/repository/web_login_repo.dart';

class WebLoginRepositoryImpl implements WebLoginRepository {
  final ApiService apiService;

  WebLoginRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, String>> webLogin(String qrUserId) async {
    try {
      final formData = FormData.fromMap({
        'qr_user_id': qrUserId,
      });

      final response = await apiService.post(
        ApiRoutes.distributorWebLogin,
        data: formData,
      );

      if (response['code'] == 200 || response['status'] == true) {
        return Right(response['message']?.toString() ?? 'Web login successful');
      } else {
        return Left(ServerFailure(response['message'] ?? 'Failed to web login'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return Left(ServerFailure(e.response!.data['message'] ?? 'Server error'));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> webLogout(String isWebLogin) async {
    try {
      final formData = FormData.fromMap({
        'is_web_login': isWebLogin,
      });

      final response = await apiService.post(
        ApiRoutes.distributorWebLogout,
        data: formData,
      );

      if (response['code'] == 200 || response['status'] == true) {
        return Right(response['message']?.toString() ?? 'Web logout successful');
      } else {
        return Left(ServerFailure(response['message'] ?? 'Failed to web logout'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return Left(ServerFailure(e.response!.data['message'] ?? 'Server error'));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
