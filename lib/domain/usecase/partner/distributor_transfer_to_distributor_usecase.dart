import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/add_wallet_response_model.dart';
import '../../repository/retailer_repo.dart';
import '../retailer/add_wallet_usecase.dart';

class DistributorTransferToDistributorUseCase {
  final RetailerRepository repository;

  DistributorTransferToDistributorUseCase(this.repository);

  Future<Either<Failure, AddWalletResponseModel>> call(AddWalletParams params) {
    return repository.distributorTransferToDistributor(params);
  }
}
