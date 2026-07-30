import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/home_card_model.dart';

abstract class HomeCardRepository {
  Future<Either<Failure, HomeCardModel>> getHomeCardData();
}
