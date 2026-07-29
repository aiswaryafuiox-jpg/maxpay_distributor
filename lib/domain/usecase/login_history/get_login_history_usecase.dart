import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/login_history_model.dart';
import 'package:maxpay/domain/repository/login_history_repo.dart';

class GetLoginHistoryUseCase {
  final LoginHistoryRepository repository;

  GetLoginHistoryUseCase(this.repository);

  Future<Either<Failure, LoginHistoryModel>> call({
    required String fromDate,
    required String toDate,
    String search = "",
  }) {
    return repository.getLoginHistory(
      fromDate: fromDate,
      toDate: toDate,
      search: search,
    );
  }
}
