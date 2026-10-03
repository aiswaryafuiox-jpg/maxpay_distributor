import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/home_card_model.dart';
import 'package:maxpay/domain/repository/home_card_repo.dart';

class HomeCardRepositoryImpl implements HomeCardRepository {
  final ApiService _apiService;

  HomeCardRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, HomeCardModel>> getHomeCardData() async {
    try {
      final response = await _apiService.get(ApiRoutes.distributorHomeCard);

      debugPrint("Home Card API Response: $response");

      final model = HomeCardModel.fromJson(response);
      return Right(model);
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
