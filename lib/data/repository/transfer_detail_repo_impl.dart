import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/data/model/transfer_detail_model.dart';
import 'package:maxpay/data/model/transfer_detail_list_model.dart';
import 'package:maxpay/domain/repository/transfer_detail_repository.dart';

class TransferDetailRepositoryImpl implements TransferDetailRepository {
  final ApiService apiService;

  TransferDetailRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, TransferDetailModel>> getTransferDetails() async {
    try {
      final response = await apiService.get(
        ApiRoutes.distributorTransferTypes,
      );

      print("API Response => $response");

      final model = TransferDetailModel.fromJson(response);

      print("Success => ${model.success}");
      print("Data Length => ${model.data?.length}");
      print("Data => ${model.data}");

      return Right(model);
    } catch (e) {
      print(e);
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransferDetailListModel>> getTransferDetailList(String type, String fromDate, String toDate, String search) async {
    try {
      final formData = dio.FormData.fromMap({
        'type': type,
        'from_date': fromDate,
        'to_date': toDate,
        'search': search,
      });

      final response = await apiService.post(
        ApiRoutes.distributorTransferDetail,
        data: formData,
      );

      final model = TransferDetailListModel.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}