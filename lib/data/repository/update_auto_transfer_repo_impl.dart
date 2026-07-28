import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/update_auto_transfer_model.dart';
import 'package:maxpay/domain/repository/update_auto_transfer_repo.dart';

class UpdateAutoTransferRepoImpl implements UpdateAutoTransferRepository {
  final ApiService _apiService;

  UpdateAutoTransferRepoImpl(this._apiService);

  @override
  Future<Either<Failure, UpdateAutoTransferModel>> updateAutoTransfer(UpdateAutoTransferParams params) async {
    try {
      final formData = FormData.fromMap(params.toJson());

      final response = await _apiService.post(
        ApiRoutes.distributorUpdateAutoTransfer,
        data: formData,
      );

      final model = UpdateAutoTransferModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? "Failed to update auto transfer."));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
