import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/popup_message_mode.dart';
import 'package:maxpay/domain/repository/popup_message_repo.dart';

class PopupMessageRepoImpl implements PopupMessageRepository {
  final ApiService _apiService;

  PopupMessageRepoImpl(this._apiService);

  @override
  Future<Either<Failure, PopupMessage>> getPopupMessage() async {
    try {
      final response = await _apiService.get(ApiRoutes.getPopupMessage);
      final model = PopupMessage.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
