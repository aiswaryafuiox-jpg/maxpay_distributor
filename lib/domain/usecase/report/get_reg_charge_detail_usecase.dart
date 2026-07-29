import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/report/reg_charge_detail_model.dart';
import 'package:maxpay/domain/repository/reg_charge_repo.dart';

class GetRegChargeDetailUseCase {
  final RegChargeRepository repository;

  GetRegChargeDetailUseCase(this.repository);

  Future<Either<Failure, RegChargeDetailModel>> call(RegChargeDetailParams params) async {
    return await repository.getRegChargeDetail(params);
  }
}
