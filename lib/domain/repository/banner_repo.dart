import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/banner_model.dart';

import 'package:maxpay/data/model/ad_model.dart';

abstract class BannerRepository {
  Future<Either<Failure, BannerModel>> getBanners();
  Future<Either<Failure, Advertisement>> getAdvertisements();
}
