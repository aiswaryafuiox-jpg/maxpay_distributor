import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/add_wallet_details_response_model.dart';
import '../../repository/retailer_repo.dart';

class GetDisWalletDetailsUseCase {
  final RetailerRepository repository;

  GetDisWalletDetailsUseCase(this.repository);

  Future<Either<Failure, AddWalletDetailsResponseModel>> call(int id) {
    return repository.getDisWalletDetails(id);
  }
  
}
