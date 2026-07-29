import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/wallet_credit_list_model.dart';
import 'package:maxpay/domain/repository/wallet_credit_list_repo.dart';

class GetWalletCreditListUseCase {
  final WalletCreditListRepository repository;

  GetWalletCreditListUseCase(this.repository);

  Future<Either<Failure, WalletCreditListModel>> call(
    String type,
    String fromDate,
    String toDate,
    String search,
  ) async {
    return await repository.getWalletCreditList(type, fromDate, toDate, search);
  }
}
