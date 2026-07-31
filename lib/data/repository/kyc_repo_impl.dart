import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/kyc_model.dart';
import 'package:maxpay/domain/repository/kyc_repo.dart';

class KycRepoImpl implements KycRepository {
  final ApiService _apiService;

  KycRepoImpl(this._apiService);

  @override
  Future<Either<Failure, KycModel>> getKyc() async {
    try {
      final response = await _apiService.get(ApiRoutes.distributorGetKyc);
      final model = KycModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(
          ServerFailure(model.message ?? "Failed to fetch KYC details."),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, KycModel>> submitKyc({
    required String email,
    required String whatsappNumber,
    String? cancelledCheckPath,
    String? gstNoPath,
    String? panPath,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {
        'email': email,
        'whatsapp_number': whatsappNumber,
      };

      if (cancelledCheckPath != null) {
        formDataMap['cancelled_check'] = await MultipartFile.fromFile(
          cancelledCheckPath,
        );
      }
      if (gstNoPath != null) {
        formDataMap['gst_no'] = await MultipartFile.fromFile(gstNoPath);
      }
      if (panPath != null) {
        formDataMap['pan'] = await MultipartFile.fromFile(panPath);
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await _apiService.post(
        ApiRoutes.distributorSubmitKyc,
        data: formData,
      );

      final model = KycModel.fromJson(response);

      if (model.success == true) {
        return Right(model);
      } else {
        return Left(ServerFailure(model.message ?? "Failed to submit KYC."));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
