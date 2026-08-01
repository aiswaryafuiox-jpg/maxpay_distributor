import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/ip_address_model.dart';
import 'package:maxpay/domain/repository/ip_address_repo.dart';

class IpAddressRepositoryImpl implements IpAddressRepository {
  final ApiService _apiService;

  IpAddressRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, IpAddressModel>> saveIpAddress({
    required String ipAddress,
    required String city,
    required String state,
    required String country,
  }) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.distributorGetIp,
        data: {
          'ip_address': ipAddress,
          'city': city,
          'state': state,
          'country': country,
        },
      );
      return Right(IpAddressModel.fromJson(response));
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
