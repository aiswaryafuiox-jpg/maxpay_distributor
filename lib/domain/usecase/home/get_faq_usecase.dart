import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/faq_model.dart';
import 'package:maxpay/domain/repository/faq_repo.dart';

class GetFaqUseCase {
  final FaqRepository repository;

  GetFaqUseCase(this.repository);

  Future<Either<Failure, Faq>> call() async {
    return await repository.getFaq();
  }
}
