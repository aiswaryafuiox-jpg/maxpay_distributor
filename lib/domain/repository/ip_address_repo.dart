import 'package:dartz/dartz.dart';
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
