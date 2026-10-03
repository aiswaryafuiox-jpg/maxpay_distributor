import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/banner_model.dart';
import 'package:maxpay/domain/repository/banner_repo.dart';

class GetBannerUseCase {
  final BannerRepository repository;

  GetBannerUseCase(this.repository);

  Future<Either<Failure, BannerModel>> call() {
    return repository.getBanners();
  }
}
