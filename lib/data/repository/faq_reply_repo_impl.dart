import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/error/error_handler.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/model/faq_reply_model.dart';
import 'package:maxpay/domain/repository/faq_reply_repo.dart';

class FaqReplyRepoImpl implements FaqReplyRepository {
  final ApiService _apiService;

  FaqReplyRepoImpl(this._apiService);

  @override
  Future<Either<Failure, FaqReply>> faqReply({
    required String comment,
    required String faqid,
    required String reply,
  }) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.getFaqReply,
        data: {
          'comment_box': comment,
          'faq_id': faqid,
          'reply': reply,
        },
      );
      final model = FaqReply.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
