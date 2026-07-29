import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/home_card_model.dart';
import 'package:maxpay/domain/repository/home_card_repo.dart';

class GetHomeCardUseCase {
  final HomeCardRepository repository;

  GetHomeCardUseCase(this.repository);

  Future<Either<Failure, HomeCardModel>> call() async {
    return await repository.getHomeCardData();
  }
}
