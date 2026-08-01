import 'package:dartz/dartz.dart';
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
