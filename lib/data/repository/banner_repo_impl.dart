import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/banner_model.dart';
import 'package:maxpay/domain/repository/banner_repo.dart';
import 'package:maxpay/data/model/ad_model.dart';

class BannerRepositoryImpl implements BannerRepository {
  final ApiService _apiService;

  BannerRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, BannerModel>> getBanners() async {
    try {
      final response = await _apiService.get(ApiRoutes.getBanners);
      final model = BannerModel.fromJson(response);
      if (model.code == 200 || model.code == 201) {
        if (model.success == true) {
          return Right(model);
        } else {
          return Left(ServerFailure(model.message ?? 'Unknown server error'));
        }
      } else {
        return Left(
          ServerFailure(model.message ?? 'Server error: ${model.code}'),
        );
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Advertisement>> getAdvertisements() async {
    try {
      final response = await _apiService.get(ApiRoutes.getAdvertisement);
      final model = Advertisement.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
