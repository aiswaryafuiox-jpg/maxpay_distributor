import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/faq_reply_model.dart';

abstract class FaqReplyRepository {
  Future<Either<Failure, FaqReply>> faqReply({
    required String comment,
    required String faqid,
    required String reply,
  });
}
