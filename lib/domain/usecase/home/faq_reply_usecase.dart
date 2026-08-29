import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/faq_reply_model.dart';
import 'package:maxpay/domain/repository/faq_reply_repo.dart';

class FaqReplyUseCase {
  final FaqReplyRepository repository;

  FaqReplyUseCase(this.repository);

  Future<Either<Failure, FaqReply>> call({
    required String comment,
    required String faqid,
    required String reply,
  }) async {
    return await repository.faqReply(
      comment: comment,
      faqid: faqid,
      reply: reply,
    );
  }
}
