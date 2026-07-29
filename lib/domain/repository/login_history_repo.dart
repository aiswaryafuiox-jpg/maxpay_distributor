import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/login_history_model.dart';

abstract class LoginHistoryRepository {
  Future<Either<Failure, LoginHistoryModel>> getLoginHistory({
    required String fromDate,
    required String toDate,
    String search = "",
  });
}
