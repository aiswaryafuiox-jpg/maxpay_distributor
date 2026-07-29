import 'package:dartz/dartz.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';
import '../../../core/error/failure.dart';


class AddExecutiveWalletUseCase {
  final ExecutiveRepository repository;

  AddExecutiveWalletUseCase(this.repository);

  Future<Either<Failure, String>> call(String id, String amount) {
    return repository.addExecutiveWallet(id, amount);
  }
}
