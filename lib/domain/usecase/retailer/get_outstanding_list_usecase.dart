import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/outstanding_list_model.dart';
import 'package:maxpay/domain/repository/outstanding_repo.dart';

class GetOutstandingListUseCase {
  final OutstandingRepository repository;

  GetOutstandingListUseCase(this.repository);

  Future<Either<Failure, OutstandingListModel>> call() async {
    return await repository.getOutstandingList();
  }
}
