import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/partner/partner_list_response_model.dart';
import 'package:maxpay/domain/repository/partner_repository.dart';

class GetMappedDistUseCase {
  final PartnerRepository repository;

  GetMappedDistUseCase(this.repository);

  Future<Either<Failure, MappedDistResponseModel>> call() async {
    return await repository.getMappedDist();
  }
}
