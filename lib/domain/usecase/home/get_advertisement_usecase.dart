import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/ad_model.dart';
import 'package:maxpay/domain/repository/banner_repo.dart';

class AdvertisementUsecase {
  final BannerRepository repository;

  AdvertisementUsecase(this.repository);

  Future<Either<Failure, Advertisement>> call() {
    return repository.getAdvertisements();
  }
}
