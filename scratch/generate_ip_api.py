import os

files = {
    "lib/data/model/ip_address_model.dart": """class IpAddressModel {
  bool? success;
  String? message;

  IpAddressModel({this.success, this.message});

  IpAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
""",
    "lib/domain/repository/ip_address_repo.dart": """import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/ip_address_model.dart';

abstract class IpAddressRepository {
  Future<Either<Failure, IpAddressModel>> saveIpAddress({
    required String ipAddress,
    required String city,
    required String state,
    required String country,
  });
}
""",
    "lib/data/repository/ip_address_repo_impl.dart": """import 'package:dartz/dartz.dart';
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
""",
    "lib/domain/usecase/ip_address_usecase.dart": """import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/ip_address_model.dart';
import 'package:maxpay/domain/repository/ip_address_repo.dart';

class IpAddressUseCase {
  final IpAddressRepository repository;

  IpAddressUseCase(this.repository);

  Future<Either<Failure, IpAddressModel>> call({
    required String ipAddress,
    required String city,
    required String state,
    required String country,
  }) {
    return repository.saveIpAddress(
      ipAddress: ipAddress,
      city: city,
      state: state,
      country: country,
    );
  }
}
""",
    "lib/controller/ip_address_controller.dart": """import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/domain/usecase/ip_address_usecase.dart';

class IpAddressController extends GetxController {
  final IpAddressUseCase ipAddressUseCase;

  IpAddressController({required this.ipAddressUseCase});

  Future<void> saveIpAddress() async {
    try {
      final dio = Dio();
      final response = await dio.get('http://ip-api.com/json/');
      
      if (response.statusCode == 200) {
        final data = response.data;
        
        final String ip = data['query'] ?? 'Unknown';
        final String city = data['city'] ?? 'Unknown';
        final String state = data['regionName'] ?? 'Unknown';
        final String country = data['country'] ?? 'Unknown';

        final result = await ipAddressUseCase(
          ipAddress: ip,
          city: city,
          state: state,
          country: country,
        );

        result.fold(
          (failure) => AppLogger.logError("Failed to save IP: ${failure.message}"),
          (success) => AppLogger.debugPrint("IP saved successfully: ${success.message}"),
        );
      }
    } catch (e) {
      AppLogger.logError("Error fetching IP details: $e");
    }
  }
}
"""
}

for filepath, content in files.items():
    with open(filepath, 'w') as f:
        f.write(content)

print("Files created successfully.")
