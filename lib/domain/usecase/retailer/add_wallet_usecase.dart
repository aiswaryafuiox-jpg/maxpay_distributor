import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/add_wallet_response_model.dart';
import '../../repository/retailer_repo.dart';

class AddWalletUseCase {
  final RetailerRepository repository;

  AddWalletUseCase(this.repository);

  Future<Either<Failure, AddWalletResponseModel>> call(AddWalletParams params) {
    return repository.addWallet(params);
  }
}

class AddWalletParams {
  final String id;
  final String amount;

  AddWalletParams({
    required this.id,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
    };
  }
}
