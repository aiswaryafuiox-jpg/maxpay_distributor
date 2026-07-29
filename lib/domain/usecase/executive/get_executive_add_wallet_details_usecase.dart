import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/executive/executive_add_wallet_details_response_model.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';
import '../../../core/error/failure.dart';

class GetExecutiveAddWalletDetailsUseCase {
  final ExecutiveRepository repository;

  GetExecutiveAddWalletDetailsUseCase(this.repository);

  Future<Either<Failure, ExecutiveAddWalletDetailsResponseModel>> call(String id) {
    return repository.getExecutiveAddWalletDetails(id);
  }
}
